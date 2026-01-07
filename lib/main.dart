import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'constants/app_colors.dart';
import 'services/theme_service.dart';
import 'ui/router/routing.dart';

void main() {
  runApp(const MyApp());
}

/// Lightweight wrapper to keep the entrypoint stable for tests.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeService.themeMode,
      builder: (context, mode, _) {
        return GetMaterialApp(
          title: 'Hostelia',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.light,
            primaryColor: AppColors.accentOrange,
            scaffoldBackgroundColor: AppColors.lightScreenBackground,
            appBarTheme: const AppBarTheme(
              backgroundColor: AppColors.lightScreenBackground,
              foregroundColor: AppColors.lightPrimaryText,
              elevation: 0,
            ),
            textTheme: const TextTheme(
              bodyMedium: TextStyle(color: AppColors.lightPrimaryText),
            ),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            primaryColor: AppColors.accentOrange,
            scaffoldBackgroundColor: AppColors.screenBackground,
            appBarTheme: const AppBarTheme(
              backgroundColor: AppColors.screenBackground,
              foregroundColor: AppColors.primaryText,
              elevation: 0,
            ),
            textTheme: const TextTheme(
              bodyMedium: TextStyle(color: AppColors.primaryText),
            ),
          ),
          themeMode: mode,
          initialRoute: AppRoutes.login,
          getPages: AppRouter.routes,
        );
      },
    );
  }
}
