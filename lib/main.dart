import 'package:flutter/material.dart'; // Add this import for SystemChrome
import 'package:device_preview/device_preview.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';
import 'constants/app_colors.dart';
import 'services/auth_service.dart';
import 'services/database_service.dart';
import 'services/theme_service.dart';
import 'language/language_service.dart';
import 'language/language_controller.dart';
import 'ui/router/routing.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required for async operations

  // Initialize services
  Get.put(AuthService()); // Initialize AuthService
  await DatabaseService.database; // Initialize database
  await LanguageService.initialize(); // Initialize Language Service

  runApp(
    DevicePreview(
      enabled: true, // set false for release
      builder: (context) => const MyApp(),
    ),
  );
}

/// App root widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ CHANGED: Toastification must wrap the entire app
    return ToastificationWrapper(
      // <-- CHANGED
      child: GetBuilder<LanguageController>(
        init: Get.find<LanguageController>(),
        builder: (langCtrl) {
          return ValueListenableBuilder<ThemeMode>(
            valueListenable: ThemeService.themeMode,
            builder: (context, mode, child) {
              return GetMaterialApp(
                key: ValueKey(langCtrl.locale.value.toString()), // Force rebuild when locale changes
                title: Get.find<LanguageController>().tr('app_title'),
                debugShowCheckedModeBanner: false,

                // ✅ Required for DevicePreview
                useInheritedMediaQuery: true,
                locale: langCtrl.locale.value,
                builder: DevicePreview.appBuilder,

                theme: ThemeData(
                  textTheme: GoogleFonts.poppinsTextTheme(),
                  useMaterial3: true,
                  brightness: Brightness.light,
                  primaryColor: AppColors.accentOrange,
                  scaffoldBackgroundColor: AppColors.lightScreenBackground,
                  appBarTheme: const AppBarTheme(
                    backgroundColor: AppColors.lightScreenBackground,
                    foregroundColor: AppColors.lightPrimaryText,
                    elevation: 0,
                  ),
                ),

                darkTheme: ThemeData(
                  textTheme: GoogleFonts.poppinsTextTheme(),
                  useMaterial3: true,
                  brightness: Brightness.dark,
                  primaryColor: AppColors.accentOrange,
                  scaffoldBackgroundColor: AppColors.screenBackground,
                  appBarTheme: const AppBarTheme(
                    backgroundColor: AppColors.screenBackground,
                    foregroundColor: AppColors.primaryText,
                    elevation: 0,
                  ),
                ),

                themeMode: mode,
                // Use a custom initial route that checks auth state
                home: const AuthCheck(),
                getPages: AppRouter.routes,

                // Localization support
                supportedLocales: const [
                  Locale('en'), // English
                  Locale('ta'), // Tamil
                ],
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
              );
            },
          );
        },
      ),
    );
  }
}

/// Widget to check authentication state and redirect appropriately
class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  void initState() {
    super.initState();
    _checkAuthState();
  }

  void _checkAuthState() async {
    final authService = Get.find<AuthService>();
    final storedUser = await authService.getStoredUser();

    // Wait for the widget to be mounted before navigating
    if (mounted) {
      if (storedUser != null) {
        // User is logged in, navigate based on user type
        if (storedUser.isRestaurantOwner) {
          // Restaurant owner goes to admin screen
          Get.offAllNamed(AppRoutes.adminOrderManagement);
        } else {
          // Regular user goes to main screen (home tab)
          Get.offAllNamed(AppRoutes.main);
        }
      } else {
        // User is not logged in, go to splash screen
        Get.offAllNamed(AppRoutes.splash);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Show a simple loading indicator while checking auth state
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.restaurant_menu,
              size: 60,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(),
            const SizedBox(height: 20),
            Text(
              'Loading...',
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
