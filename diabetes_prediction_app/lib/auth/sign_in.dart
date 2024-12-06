import 'package:flutter/material.dart';
import 'package:diabetes_prediction_app/auth/sign_up.dart';
import 'package:diabetes_prediction_app/widgets/custom_text_field.dart';
import 'package:diabetes_prediction_app/home_page.dart';
import 'package:diabetes_prediction_app/widgets/social_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _signIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Ambil email dan password yang tersimpan
    String? savedEmail = prefs.getString('email');
    String? savedPassword = prefs.getString('password');

    // Verifikasi email dan password
    if (_emailController.text == savedEmail && _passwordController.text == savedPassword) {
      // Jika cocok, arahkan ke halaman HomePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      // Jika tidak cocok, tampilkan pesan error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid email or password')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                const Text(
                  'Login to your Account',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),
                CustomTextField(
                  label: 'Email',
                  controller: _emailController,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: 'Password',
                  controller: _passwordController,
                  obscureText: true,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _signIn,
                  child: const Text('Sign In', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50), backgroundColor: Color(0xFF1a237e), // Warna latar belakang tombol biru
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0), // Tombol dengan sudut bulat
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Center(child: Text('Or sign in with')),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialButton(
                      icon: Icons.g_mobiledata,
                      onPressed: () {},
                    ),
                    const SizedBox(width: 16),
                    SocialButton(
                      icon: Icons.facebook,
                      onPressed: () {},
                    ),
                    const SizedBox(width: 16),
                    SocialButton(
                      icon: Icons.messenger_outline,
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpPage(),
                        ),
                      );
                    },
                    child: const Text("Don't have an account? Sign up"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
