import 'package:flutter/material.dart';
import 'package:pretium_finance/constants/constant.dart';

class LeadingPage extends StatelessWidget {
  const LeadingPage({
    super.key,
    this.image,
    required this.title,
    required this.caption,
    this.icon,
  });

  final String? image;
  final String title;
  final String caption;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null)
            Container(
              decoration: BoxDecoration(
                color: theme.primaryColor.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon!, size: 120, color: AppColors.primaryColor),
            )
          else if (image != null)
            Image.asset(image!),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              caption,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: AppColors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
