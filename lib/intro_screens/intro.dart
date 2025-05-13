import 'dart:async';
import 'package:pretium_finance/constants/constant.dart';
import 'package:pretium_finance/intro_screens/leading_page.dart';
import 'package:flutter/material.dart';
import 'package:pretium_finance/providers/navigation_service_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dots_indicator/dots_indicator.dart';

class IntroScreens extends StatefulWidget {
  const IntroScreens({super.key});

  @override
  State<IntroScreens> createState() => _IntroScreensState();
}

class _IntroScreensState extends State<IntroScreens> {
  int currentIndex = 0;
  bool _isSettingPrefs = false;

  List<Widget> listPages = [
    const LeadingPage(
      icon: Icons.credit_card,
      title: 'Direct Pay',
      caption: 'Pay with crypto across Africa effortlessly',
    ),
    const LeadingPage(
      icon: Icons.receipt_long,
      title: 'Pay Bills',
      caption: 'Pay for utility services and earn rewards',
    ),
  ];

  @override
  void initState() {
    super.initState();
    Timer.run(() async {
      setIsNotNewInstall();
    });
  }

  Future<void> setIsNotNewInstall() async {
    if (_isSettingPrefs) return;
    _isSettingPrefs = true;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isNewInstall', false);
    _isSettingPrefs = false;
  }

  void _handleNextButton() {
    if (currentIndex == listPages.length - 1) {
      // Last page - navigate to login
      setIsNotNewInstall().then((_) {
        NavigationService.navigatorKey.currentState?.pushReplacementNamed(
          NavigationService.login,
        );
      });
    } else {
      setState(() {
        currentIndex++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Align(alignment: Alignment.center, child: listPages[currentIndex]),
          Positioned(
            bottom: size.height * 0.06,
            left: 30,
            right: 30,
            child: Column(
              children: [
                DotsIndicator(
                  dotsCount: listPages.length,
                  position: currentIndex.toDouble(),
                  decorator: DotsDecorator(
                    activeColor: AppColors.primaryColor,
                    color: AppColors.primaryColor.withOpacity(0.3),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _handleNextButton,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 60),
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 5,
                    shadowColor: AppColors.primaryLight,
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 2,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
