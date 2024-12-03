import 'package:flutter/material.dart';
import 'package:kinemaapp/logic/provider/languageprovider.dart';
import 'package:kinemaapp/presentation/screens/auth/onboarding.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => LanguageProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kinema',
      home: OnboardingScreen(),
    );
  }
}
