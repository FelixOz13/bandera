import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:bandera/main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  bool _redirecting = false;
  late final TextEditingController _emailController = TextEditingController();
  late final StreamSubscription<AuthState> _authStateSubscription;

  Future<void> _signIn() async {
    try {
      setState(() {
        _isLoading = true;
      });
      await supabase.auth.signInWithOtp(
        email: _emailController.text.trim(),
        emailRedirectTo:
            kIsWeb ? null : 'io.supabase.bandera://login-callback',
      );
      if (mounted) {
  // Show SnackBar
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: const Text(
        'Ingresa tu Correo Electronico para Iniciar Session!',
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'Gajraj',
          fontSize: 18,
        ),
      ),
      backgroundColor: Colors.amber, // Optional: Set background color
    ),
  );

  // Clear Email Controller (after SnackBar display)
  _emailController.clear();
}
    } on AuthException catch (error) {
      if (mounted) {
        SnackBar(
          content: Text(error.message),
          backgroundColor: Theme.of(context).colorScheme.error,
        );
      }
    } catch (error) {
      if (mounted) {
        SnackBar(
          content: const Text('Ocurrio un Error Inesperado'),
          backgroundColor: Theme.of(context).colorScheme.error,
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    _authStateSubscription = supabase.auth.onAuthStateChange.listen((data) {
      if (_redirecting) return;
      final session = data.session;
      if (session != null) {
        _redirecting = true;
        Navigator.of(context).pushReplacementNamed('/account');
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _authStateSubscription.cancel();
    super.dispose();
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  title: const Text(
    ' 🎸  Inicia Sesión  🎸', // Changed "Session" to "Sesión" for Spanish
    style: TextStyle(
      color: Colors.white, // Set text color to white
      fontFamily: 'Gajraj',
    ),
  ),
  backgroundColor: Colors.black,
),

      body: Stack(
        children: [
          // Background image
           
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/universalbackground.jpg'), 
                fit: BoxFit.cover,
              ),
            ),
          ),
         
          // Login form
          ListView(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
            children: [
             const Text(
                'Verifica tu Correo Electronico para Iniciar Sesión', 
                 style: TextStyle(
                 color: Colors.white, 
                 fontFamily: 'Gajraj',
                 fontSize: 20, 
                 ),
               ),
              const SizedBox(height: 48),
             TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
              labelText: 'Correo Electronico',
              labelStyle: TextStyle(color: Colors.white, fontFamily: 'Gajraj', fontSize:26,),
               ),
              style: TextStyle(color: Colors.white, fontFamily: 'Gajraj'),
              ),
              
                      const SizedBox(height: 48),
              ElevatedButton(
                  onPressed: _isLoading ? null : _signIn,
                  child: Text(
                  _isLoading ? 'Cargando Detalles' : 'Verificar Correo Electronico',
                  style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Gajraj',
                 ),
                ),
                style: ElevatedButton.styleFrom(
                     backgroundColor: Colors.green, // Set button background color to red
                   foregroundColor: Colors.black, // Set text color to white
                  shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(10), // Add rounded corners
               ),
              ),
               ),
                ElevatedButton(
                   onPressed: _isLoading ? null : () => Navigator.of(context).pushReplacementNamed('/home'),
                    child: Text(
                     _isLoading ? 'Cargando Detalles' : 'Iniciar Sesión Sin Cuenta',
                      style: TextStyle(
                       color: Colors.black,
                        fontFamily: 'Gajraj',
                       ),
                     ),
                  style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow, // Set button background color to yellow
                  foregroundColor: Colors.black, // Set text color to black
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Add rounded corners
                  ),
                ),
              ),
              const SizedBox(height: 48),
              Container(
                        height: 350,
                        width: 370,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('images/banderalogo.jpeg'),
                            
                          ),
                        ),
                      ),
            ],
          ),
        ],
      ),
    );
  }
}

