import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kinemaapp/presentation/screens/auth/signup.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> _images = [
    'assets/images/onboard1.svg',
    'assets/images/onboard2.svg',
    'assets/images/onboard3.svg',
  ];

  final List<String> _texts = [
    'Discover movies effortlessly with Kinema.',
    'Get detailed information and reviews.',
    'Rate and share your favorite movies!',
  ];

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _images.length,
            onPageChanged: _onPageChanged,
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
                      _texts[index],
                      key: ValueKey(_texts[index]),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
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
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 30,
                        ),
                      ),
                      child: const Text(
                        'Create Account',
                        style: TextStyle(fontSize: 18, color: Colors.white),
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
        ],
      ),
      backgroundColor: const Color(0xFF71027d),
    );
  }
}
