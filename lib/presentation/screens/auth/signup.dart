import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kinemaapp/presentation/screens/home/homepage.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isPasswordObscured = true;
  bool _isConfirmPasswordObscured = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFaf00c2), // Purple
              Color(0xFF71027d), // Dark Purple
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Header
                  const Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Text Fields
                  _buildTextField(
                    label: 'Username',
                    icon: Icons.person,
                    isPassword: false,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    label: 'Email',
                    icon: Icons.email,
                    isPassword: false,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    label: 'Password',
                    icon: Icons.lock,
                    isPassword: true,
                    isObscured: _isPasswordObscured,
                    toggleObscure: () {
                      setState(() {
                        _isPasswordObscured = !_isPasswordObscured;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    label: 'Confirm Password',
                    icon: Icons.lock,
                    isPassword: true,
                    isObscured: _isConfirmPasswordObscured,
                    toggleObscure: () {
                      setState(() {
                        _isConfirmPasswordObscured = !_isConfirmPasswordObscured;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Colors.white38, // Purple
                          Colors.white, // Dark Purple
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent, // Transparent to show gradient
                        shadowColor: Colors.transparent, // Remove default shadow
                        minimumSize: const Size(double.infinity, 50), // Full width button
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Social Buttons
                  _buildSocialButton(
                    icon: FontAwesomeIcons.google,
                    label: 'Sign up with Google',
                    gradientColors: [
                      Color(0xFFf85032), // Vivid Red
                      Color(0xFFf16f5c) // Soft Red Accent
                    ],
                    onTap: () {
                      // Add Google sign-up logic here
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildSocialButton(
                    icon: FontAwesomeIcons.apple,
                    label: 'Sign up with Apple',
                    gradientColors: [Colors.black, Colors.grey.shade800],
                    onTap: () {
                      // Add Apple sign-up logic here
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildSocialButton(
                    icon: FontAwesomeIcons.facebook,
                    label: 'Sign up with Facebook',
                    gradientColors: [Color(0xFF3b5998), Color(0xFF8b9dc3)],
                    onTap: () {
                      // Add Facebook sign-up logic here
                    },
                  ),
                  const SizedBox(height: 32),

                  // Divider with OR
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.white.withOpacity(0.5),
                          thickness: 1,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'OR',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.white.withOpacity(0.5),
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Sign In Link
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/signin');
                    },
                    child: const Text(
                      'Already have an account? Sign In',
                      style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required IconData icon,
    required bool isPassword,
    bool isObscured = false,
    VoidCallback? toggleObscure,
  }) {
    return TextField(
      obscureText: isPassword ? isObscured : false,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        prefixIcon: Icon(icon, color: Colors.white),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  isObscured ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white,
                ),
                onPressed: toggleObscure,
              )
            : null,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String label,
    required List<Color> gradientColors,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FaIcon(icon, color: Colors.white),
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
