import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kinemaapp/logic/provider/languageprovider.dart';
import 'package:kinemaapp/presentation/screens/auth/signup.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  final List<String> _images = [
    'assets/images/onboard1.svg',
    'assets/images/onboard2.svg',
    'assets/images/onboard3.svg',
  ];

  int _currentPage = 0; // Track the current page

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _images.length,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    _images[index],
                    height: 300,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 20),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: Text(
                      languageProvider.texts['discover_movies'] ?? 'Discover movies effortlessly with Kinema.',
                      key: ValueKey(languageProvider.texts['discover_movies']),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  // Language selection button on the last screen
                  if (index == _images.length - 1)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: ElevatedButton(
                        onPressed: () => _showLanguageDialog(context, languageProvider),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                        ),
                        child: Text(
                          languageProvider.texts['choose_language'] ?? 'Choose Language',
                          style: const TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                'assets/images/logo.png',
                width: 100,
                height: 100,
              ),
            ),
          ),
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Center(
              child: _currentPage == _images.length - 1
                  ? ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const SignUpScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFaf00c2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      ),
                      child: Text(
                        languageProvider.texts['create_account'] ?? 'Create Account',
                        style: const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _images.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          width: _currentPage == index ? 12 : 8,
                          height: _currentPage == index ? 12 : 8,
                          decoration: BoxDecoration(
                            color: _currentPage == index ? Colors.white : Colors.grey,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
            ),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: IconButton(
              icon: Icon(Icons.language, color: Colors.white),
              onPressed: () => _showLanguageDialog(context, languageProvider),
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFF71027d),
    );
  }

  void _showLanguageDialog(BuildContext context, LanguageProvider languageProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(languageProvider.texts['choose_language'] ?? 'Choose Language'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('English'),
                onTap: () {
                  languageProvider.changeLanguage('en');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Zulu'),
                onTap: () {
                  languageProvider.changeLanguage('zu');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Xhosa'),
                onTap: () {
                  languageProvider.changeLanguage('xh');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Afrikaans'),
                onTap: () {
                  languageProvider.changeLanguage('af');
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
