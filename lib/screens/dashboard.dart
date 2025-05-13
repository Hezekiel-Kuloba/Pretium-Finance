import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pretium_finance/constants/constant.dart';
import 'package:pretium_finance/providers/auth.dart';
import 'package:pretium_finance/providers/locale_provider.dart'; // Import the locale provider
import 'package:pretium_finance/widgets/bottom_nav.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final translations = AppLocalizations.of(context)!;
    final currentLocale = ref.watch(
      appLanguageProvider,
    ); // Watch the current language

    return Scaffold(
      appBar: AppBar(
        title: Text(
          translations.helloUser('Hezekiel') + ' ✋',
          style: GoogleFonts.cabin(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              'H',
              style: GoogleFonts.cabin(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              // Handle notification press
            },
          ),
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onSelected: (value) {
              if (value == 'logout') {
                Future.delayed(Duration.zero, () {
                  ref.read(userProvider.notifier).logout();
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/login',
                    (route) => false,
                  );
                });
              } else if (value == 'en') {
                ref
                    .read(appLanguageProvider.notifier)
                    .changeLanguage(const Locale('en'));
              } else if (value == 'sw') {
                ref
                    .read(appLanguageProvider.notifier)
                    .changeLanguage(const Locale('sw'));
              }
            },
            itemBuilder:
                (context) => [
                  PopupMenuItem(
                    value: 'en',
                    child: Row(
                      children: [
                        Icon(
                          currentLocale.languageCode == 'en'
                              ? Icons.check_circle
                              : Icons.circle_outlined,
                          color:
                              currentLocale.languageCode == 'en'
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.grey,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(translations.languageEnglish),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'sw',
                    child: Row(
                      children: [
                        Icon(
                          currentLocale.languageCode == 'sw'
                              ? Icons.check_circle
                              : Icons.circle_outlined,
                          color:
                              currentLocale.languageCode == 'sw'
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.grey,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(translations.languageSwahili),
                      ],
                    ),
                  ),
                  const PopupMenuDivider(),
                  PopupMenuItem(
                    value: 'logout',
                    child: Text(translations.logout),
                  ),
                ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              // Balance Section
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.primary.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.remove_red_eye,
                            color: Colors.white.withOpacity(0.8),
                          ),
                          onPressed: () {
                            // Toggle amount visibility
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.primary.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.account_balance_wallet,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            translations.walletBalance,
                            style: GoogleFonts.cabin(
                              fontSize: 16,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'KES 0.00',
                            style: GoogleFonts.cabin(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '\$ 0.00',
                            style: GoogleFonts.cabin(
                              fontSize: 16,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Divider(height: 1, color: AppColors.dividerColor),
              const SizedBox(height: 24),
              // Financial Services Container
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          translations.financialServices,
                          style: GoogleFonts.cabin(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        Text(
                          translations.countryKenya,
                          style: GoogleFonts.cabin(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 120,
                      child: GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 3,
                        childAspectRatio: 0.9,
                        children: [
                          _buildServiceItem(
                            context,
                            icon: Icons.send,
                            label: translations.sendMoney,
                          ),
                          _buildServiceItem(
                            context,
                            icon: Icons.shopping_basket,
                            label: translations.buyGoods,
                          ),
                          _buildServiceItem(
                            context,
                            icon: Icons.receipt,
                            label: translations.paybill,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: _buildServiceItem(
                        context,
                        icon: Icons.phone_android,
                        label: translations.airtime,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Divider(height: 1, color: AppColors.dividerColor),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    translations.recentTransactions,
                    style: GoogleFonts.cabin(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      translations.seeAll,
                      style: GoogleFonts.cabin(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.primary,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.receipt_long,
                      size: 60,
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withOpacity(0.3),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      translations.noRecentTransactions,
                      style: GoogleFonts.cabin(
                        fontSize: 16,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const AppBottomNavigationBar(),
    );
  }

  Widget _buildServiceItem(
    BuildContext context, {
    required IconData icon,
    required String label,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            size: 30,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.cabin(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
