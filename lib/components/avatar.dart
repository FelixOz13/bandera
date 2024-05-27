import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:bandera/main.dart';

class Avatar extends StatefulWidget {
  const Avatar({
    super.key,
    required this.imageUrl,
    required this.onUpload,
  });

  final String? imageUrl;
  final void Function(String) onUpload;

  @override
  State<Avatar> createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
  if (widget.imageUrl == null || widget.imageUrl!.isEmpty)
    Stack(
      children: [
        // Round container for the placeholder
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage('images/ufoprofile.jpeg'), // Replace with your asset path
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Camera icon button positioned on top
        Positioned(
          bottom: 10, // Adjust position as needed
          right: 10,  // Adjust position as needed
          child: Material(
            color: Colors.transparent, // Transparent background
            child: InkWell(
              borderRadius: BorderRadius.circular(50), // Match container border radius
              onTap: _isLoading ? null : _upload,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.white, // Adjust icon color as needed
                ),
              ),
            ),
          ),
        ),
      ],
    )
  else
    Image.network(
      widget.imageUrl!,
      width: 150,
      height: 150,
      fit: BoxFit.cover,
    ),
  ElevatedButton(
    onPressed: _isLoading ? null : _upload,
    child: const Text('Sube una Imagen de Perfil'),
  ),
],

    );
  }

  Future<void> _upload() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 300,
      maxHeight: 300,
    );
    if (imageFile == null) {
      return;
    }
    setState(() => _isLoading = true);

    try {
      final bytes = await imageFile.readAsBytes();
      final fileExt = imageFile.path.split('.').last;
      final fileName = '${DateTime.now().toIso8601String()}.$fileExt';
      final filePath = fileName;
      await supabase.storage.from('avatars').uploadBinary(
            filePath,
            bytes,
            fileOptions: FileOptions(contentType: imageFile.mimeType),
          );
      final imageUrlResponse = await supabase.storage
          .from('avatars')
          .createSignedUrl(filePath, 60 * 60 * 24 * 365 * 10);
      widget.onUpload(imageUrlResponse);
    } on StorageException catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.message),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Unexpected error occurred'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }

    setState(() => _isLoading = false);
  }
}