import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Import image_picker
import 'package:permission_handler/permission_handler.dart'; // Import permission_handler
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences
import 'auth/sign_in.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // ignore: unused_field
  String? _imagePath; // Path of the selected image
  final ImagePicker _picker = ImagePicker(); // ImagePicker instance

  // Load profile data and image path from SharedPreferences
  Future<Map<String, String>> _getUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? email = prefs.getString('email') ?? 'No email found';
    String? imagePath = prefs.getString('imagePath');

    return {
      'email': email,
      'imagePath': imagePath ?? '',
    };
  }

  // Function to check and request permissions
  Future<void> _checkPermissions() async {
    // Check for camera and storage permissions
    var cameraStatus = await Permission.camera.status;
    var storageStatus = await Permission.storage.status;

    if (!cameraStatus.isGranted) {
      await Permission.camera.request(); // Request camera permission
    }

    if (!storageStatus.isGranted) {
      await Permission.storage.request(); // Request storage permission
    }
  }

  // Function to pick an image from gallery or camera
  Future<void> _pickImage() async {
    await _checkPermissions(); // Ensure permissions are granted

    final XFile? image = await _picker.pickImage(source: ImageSource.gallery); // Can use ImageSource.camera for camera
    if (image != null) {
      setState(() {
        _imagePath = image.path; // Save image path
      });

      // Save image path to SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('imagePath', image.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, String>>(
      future: _getUserProfile(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text('Error fetching user data'));
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return const Center(child: Text('No user data available'));
        }

        var userProfile = snapshot.data!;
        String email = userProfile['email'] ?? 'Tidak ada';
        String imagePath = userProfile['imagePath'] ?? ''; // Get the stored image path

        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Profile image (if available)
                CircleAvatar(
                  radius: 50,
                  backgroundImage: imagePath.isNotEmpty
                      ? FileImage(File(imagePath)) // Display the selected image
                      : const NetworkImage('https://www.example.com/profile-pic.jpg'), // Placeholder
                  backgroundColor: Colors.grey[200],
                ),
                const SizedBox(height: 20),
                Text(
                  email,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: _pickImage, // Pick image when button pressed
                  child: const Text('Change Profile Picture', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Button color
                    minimumSize: const Size(double.infinity, 50),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const SignInPage()),
                    );
                  },
                  child: const Text('Logout', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
