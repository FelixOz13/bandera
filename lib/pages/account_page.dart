import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:bandera/components/avatar.dart';
import 'package:bandera/main.dart';
import 'package:bandera/pages/account_page.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final _usernameController = TextEditingController();
  final _websiteController = TextEditingController();

  String? _avatarUrl;
  var _loading = true;

  /// Called once a user id is received within `onAuthenticated()`
  Future<void> _getProfile() async {
    setState(() {
      _loading = true;
    });

    try {
      final userId = supabase.auth.currentSession!.user.id;
      final data = await supabase
          .from('profiles')
          .select()
          .eq('id', userId)
          .single();
      _usernameController.text = (data['username'] ?? '') as String;
      _websiteController.text = (data['website'] ?? '') as String;
      _avatarUrl = (data['avatar_url'] ?? '') as String;
    } on PostgrestException catch (error) {
      _showSnackBar(error.message, isError: true);
    } catch (error) {
      _showSnackBar('Unexpected error occurred', isError: true);
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  /// Called when user taps `Update` button
  Future<void> _updateProfile() async {
    setState(() {
      _loading = true;
    });
    final userName = _usernameController.text.trim();
    final website = _websiteController.text.trim();
    final user = supabase.auth.currentUser;
    final updates = {
      'id': user!.id,
      'username': userName,
      'website': website,
      'updated_at': DateTime.now().toIso8601String(),
    };
    try {
      await supabase.from('profiles').upsert(updates);
      if (mounted) {
        const SnackBar(
          content: Text('Successfully updated profile!'),
        );
      }
    } on PostgrestException catch (error) {
      if (mounted) {
        SnackBar(
          content: Text(error.message),
          backgroundColor: Theme.of(context).colorScheme.error,
        );
      }
    } catch (error) {
      if (mounted) {
        SnackBar(
          content: const Text('Unexpected error occurred'),
          backgroundColor: Theme.of(context).colorScheme.error,
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  Future<void> _signOut() async {
    try {
      await supabase.auth.signOut();
      Navigator.of(context).pushReplacementNamed('/login');
    } on AuthException catch (error) {
      _showSnackBar(error.message, isError: true);
    } catch (error) {
      _showSnackBar('Unexpected error occurred', isError: true);
    }
  }



  /// Called when image has been uploaded to Supabase storage from within Avatar widget
  Future<void> _onUpload(String imageUrl) async {
    try {
      final userId = supabase.auth.currentUser!.id;
      await supabase.from('profiles').upsert({
        'id': userId,
        'avatar_url': imageUrl,
      });
      _showSnackBar('Updated your profile image!');
    } on PostgrestException catch (error) {
      _showSnackBar(error.message, isError: true);
    } catch (error) {
      _showSnackBar('Unexpected error occurred', isError: true);
    }
    setState(() {
      _avatarUrl = imageUrl;
    });
  }

  void _showSnackBar(String message, {bool isError = false}) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: isError ? Theme.of(context).colorScheme.error : null,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

 
  @override
  void initState() {
    super.initState();
    _getProfile();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _websiteController.dispose();
    super.dispose();
  }
  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text(
        ' 🎸 Perfil 🎸', // Changed "Session" to "Sesión" for Spanish
        style: TextStyle(
          color: Colors.white, // Set text color to white
          fontFamily: 'Gajraj',
        ),
      ),
      backgroundColor: Colors.black,
       iconTheme: IconThemeData(
    color: Colors.white, // Set the back arrow color to white
  ),
    ),
    body: _loading
        ? const Center(child: CircularProgressIndicator())
        : Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/universalbackground.jpg'), // Set background image
                fit: BoxFit.cover,
              ),
            ),
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
              children: [
                Avatar(
                  imageUrl: _avatarUrl,
                  onUpload: _onUpload,
                ),
                const SizedBox(height: 18),
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre o Apodo 🎸🎸',
                    labelStyle: TextStyle(color: Colors.white, fontFamily: 'Gajraj', fontSize: 20),
                    hintStyle: TextStyle(color: Colors.white, fontFamily: 'Gajraj'),
                  ),
                  style: TextStyle(color: Colors.green, fontFamily: 'Gajraj'),
                ),
                const SizedBox(height: 18),
                TextFormField(
                  controller: _websiteController,
                  decoration: const InputDecoration(
                    labelText: 'Tipo de Musica Favorita 🎸🎸🎸 ',
                    labelStyle: TextStyle(color: Colors.white, fontFamily: 'Gajraj', fontSize: 20),
                    hintStyle: TextStyle(color: Colors.white, fontFamily: 'Gajraj'),
                  ),
                  style: TextStyle(color: Colors.green, fontFamily: 'Gajraj'),
                ),
                const SizedBox(height: 18),
                Container(
                  height: 250,
                  
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/banderalogo.jpeg'),
                     
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: _loading ? null : _updateProfile,
                  child: Text(
                    _loading ? 'Guardando...' : 'Actualizar',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Gajraj',
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Set button background color to green
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Add rounded corners
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: _signOut,
                  child: Text(
                    'Cerrar Sesión',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Gajraj',
                      fontSize: 16, // Adjust font size as needed
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Set button background color to white
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Add rounded corners
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: _signOut,
                  child: Text(
                    'Eliminar Cuenta',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Gajraj',
                      fontSize: 16, // Adjust font size as needed
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Set button background color to red
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Add rounded corners
                    ),
                  ),
                ),
              ],
            ),
          ),
  );
}
}