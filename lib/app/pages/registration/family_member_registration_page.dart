import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../controllers/registration_controller.dart';
import '../../models/user_model.dart';
import '../ui_helpers.dart';

class FamilyMemberRegistrationPage extends StatefulWidget {
  const FamilyMemberRegistrationPage({Key? key}) : super(key: key);

  @override
  State<FamilyMemberRegistrationPage> createState() => _FamilyMemberRegistrationPageState();
}

class _FamilyMemberRegistrationPageState extends State<FamilyMemberRegistrationPage> {
  final RegistrationController controller = Get.find<RegistrationController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  // Personal Information Controllers
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _qualificationController = TextEditingController();
  final TextEditingController _exactNatureOfDutiesController = TextEditingController();

  // Contact Information Controllers
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _alternativeNumberController = TextEditingController();
  final TextEditingController _landlineNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _socialMediaLinkController = TextEditingController();

  // Current Address Controllers
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _streetNameController = TextEditingController();
  final TextEditingController _landmarkController = TextEditingController();
  final TextEditingController _buildingNameController = TextEditingController();
  final TextEditingController _doorNumberController = TextEditingController();
  final TextEditingController _flatNumberController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();

  // Native Place Controllers
  final TextEditingController _nativeCityController = TextEditingController();
  final TextEditingController _nativeStateController = TextEditingController();

  // Dropdown Values
  String _selectedGender = 'Male';
  String _selectedMaritalStatus = 'Single';
  String _selectedOccupation = 'Student';
  String _selectedBloodGroup = 'A+';
  String _selectedRelation = 'Son';
  DateTime _selectedBirthDate = DateTime.now().subtract(const Duration(days: 6570)); // 18 years ago

