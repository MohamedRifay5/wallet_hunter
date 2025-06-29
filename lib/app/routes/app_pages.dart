import 'package:get/get.dart';
import '../pages/splash_page.dart';
import '../pages/auth/login_page.dart';
import '../pages/auth/otp_verification_page.dart';
import '../pages/registration/head_registration_page.dart';
import '../pages/registration/family_member_registration_page.dart';
import '../pages/registration/edit_family_member_page.dart';
import '../pages/family_tree/family_tree_page.dart';
import '../pages/dashboard/dashboard_page.dart';
import '../bindings/auth_binding.dart';
import '../bindings/registration_binding.dart';
import '../bindings/family_tree_binding.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => const SplashPage(),
    ),
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => const LoginPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.OTP_VERIFICATION,
      page: () => const OTPVerificationPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.HEAD_REGISTRATION,
      page: () => const HeadRegistrationPage(),
      binding: RegistrationBinding(),
    ),
    GetPage(
      name: AppRoutes.FAMILY_MEMBER_REGISTRATION,
      page: () => const FamilyMemberRegistrationPage(),
      binding: RegistrationBinding(),
    ),
    GetPage(
      name: AppRoutes.FAMILY_TREE,
      page: () => const FamilyTreePage(),
      binding: FamilyTreeBinding(),
    ),
    GetPage(
      name: AppRoutes.DASHBOARD,
      page: () => const DashboardPage(),
      binding: RegistrationBinding(),
    ),
    GetPage(
      name: AppRoutes.EDIT_FAMILY_MEMBER,
      page: () => const EditFamilyMemberPage(),
      binding: RegistrationBinding(),
    ),
  ];
}
