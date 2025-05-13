// app_bottom_nav_bar.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pretium_finance/constants/constant.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.account_balance_wallet),
          label: '',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.qr_code_scanner), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.article), label: ''),
      ],
      currentIndex: 0,
      onTap: (index) {
        // Handle navigation
      },
      type: BottomNavigationBarType.fixed,
      backgroundColor: Theme.of(context).colorScheme.background,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      unselectedItemColor: AppColors.grey,
      elevation: 0,
      selectedLabelStyle: GoogleFonts.cabin(fontSize: 12),
      unselectedLabelStyle: GoogleFonts.cabin(fontSize: 12),
    );
  }
}