  @override
  void initState() {
    super.initState();
    // Set default values
    _countryController.text = 'India';
    _qualificationController.text = 'High School';
    _exactNatureOfDutiesController.text = 'Student';
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _middleNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    _qualificationController.dispose();
    _exactNatureOfDutiesController.dispose();
    _phoneController.dispose();
    _alternativeNumberController.dispose();
    _landlineNumberController.dispose();
    _emailController.dispose();
    _socialMediaLinkController.dispose();
    _countryController.dispose();
    _stateController.dispose();
    _districtController.dispose();
    _cityController.dispose();
    _streetNameController.dispose();
    _landmarkController.dispose();
    _buildingNameController.dispose();
    _doorNumberController.dispose();
    _flatNumberController.dispose();
    _pincodeController.dispose();
    _nativeCityController.dispose();
    _nativeStateController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 80,
      );
      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to pick image: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[900],
      );
    }
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedBirthDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: UIHelpers.primaryColor,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: UIHelpers.textColor,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedBirthDate) {
      setState(() {
        _selectedBirthDate = picked;
        // Calculate age
        final age = DateTime.now().year - picked.year;
        _ageController.text = age.toString();
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final fullName =
          '${_firstNameController.text.trim()} ${_middleNameController.text.trim()} ${_lastNameController.text.trim()}'
              .trim();

      final familyMember = UserModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: fullName,
        age: int.tryParse(_ageController.text) ?? 0,
        gender: _selectedGender,
        maritalStatus: _selectedMaritalStatus,
        occupation: _selectedOccupation,
        samajName: controller.currentHead.value?.samajName ?? 'General',
        qualification: _qualificationController.text.trim(),
        birthDate: _selectedBirthDate,
        bloodGroup: _selectedBloodGroup,
        exactNatureOfDuties: _exactNatureOfDutiesController.text.trim(),
        email: _emailController.text.trim(),
        phoneNumber: _phoneController.text.trim(),
        alternativeNumber: _alternativeNumberController.text.trim(),
        landlineNumber: _landlineNumberController.text.trim(),
        socialMediaLink: _socialMediaLinkController.text.trim(),
        flatNumber: _flatNumberController.text.trim(),
        buildingName: _buildingNameController.text.trim(),
        streetName: _streetNameController.text.trim(),
        landmark: _landmarkController.text.trim(),
        city: _cityController.text.trim(),
        district: _districtController.text.trim(),
        state: _stateController.text.trim(),
        nativeCity: _nativeCityController.text.trim(),
        nativeState: _nativeStateController.text.trim(),
        country: _countryController.text.trim(),
        pincode: _pincodeController.text.trim(),
        photoUrl: _selectedImage?.path,
        relationWithHead: _selectedRelation,
        isHead: false,
        headId: controller.currentHead.value?.id,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        doorNumber: _doorNumberController.text.trim(),
      );

      controller.addFamilyMember(familyMember);
      Get.back();
      Get.snackbar(
        'Success',
        'Family member added successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green[100],
        colorText: Colors.green[900],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIHelpers.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Add Family Member',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: UIHelpers.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(UIHelpers.paddingMedium),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Section
              UIHelpers.buildInfoWidget(
                'Add a new family member to your family tree. '
                'This person will be linked to you as the family head.',
                icon: Icons.person_add,
              ),

              const SizedBox(height: UIHelpers.spacingMedium),

              // Progress Indicator
              UIHelpers.buildProgressIndicator(
                currentStep: 2,
                totalSteps: 4,
                title: 'Registration Progress',
              ),

              const SizedBox(height: UIHelpers.spacingLarge),

              // Required Fields Note
              UIHelpers.buildRequiredFieldNote(),

              const SizedBox(height: UIHelpers.spacingMedium),

              // Profile Photo Section
              _buildProfilePhotoSection(),

              UIHelpers.buildSectionDivider(),

              // Basic Information Section
              _buildBasicInformationSection(),

              UIHelpers.buildSectionDivider(),

              // Personal Details Section
              _buildPersonalDetailsSection(),

              UIHelpers.buildSectionDivider(),

              // Contact Information Section
              _buildContactInformationSection(),

              UIHelpers.buildSectionDivider(),

              // Address Information Section
              _buildAddressInformationSection(),

              const SizedBox(height: UIHelpers.spacingLarge),

              // Submit Button
              UIHelpers.buildPrimaryButton(
                text: 'Add Family Member',
                onPressed: _submitForm,
                icon: Icons.person_add,
              ),

              const SizedBox(height: UIHelpers.spacingMedium),

              // Help Text
              UIHelpers.buildInfoWidget(
                'After adding, you can view this member in your family tree and edit their details.',
                icon: Icons.help_outline,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfilePhotoSection() {
    return UIHelpers.buildFormCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UIHelpers.buildSectionHeader(
            'Profile Photo',
            Icons.camera_alt_outlined,
            subtitle: 'Add a photo for easy identification (optional)',
          ),
          const SizedBox(height: UIHelpers.spacingMedium),
          Center(
            child: GestureDetector(
              onTap: _pickImage,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(60),
                  border: Border.all(
                    color: UIHelpers.primaryColor,
                    width: 2,
                    style: BorderStyle.solid,
                  ),
                ),
                child: _selectedImage != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(58),
                        child: Image.file(
                          _selectedImage!,
                          width: 116,
                          height: 116,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.camera_alt,
                            size: 40,
                            color: UIHelpers.primaryColor,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Tap to add photo',
                            style: UIHelpers.subtitleStyle.copyWith(
                              color: UIHelpers.primaryColor,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBasicInformationSection() {
    return UIHelpers.buildFormCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UIHelpers.buildSectionHeader(
            'Basic Information',
            Icons.person_outline,
            subtitle: 'Personal details and family relationship',
          ),

          const SizedBox(height: UIHelpers.spacingMedium),

          // Name Fields
          Row(
            children: [
              Expanded(
                child: UIHelpers.buildInputField(
                  label: 'First Name',
                  hint: 'Enter first name',
                  prefixIcon: Icons.person,
                  isRequired: true,
                  controller: _firstNameController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter first name';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: UIHelpers.spacingMedium),
              Expanded(
                child: UIHelpers.buildInputField(
                  label: 'Middle Name',
                  hint: 'Enter middle name (optional)',
                  prefixIcon: Icons.person,
                  controller: _middleNameController,
                ),
              ),
            ],
          ),

          const SizedBox(height: UIHelpers.spacingMedium),

          // Last Name
          UIHelpers.buildInputField(
            label: 'Last Name',
            hint: 'Enter last name',
            prefixIcon: Icons.person,
            isRequired: true,
            controller: _lastNameController,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter last name';
              }
              return null;
            },
          ),

          const SizedBox(height: UIHelpers.spacingMedium),

          // Relation to Head
          UIHelpers.buildResponsiveDropdownField(
            label: 'Relation to Family Head',
            hint: 'Select relationship',
            prefixIcon: Icons.family_restroom,
            isRequired: true,
            value: _selectedRelation,
            items: UIHelpers.createDropdownItems([
              'Son',
              'Daughter',
              'Spouse',
              'Father',
              'Mother',
              'Brother',
              'Sister',
              'Grandson',
              'Granddaughter',
              'Grandfather',
              'Grandmother',
              'Uncle',
              'Aunt',
              'Cousin',
              'Other'
            ]),
            onChanged: (value) {
              setState(() {
                _selectedRelation = value ?? 'Son';
              });
            },
          ),

          const SizedBox(height: UIHelpers.spacingMedium),

          // Age and Gender Row
          Row(
            children: [
              Expanded(
                child: UIHelpers.buildInputField(
                  label: 'Age',
                  hint: 'Enter age',
                  prefixIcon: Icons.calendar_today,
                  keyboardType: TextInputType.number,
                  isRequired: true,
                  controller: _ageController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter age';
                    }
                    final age = int.tryParse(value);
                    if (age == null || age < 0 || age > 120) {
                      return 'Please enter a valid age';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: UIHelpers.spacingMedium),
              Expanded(
                child: UIHelpers.buildResponsiveDropdownField(
                  label: 'Gender',
                  hint: 'Select gender',
                  prefixIcon: Icons.person_outline,
                  isRequired: true,
                  value: _selectedGender,
                  items: UIHelpers.createDropdownItems(['Male', 'Female', 'Other']),
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value ?? 'Male';
                    });
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: UIHelpers.spacingMedium),

          // Marital Status and Occupation Row
          Row(
            children: [
              Expanded(
                child: UIHelpers.buildResponsiveDropdownField(
                  label: 'Marital Status',
                  hint: 'Select marital status',
                  prefixIcon: Icons.favorite_outline,
                  isRequired: true,
                  value: _selectedMaritalStatus,
                  items: UIHelpers.createDropdownItems(['Single', 'Married', 'Divorced', 'Widowed']),
                  onChanged: (value) {
                    setState(() {
                      _selectedMaritalStatus = value ?? 'Single';
                    });
                  },
                ),
              ),
              const SizedBox(width: UIHelpers.spacingMedium),
              Expanded(
                child: UIHelpers.buildResponsiveDropdownField(
                  label: 'Occupation',
                  hint: 'Select occupation',
                  prefixIcon: Icons.work_outline,
                  isRequired: true,
                  value: _selectedOccupation,
                  items: UIHelpers.createDropdownItems([
                    'Student',
                    'Employee',
                    'Business Owner',
                    'Professional',
                    'Homemaker',
                    'Retired',
                    'Unemployed',
                    'Other'
                  ]),
                  onChanged: (value) {
                    setState(() {
                      _selectedOccupation = value ?? 'Student';
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalDetailsSection() {
    return UIHelpers.buildFormCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UIHelpers.buildSectionHeader(
            'Personal Details',
            Icons.info_outline,
            subtitle: 'Additional personal information',
          ),

          const SizedBox(height: UIHelpers.spacingMedium),

          // Date of Birth
          InkWell(
            onTap: _selectDate,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: UIHelpers.paddingMedium,
                vertical: UIHelpers.paddingMedium,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(UIHelpers.borderRadiusSmall),
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today, color: UIHelpers.primaryColor),
                  const SizedBox(width: UIHelpers.spacingSmall),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Text(
                              '* ',
                              style: TextStyle(color: UIHelpers.errorColor, fontSize: 16),
                            ),
                            Text(
                              'Date of Birth',
                              style: UIHelpers.labelStyle,
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${_selectedBirthDate.day}/${_selectedBirthDate.month}/${_selectedBirthDate.year}',
                          style: UIHelpers.labelStyle,
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.keyboard_arrow_down, color: UIHelpers.primaryColor),
                ],
              ),
            ),
          ),

          const SizedBox(height: UIHelpers.spacingMedium),

          // Blood Group and Qualification Row
          Row(
            children: [
              Expanded(
                child: UIHelpers.buildResponsiveDropdownField(
                  label: 'Blood Group',
                  hint: 'Select blood group',
                  prefixIcon: Icons.bloodtype_outlined,
                  isRequired: true,
                  value: _selectedBloodGroup,
                  items: UIHelpers.createDropdownItems(['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-']),
                  onChanged: (value) {
                    setState(() {
                      _selectedBloodGroup = value ?? 'A+';
                    });
                  },
                ),
              ),
              const SizedBox(width: UIHelpers.spacingMedium),
              Expanded(
                child: UIHelpers.buildInputField(
                  label: 'Qualification',
                  hint: 'Enter highest education',
                  prefixIcon: Icons.school_outlined,
                  isRequired: true,
                  controller: _qualificationController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter qualification';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: UIHelpers.spacingMedium),

          // Nature of Duties
          UIHelpers.buildInputField(
            label: 'Nature of Duties',
            hint: 'Describe work responsibilities or activities',
            prefixIcon: Icons.description_outlined,
            isRequired: true,
            controller: _exactNatureOfDutiesController,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please describe duties';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContactInformationSection() {
    return UIHelpers.buildFormCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UIHelpers.buildSectionHeader(
            'Contact Information',
            Icons.contact_phone,
            subtitle: 'How to reach this family member',
          ),

          const SizedBox(height: UIHelpers.spacingMedium),

          // Phone Number
          UIHelpers.buildInputField(
            label: 'Phone Number',
            hint: 'Enter mobile number',
            prefixIcon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
            isRequired: true,
            controller: _phoneController,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter phone number';
              }
              if (value.length < 10) {
                return 'Please enter a valid phone number';
              }
              return null;
            },
          ),

          const SizedBox(height: UIHelpers.spacingMedium),

          // Email
          UIHelpers.buildInputField(
            label: 'Email Address',
            hint: 'Enter email address (optional)',
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            controller: _emailController,
            validator: (value) {
              if (value != null && value.isNotEmpty) {
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                  return 'Please enter a valid email address';
                }
              }
              return null;
            },
          ),

          const SizedBox(height: UIHelpers.spacingMedium),

          // Alternative and Landline Numbers Row
          Row(
            children: [
              Expanded(
                child: UIHelpers.buildInputField(
                  label: 'Alternative Number',
                  hint: 'Secondary contact (optional)',
                  prefixIcon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  controller: _alternativeNumberController,
                ),
              ),
              const SizedBox(width: UIHelpers.spacingMedium),
              Expanded(
                child: UIHelpers.buildInputField(
                  label: 'Landline Number',
                  hint: 'Home/office landline (optional)',
                  prefixIcon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  controller: _landlineNumberController,
                ),
              ),
            ],
          ),

          const SizedBox(height: UIHelpers.spacingMedium),

          // Social Media Link
          UIHelpers.buildInputField(
            label: 'Social Media Profile',
            hint: 'Facebook, LinkedIn, or other social media link (optional)',
            prefixIcon: Icons.link_outlined,
            controller: _socialMediaLinkController,
          ),
        ],
      ),
    );
  }

  Widget _buildAddressInformationSection() {
    return UIHelpers.buildFormCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UIHelpers.buildSectionHeader(
            'Address Information',
            Icons.location_on_outlined,
            subtitle: 'Current and native address details',
          ),

          const SizedBox(height: UIHelpers.spacingMedium),

          // Current Address Section
          Text(
            'Current Address',
            style: UIHelpers.labelStyle.copyWith(
              fontWeight: FontWeight.w600,
              color: UIHelpers.primaryColor,
            ),
          ),
          const SizedBox(height: UIHelpers.spacingSmall),

          // Flat and Building Row
          Row(
            children: [
              Expanded(
                child: UIHelpers.buildInputField(
                  label: 'Flat Number',
                  hint: 'Enter flat/apartment number',
                  prefixIcon: Icons.home_outlined,
                  isRequired: true,
                  controller: _flatNumberController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter flat number';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: UIHelpers.spacingMedium),
              Expanded(
                child: UIHelpers.buildInputField(
                  label: 'Building Name',
                  hint: 'Enter building name',
                  prefixIcon: Icons.business_outlined,
                  isRequired: true,
                  controller: _buildingNameController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter building name';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: UIHelpers.spacingMedium),

          // Door and Street Row
          Row(
            children: [
              Expanded(
                child: UIHelpers.buildInputField(
                  label: 'Door Number',
                  hint: 'Enter door number',
                  prefixIcon: Icons.home_outlined,
                  isRequired: true,
                  controller: _doorNumberController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter door number';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: UIHelpers.spacingMedium),
              Expanded(
                child: UIHelpers.buildInputField(
                  label: 'Street Name',
                  hint: 'Enter street name',
                  prefixIcon: Icons.streetview_outlined,
                  isRequired: true,
                  controller: _streetNameController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter street name';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: UIHelpers.spacingMedium),

          // Landmark
          UIHelpers.buildInputField(
            label: 'Landmark',
            hint: 'Nearby landmark for easy location (optional)',
            prefixIcon: Icons.place_outlined,
            controller: _landmarkController,
          ),

          const SizedBox(height: UIHelpers.spacingMedium),

          // City and District Row
          Row(
            children: [
              Expanded(
                child: UIHelpers.buildInputField(
                  label: 'City',
                  hint: 'Enter your city',
                  prefixIcon: Icons.location_city_outlined,
                  isRequired: true,
                  controller: _cityController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your city';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: UIHelpers.spacingMedium),
              Expanded(
                child: UIHelpers.buildInputField(
                  label: 'District',
                  hint: 'Enter your district',
                  prefixIcon: Icons.map_outlined,
                  isRequired: true,
                  controller: _districtController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your district';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: UIHelpers.spacingMedium),

          // State and Pincode Row
          Row(
            children: [
              Expanded(
                child: UIHelpers.buildInputField(
                  label: 'State',
                  hint: 'Enter your state',
                  prefixIcon: Icons.flag_outlined,
                  isRequired: true,
                  controller: _stateController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your state';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: UIHelpers.spacingMedium),
              Expanded(
                child: UIHelpers.buildInputField(
                  label: 'Pincode',
                  hint: 'Enter 6-digit pincode',
                  prefixIcon: Icons.pin_drop_outlined,
                  keyboardType: TextInputType.number,
                  isRequired: true,
                  controller: _pincodeController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter pincode';
                    }
                    if (value.length != 6 || int.tryParse(value) == null) {
                      return 'Please enter a valid 6-digit pincode';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: UIHelpers.spacingMedium),

          // Native Place Section
          Text(
            'Native Place (Where they are originally from)',
            style: UIHelpers.labelStyle.copyWith(
              fontWeight: FontWeight.w600,
              color: UIHelpers.primaryColor,
            ),
          ),
          const SizedBox(height: UIHelpers.spacingSmall),

          // Native City and State Row
          Row(
            children: [
              Expanded(
                child: UIHelpers.buildInputField(
                  label: 'Native City',
                  hint: 'Enter native city',
                  prefixIcon: Icons.location_city_outlined,
                  isRequired: true,
                  controller: _nativeCityController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter native city';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: UIHelpers.spacingMedium),
              Expanded(
                child: UIHelpers.buildInputField(
                  label: 'Native State',
                  hint: 'Enter native state',
                  prefixIcon: Icons.flag_outlined,
                  isRequired: true,
                  controller: _nativeStateController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter native state';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: UIHelpers.spacingMedium),

          // Country
          UIHelpers.buildInputField(
            label: 'Country',
            hint: 'Enter your country',
            prefixIcon: Icons.public_outlined,
            isRequired: true,
            controller: _countryController,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your country';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
