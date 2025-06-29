import 'package:get/get.dart';
import 'package:wallet_hunter/app/controllers/registration_controller.dart';

class RegistrationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegistrationController>(() => RegistrationController());
  }
}
