import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wallet_hunter/app/routes/app_pages.dart';
import 'package:wallet_hunter/app/routes/app_routes.dart';
import 'package:wallet_hunter/app/services/storage_service.dart';
import 'package:wallet_hunter/app/controllers/auth_controller.dart';
import 'package:wallet_hunter/app/controllers/registration_controller.dart';

/// Main entry point of the Wallet Hunter application
/// Initializes GetStorage, dependency injection, and app configuration
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize GetStorage for local data persistence
  await GetStorage.init();

  // Initialize core services and controllers
  await initServices();

  runApp(const WalletHunterApp());
}

/// Initialize all required services and controllers
/// This ensures proper dependency injection setup
Future<void> initServices() async {
  // Initialize storage service first
  Get.put(StorageService(), permanent: true);

  // Initialize controllers
  Get.put(AuthController(), permanent: true);
  Get.put(RegistrationController(), permanent: true);
}

class WalletHunterApp extends StatelessWidget {
  const WalletHunterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Wallet Hunter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF4A90E2),
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        visualDensity: VisualDensity.adaptivePlatformDensity,

        // App Bar Theme
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF4A90E2),
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
        ),

        // Elevated Button Theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4A90E2),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        // Text Button Theme
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFF4A90E2),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        // Input Decoration Theme
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey[50],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF4A90E2), width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.red[300]!),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          labelStyle: TextStyle(color: Colors.grey[600], fontSize: 14),
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
        ),

        // Card Theme
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 4,
          shadowColor: Colors.grey.withOpacity(0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),

        // Dialog Theme
        dialogTheme: DialogThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.white,
          elevation: 8,
        ),

        // Snackbar Theme
        snackBarTheme: SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: const Color(0xFF4A90E2),
          contentTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),

        // Text Theme
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2C3E50),
          ),
          headlineMedium: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2C3E50),
          ),
          headlineSmall: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2C3E50),
          ),
          titleLarge: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2C3E50),
          ),
          titleMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2C3E50),
          ),
          titleSmall: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF2C3E50),
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            color: Color(0xFF2C3E50),
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            color: Color(0xFF2C3E50),
          ),
          bodySmall: TextStyle(
            fontSize: 12,
            color: Color(0xFF7F8C8D),
          ),
        ),

        // Color Scheme
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4A90E2),
          primary: const Color(0xFF4A90E2),
          secondary: const Color(0xFF4CAF50),
          tertiary: const Color(0xFFFF9800),
          surface: Colors.white,
          background: const Color(0xFFF5F7FA),
        ),
      ),
      initialRoute: AppRoutes.SPLASH,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
