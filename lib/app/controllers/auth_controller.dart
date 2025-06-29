import 'package:get/get.dart';
import 'package:wallet_hunter/app/services/storage_service.dart';
import 'package:wallet_hunter/app/models/user_model.dart';
import 'package:wallet_hunter/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:wallet_hunter/app/controllers/registration_controller.dart';

class AuthController extends GetxController {
  final StorageService _storageService = Get.find<StorageService>();

  final RxBool isLoading = false.obs;
  final RxBool isOtpSent = false.obs;
  final RxString phoneNumber = ''.obs;
  final RxString otp = ''.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final isLoggedIn = await _storageService.isLoggedIn();
    if (isLoggedIn) {
      Get.offAllNamed(AppRoutes.DASHBOARD);
    }
  }

  Future<void> sendOTP(String phoneNumber) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      if (phoneNumber.isEmpty) {
        errorMessage.value = 'Please enter a valid phone number';
        return;
      }

      // Check if user exists first
      final existingUser = await _storageService.getHeadByPhone(phoneNumber);

      // For demo purposes, always use OTP "00000"
      const demoOTP = '00000';

      // Save the demo OTP
      await _storageService.saveOTP(phoneNumber, demoOTP);

      // Set the phone number in registration controller
      final registrationController = Get.find<RegistrationController>();
      registrationController.setPhoneNumber(phoneNumber);

      String message = 'Demo OTP: $demoOTP\nUse this OTP for testing purposes.';

      if (existingUser != null) {
        message += '\n\nWelcome back! You\'re already registered.';
        Get.snackbar(
          'Welcome Back!',
          message,
          backgroundColor: Colors.green[100],
          colorText: Colors.green[800],
          duration: const Duration(seconds: 6),
          snackPosition: SnackPosition.TOP,
        );
      } else {
        message += '\n\nNew user? You\'ll be redirected to registration.';
        Get.snackbar(
          'OTP Sent',
          message,
          backgroundColor: Colors.blue[100],
          colorText: Colors.blue[800],
          duration: const Duration(seconds: 6),
          snackPosition: SnackPosition.TOP,
        );
      }

      Get.toNamed(AppRoutes.OTP_VERIFICATION);
    } catch (e) {
      errorMessage.value = 'Failed to send OTP. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyOTP(String otp) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final savedOTPData = await _storageService.getOTP();
      if (savedOTPData == null) {
        errorMessage.value = 'No OTP found. Please request a new OTP.';
        return;
      }

      // For demo purposes, accept "00000" as valid OTP
      if (otp == '00000' || otp == savedOTPData['otp']) {
        // Check if user exists
        final existingUser = await _storageService.getHeadByPhone(savedOTPData['phoneNumber']!);

        if (existingUser != null) {
          // User exists, log them in
          await _storageService.setCurrentUser(existingUser);

          // Update the registration controller with existing user data
          final registrationController = Get.find<RegistrationController>();
          registrationController.currentHead.value = existingUser;
          await registrationController.loadFamilyMembers(existingUser.id!);

          Get.offAllNamed(AppRoutes.DASHBOARD);

          Get.snackbar(
            'Welcome Back!',
            'Successfully logged in as ${existingUser.name}',
            backgroundColor: Colors.green[100],
            colorText: Colors.green[800],
            duration: const Duration(seconds: 3),
            snackPosition: SnackPosition.TOP,
          );
        } else {
          // New user, redirect to head registration
          Get.offAllNamed(AppRoutes.HEAD_REGISTRATION);

          Get.snackbar(
            'New User',
            'Please complete your registration to get started',
            backgroundColor: Colors.blue[100],
            colorText: Colors.blue[800],
            duration: const Duration(seconds: 3),
            snackPosition: SnackPosition.TOP,
          );
        }

        await _storageService.clearOTP();
      } else {
        errorMessage.value = 'Invalid OTP. Please enter the correct OTP.';
      }
    } catch (e) {
      errorMessage.value = 'Failed to verify OTP. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resendOTP() async {
    if (phoneNumber.value.isNotEmpty) {
      await sendOTP(phoneNumber.value);
    }
  }

  Future<void> logout() async {
    await _storageService.logout();
    Get.offAllNamed(AppRoutes.LOGIN);
  }

  String _generateOTP() {
    // Generate a 6-digit OTP
    return (100000 + (DateTime.now().millisecondsSinceEpoch % 900000)).toString();
  }

  void clearError() {
    errorMessage.value = '';
  }
}
