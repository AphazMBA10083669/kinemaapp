import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kinemaapp/presentation/screens/auth/onboarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToOnboarding();
  }

  void _navigateToOnboarding() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    });
  }

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png', // Path to your logo in the assets folder
                width: 150, // Adjust as needed
                height: 150, // Adjust as needed
              ),
              Text(
                "KINEMA",
                style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
