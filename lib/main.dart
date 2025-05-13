import 'package:pretium_finance/providers/auth.dart';
import 'package:pretium_finance/providers/locale_provider.dart';
import 'package:pretium_finance/providers/navigation_service_provider.dart';
import 'package:pretium_finance/utilities/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(appLanguageProvider);
    final brightness = WidgetsBinding.instance.window.platformBrightness;
    final navigationService = ref.read(navigationServiceProvider);

    return MaterialApp(
      title: 'Pretium',
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode:
          brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light,
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      initialRoute: NavigationService.splash,
      onGenerateRoute: navigationService.generateRoute,
      navigatorKey: NavigationService.navigatorKey,
    );
  }
}

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkInitialStatus();
  }

  Future<void> _checkInitialStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final newInstallStatus = prefs.getBool('isNewInstall') ?? true;
    final loggedInStatus =
        await ref.read(userProvider.notifier).checkLoginStatus();

    if (!mounted) return;

    final route = _determineNextRoute(newInstallStatus, loggedInStatus);
    Future.delayed(const Duration(seconds: 5), () {
      NavigationService.navigatorKey.currentState?.pushReplacementNamed(route);
    });
  }

  String _determineNextRoute(bool isNewInstall, bool isLoggedIn) {
    if (isNewInstall) {
      return NavigationService.intro;
    } else {
      return isLoggedIn ? NavigationService.dashboard : NavigationService.login;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/pretium8.png', width: 100, height: 100),
            const SizedBox(height: 20),
            Text(
              'Pretium',
              style: theme.textTheme.displayLarge?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 30),
            CircularProgressIndicator(color: theme.colorScheme.primary),
          ],
        ),
      ),
    );
  }
}
