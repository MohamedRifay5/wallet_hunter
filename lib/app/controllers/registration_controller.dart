import 'package:get/get.dart';
import 'package:wallet_hunter/app/services/storage_service.dart';
import 'package:wallet_hunter/app/models/user_model.dart';
import 'package:wallet_hunter/app/routes/app_routes.dart';

class RegistrationController extends GetxController {
  final StorageService _storageService = Get.find<StorageService>();

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxList<UserModel> familyMembers = <UserModel>[].obs;
  final Rx<UserModel?> currentHead = Rx<UserModel?>(null);

  // Form controllers for head registration
  final RxString name = ''.obs;
  final RxInt age = 0.obs;
  final RxString gender = ''.obs;
  final RxString maritalStatus = ''.obs;
  final RxString occupation = ''.obs;
  final RxString samajName = ''.obs;
  final RxString qualification = ''.obs;
  final Rx<DateTime?> birthDate = Rx<DateTime?>(null);
  final RxString bloodGroup = ''.obs;
  final RxString exactNatureOfDuties = ''.obs;
  final RxString email = ''.obs;
  final RxString phoneNumber = ''.obs;
  final RxString alternativeNumber = ''.obs;
  final RxString landlineNumber = ''.obs;
  final RxString socialMediaLink = ''.obs;
  final RxString flatNumber = ''.obs;
  final RxString buildingName = ''.obs;
  final RxString doorNumber = ''.obs;
  final RxString streetName = ''.obs;
  final RxString landmark = ''.obs;
  final RxString city = ''.obs;
  final RxString district = ''.obs;
  final RxString state = ''.obs;
  final RxString nativeCity = ''.obs;
  final RxString nativeState = ''.obs;
  final RxString country = ''.obs;
  final RxString pincode = ''.obs;
  final RxString photoUrl = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadCurrentUser();
  }

  Future<void> loadCurrentUser() async {
    final user = await _storageService.getCurrentUser();
    if (user != null) {
      currentHead.value = user;
      if (user.isHead) {
        await loadFamilyMembers(user.id!);
      }
    }
  }

  Future<void> loadFamilyMembers(String headId) async {
    final members = await _storageService.getFamilyMembers(headId);
    familyMembers.value = members;
  }

  Future<void> registerHead() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      // Validate required fields
      if (!_validateHeadForm()) {
        return;
      }

      final head = UserModel(
        id: _storageService.generateId(),
        name: name.value,
        age: age.value,
        gender: gender.value,
        maritalStatus: maritalStatus.value,
        occupation: occupation.value,
        samajName: samajName.value,
        qualification: qualification.value,
        birthDate: birthDate.value!,
        bloodGroup: bloodGroup.value,
        exactNatureOfDuties: exactNatureOfDuties.value,
        email: email.value,
        phoneNumber: phoneNumber.value,
        alternativeNumber: alternativeNumber.value.isEmpty ? null : alternativeNumber.value,
        landlineNumber: landlineNumber.value.isEmpty ? null : landlineNumber.value,
        socialMediaLink: socialMediaLink.value.isEmpty ? null : socialMediaLink.value,
        flatNumber: flatNumber.value,
        buildingName: buildingName.value,
        doorNumber: doorNumber.value,
        streetName: streetName.value,
        landmark: landmark.value.isEmpty ? null : landmark.value,
        city: city.value,
        district: district.value,
        state: state.value,
        nativeCity: nativeCity.value,
        nativeState: nativeState.value,
        country: country.value,
        pincode: pincode.value,
        photoUrl: photoUrl.value.isEmpty ? null : photoUrl.value,
        relationWithHead: null,
        isHead: true,
        headId: null,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await _storageService.saveUser(head);
      await _storageService.setCurrentUser(head);

      // Update the current head value in the controller
      currentHead.value = head;

      // Clear the form
      clearForm();

      Get.offAllNamed(AppRoutes.DASHBOARD);
    } catch (e) {
      errorMessage.value = 'Failed to register. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addFamilyMember(UserModel member) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      if (currentHead.value == null) {
        errorMessage.value = 'No head found. Please register as head first.';
        return;
      }

      final familyMember = member.copyWith(
        id: _storageService.generateId(),
        headId: currentHead.value!.id,
        isHead: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await _storageService.saveUser(familyMember);
      await loadFamilyMembers(currentHead.value!.id!);

      Get.back();
    } catch (e) {
      errorMessage.value = 'Failed to add family member. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateFamilyMember(UserModel member) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final updatedMember = member.copyWith(
        updatedAt: DateTime.now(),
      );

      await _storageService.saveUser(updatedMember);
      await loadFamilyMembers(currentHead.value!.id!);

      Get.back();
    } catch (e) {
      errorMessage.value = 'Failed to update family member. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteFamilyMember(String memberId) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      await _storageService.deleteUser(memberId);
      await loadFamilyMembers(currentHead.value!.id!);
    } catch (e) {
      errorMessage.value = 'Failed to delete family member. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }

  Future<String?> exportFamilyTree() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      if (currentHead.value == null) {
        errorMessage.value = 'No head found. Please register as head first.';
        return null;
      }

      final pdfPath = await _storageService.exportFamilyTreeAsPDF(
        currentHead.value!,
        familyMembers,
      );

      return pdfPath;
    } catch (e) {
      errorMessage.value = 'Failed to export family tree. Please try again.';
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  void setPhoneNumber(String phone) {
    phoneNumber.value = phone;
  }

  void clearForm() {
    name.value = '';
    age.value = 0;
    gender.value = '';
    maritalStatus.value = '';
    occupation.value = '';
    samajName.value = '';
    qualification.value = '';
    birthDate.value = null;
    bloodGroup.value = '';
    exactNatureOfDuties.value = '';
    email.value = '';
    phoneNumber.value = '';
    alternativeNumber.value = '';
    landlineNumber.value = '';
    socialMediaLink.value = '';
    flatNumber.value = '';
    buildingName.value = '';
    doorNumber.value = '';
    streetName.value = '';
    landmark.value = '';
    city.value = '';
    district.value = '';
    state.value = '';
    nativeCity.value = '';
    nativeState.value = '';
    country.value = '';
    pincode.value = '';
    photoUrl.value = '';
  }

  bool _validateHeadForm() {
    if (name.value.isEmpty) {
      errorMessage.value = 'Name is required';
      return false;
    }
    if (age.value <= 0) {
      errorMessage.value = 'Valid age is required';
      return false;
    }
    if (gender.value.isEmpty) {
      errorMessage.value = 'Gender is required';
      return false;
    }
    if (maritalStatus.value.isEmpty) {
      errorMessage.value = 'Marital status is required';
      return false;
    }
    if (occupation.value.isEmpty) {
      errorMessage.value = 'Occupation is required';
      return false;
    }
    if (samajName.value.isEmpty) {
      errorMessage.value = 'Samaj name is required';
      return false;
    }
    if (qualification.value.isEmpty) {
      errorMessage.value = 'Qualification is required';
      return false;
    }
    if (birthDate.value == null) {
      errorMessage.value = 'Birth date is required';
      return false;
    }
    if (bloodGroup.value.isEmpty) {
      errorMessage.value = 'Blood group is required';
      return false;
    }
    if (exactNatureOfDuties.value.isEmpty) {
      errorMessage.value = 'Exact nature of duties is required';
      return false;
    }
    if (email.value.isEmpty) {
      errorMessage.value = 'Email is required';
      return false;
    }
    if (phoneNumber.value.isEmpty) {
      errorMessage.value = 'Phone number is required';
      return false;
    }
    if (flatNumber.value.isEmpty) {
      errorMessage.value = 'Flat number is required';
      return false;
    }
    if (buildingName.value.isEmpty) {
      errorMessage.value = 'Building name is required';
      return false;
    }
    if (doorNumber.value.isEmpty) {
      errorMessage.value = 'Door number is required';
      return false;
    }
    if (streetName.value.isEmpty) {
      errorMessage.value = 'Street name is required';
      return false;
    }
    if (city.value.isEmpty) {
      errorMessage.value = 'City is required';
      return false;
    }
    if (district.value.isEmpty) {
      errorMessage.value = 'District is required';
      return false;
    }
    if (state.value.isEmpty) {
      errorMessage.value = 'State is required';
      return false;
    }
    if (nativeCity.value.isEmpty) {
      errorMessage.value = 'Native city is required';
      return false;
    }
    if (nativeState.value.isEmpty) {
      errorMessage.value = 'Native state is required';
      return false;
    }
    if (country.value.isEmpty) {
      errorMessage.value = 'Country is required';
      return false;
    }
    if (pincode.value.isEmpty) {
      errorMessage.value = 'Pincode is required';
      return false;
    }

    return true;
  }

  void clearError() {
    errorMessage.value = '';
  }
}
