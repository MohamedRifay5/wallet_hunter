import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:wallet_hunter/app/controllers/registration_controller.dart';
import 'package:wallet_hunter/app/routes/app_routes.dart';
import '../ui_helpers.dart';

class HeadRegistrationPage extends StatelessWidget {
  const HeadRegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final RegistrationController controller = Get.find<RegistrationController>();

    // Set phone number if passed from login
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null && args['phoneNumber'] != null) {
      controller.setPhoneNumber(args['phoneNumber']);
    }

    return Scaffold(
      backgroundColor: UIHelpers.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Family Head Registration',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: UIHelpers.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Obx(() => controller.isLoading.value
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: UIHelpers.primaryColor),
                  SizedBox(height: 16),
                  Text('Creating your family profile...'),
                ],
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(UIHelpers.paddingMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Welcome Section
                  UIHelpers.buildInfoWidget(
                    'Welcome! Please provide your information to create your family profile. '
                    'You will be registered as the head of your family.',
                    icon: Icons.family_restroom,
                  ),

                  const SizedBox(height: UIHelpers.spacingMedium),

                  // Progress Indicator
                  UIHelpers.buildProgressIndicator(
                    currentStep: 1,
                    totalSteps: 4,
                    title: 'Registration Progress',
                  ),

                  const SizedBox(height: UIHelpers.spacingLarge),

                  // Required Fields Note
                  UIHelpers.buildRequiredFieldNote(),

                  const SizedBox(height: UIHelpers.spacingMedium),

                  Form(
                    child: Column(
                      children: [
                        // Basic Information Section
                        _buildBasicInformationSection(controller),

                        UIHelpers.buildSectionDivider(),

                        // Personal Details Section
                        _buildPersonalDetailsSection(controller),

                        UIHelpers.buildSectionDivider(),

                        // Contact Information Section
                        _buildContactInformationSection(controller),

                        UIHelpers.buildSectionDivider(),

                        // Address Information Section
                        _buildAddressInformationSection(controller),

                        const SizedBox(height: UIHelpers.spacingLarge),

                        // Error Message
                        Obx(() => controller.errorMessage.value.isNotEmpty
                            ? UIHelpers.buildErrorWidget(controller.errorMessage.value)
                            : const SizedBox.shrink()),

                        // Submit Button
                        UIHelpers.buildPrimaryButton(
                          text: 'Create Family Profile',
                          onPressed: () {
                            controller.clearError();
                            controller.registerHead();
                          },
                          icon: Icons.family_restroom,
                        ),

                        const SizedBox(height: UIHelpers.spacingMedium),

                        // Help Text
                        UIHelpers.buildInfoWidget(
                          'After registration, you can add family members and manage your family tree.',
                          icon: Icons.help_outline,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
    );
  }

  Widget _buildBasicInformationSection(RegistrationController controller) {
    return UIHelpers.buildFormCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UIHelpers.buildSectionHeader(
            'Basic Information',
            Icons.person_outline,
            subtitle: 'Your personal details and family role',
          ),

          const SizedBox(height: UIHelpers.spacingMedium),

          // Full Name
          UIHelpers.buildInputField(
            label: 'Full Name',
            hint: 'Enter your complete name (First Middle Last)',
            prefixIcon: Icons.person,
            isRequired: true,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your full name';
              }
              if (value.trim().split(' ').length < 2) {
                return 'Please enter your first and last name';
              }
              return null;
            },
            onChanged: (value) => controller.name.value = value,
          ),

          const SizedBox(height: UIHelpers.spacingMedium),

          // Age and Gender Row
          Row(
            children: [
              Expanded(
                child: UIHelpers.buildInputField(
                  label: 'Age',
                  hint: 'Enter your age',
                  prefixIcon: Icons.calendar_today,
                  keyboardType: TextInputType.number,
                  isRequired: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your age';
                    }
                    final age = int.tryParse(value);
                    if (age == null || age < 18 || age > 120) {
                      return 'Please enter a valid age (18-120)';
                    }
                    return null;
                  },
                  onChanged: (value) => controller.age.value = int.tryParse(value) ?? 0,
                ),
              ),
              const SizedBox(width: UIHelpers.spacingMedium),
              Expanded(
                child: UIHelpers.buildResponsiveDropdownField(
                  label: 'Gender',
                  hint: 'Select your gender',
                  prefixIcon: Icons.person_outline,
                  isRequired: true,
                  value: controller.gender.value.isEmpty ? 'Male' : controller.gender.value,
                  items: UIHelpers.createDropdownItems(['Male', 'Female', 'Other']),
                  onChanged: (value) => controller.gender.value = value ?? '',
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
                  hint: 'Select your marital status',
                  prefixIcon: Icons.favorite_outline,
                  isRequired: true,
                  value: controller.maritalStatus.value.isEmpty ? 'Married' : controller.maritalStatus.value,
                  items: UIHelpers.createDropdownItems(['Single', 'Married', 'Divorced', 'Widowed']),
                  onChanged: (value) => controller.maritalStatus.value = value ?? '',
                ),
              ),
              const SizedBox(width: UIHelpers.spacingMedium),
              Expanded(
                child: UIHelpers.buildInputField(
                  label: 'Occupation',
                  hint: 'Enter your profession',
                  prefixIcon: Icons.work_outline,
                  isRequired: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your occupation';
                    }
                    return null;
                  },
                  onChanged: (value) => controller.occupation.value = value,
                ),
              ),
            ],
          ),

          const SizedBox(height: UIHelpers.spacingMedium),

          // Samaj Name and Qualification Row
          Row(
            children: [
              Expanded(
                child: UIHelpers.buildInputField(
                  label: 'Samaj Name',
                  hint: 'Enter your community/samaj name',
                  prefixIcon: Icons.group_outlined,
                  isRequired: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your samaj name';
                    }
                    return null;
                  },
                  onChanged: (value) => controller.samajName.value = value,
                ),
              ),
              const SizedBox(width: UIHelpers.spacingMedium),
              Expanded(
                child: UIHelpers.buildInputField(
                  label: 'Qualification',
                  hint: 'Enter your highest education',
                  prefixIcon: Icons.school_outlined,
                  isRequired: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your qualification';
                    }
                    return null;
                  },
                  onChanged: (value) => controller.qualification.value = value,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalDetailsSection(RegistrationController controller) {
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

          // Birth Date
          UIHelpers.buildDatePickerField(
            label: 'Date of Birth',
            selectedDate: controller.birthDate.value,
            onDateSelected: (date) => controller.birthDate.value = date,
            prefixIcon: Icons.calendar_today,
            isRequired: true,
          ),

          const SizedBox(height: UIHelpers.spacingMedium),

          // Blood Group and Duties Row
          Row(
            children: [
              Expanded(
                child: UIHelpers.buildResponsiveDropdownField(
                  label: 'Blood Group',
                  hint: 'Select your blood group',
                  prefixIcon: Icons.bloodtype_outlined,
                  isRequired: true,
                  value: controller.bloodGroup.value.isEmpty ? 'A+' : controller.bloodGroup.value,
                  items: UIHelpers.createDropdownItems(['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-']),
                  onChanged: (value) => controller.bloodGroup.value = value ?? '',
                ),
              ),
              const SizedBox(width: UIHelpers.spacingMedium),
              Expanded(
                child: UIHelpers.buildInputField(
                  label: 'Nature of Duties',
                  hint: 'Describe your work responsibilities',
                  prefixIcon: Icons.description_outlined,
                  isRequired: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please describe your duties';
                    }
                    return null;
                  },
                  onChanged: (value) => controller.exactNatureOfDuties.value = value,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactInformationSection(RegistrationController controller) {
    return UIHelpers.buildFormCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UIHelpers.buildSectionHeader(
            'Contact Information',
            Icons.contact_phone,
            subtitle: 'How we can reach you',
          ),

          const SizedBox(height: UIHelpers.spacingMedium),

          // Email
          UIHelpers.buildInputField(
            label: 'Email Address',
            hint: 'Enter your email address',
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            isRequired: true,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your email address';
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                return 'Please enter a valid email address';
              }
              return null;
            },
            onChanged: (value) => controller.email.value = value,
          ),

          const SizedBox(height: UIHelpers.spacingMedium),

          // Phone Number (Read-only)
          UIHelpers.buildInputField(
            label: 'Phone Number',
            hint: 'Your registered phone number',
            prefixIcon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
            enabled: false,
            controller: TextEditingController(text: controller.phoneNumber.value),
          ),

          const SizedBox(height: UIHelpers.spacingMedium),

          // Alternative and Landline Numbers Row
          Row(
            children: [
              Expanded(
                child: UIHelpers.buildInputField(
                  label: 'Alternative Number',
                  hint: 'Secondary contact number (optional)',
                  prefixIcon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  onChanged: (value) => controller.alternativeNumber.value = value,
                ),
              ),
              const SizedBox(width: UIHelpers.spacingMedium),
              Expanded(
                child: UIHelpers.buildInputField(
                  label: 'Landline Number',
                  hint: 'Home/office landline (optional)',
                  prefixIcon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  onChanged: (value) => controller.landlineNumber.value = value,
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
            onChanged: (value) => controller.socialMediaLink.value = value,
          ),
        ],
      ),
    );
  }

  Widget _buildAddressInformationSection(RegistrationController controller) {
    return UIHelpers.buildFormCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UIHelpers.buildSectionHeader(
            'Address Information',
            Icons.location_on_outlined,
            subtitle: 'Your current and native address details',
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
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter flat number';
                    }
                    return null;
                  },
                  onChanged: (value) => controller.flatNumber.value = value,
                ),
              ),
              const SizedBox(width: UIHelpers.spacingMedium),
              Expanded(
                child: UIHelpers.buildInputField(
                  label: 'Building Name',
                  hint: 'Enter building name',
                  prefixIcon: Icons.business_outlined,
                  isRequired: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter building name';
                    }
                    return null;
                  },
                  onChanged: (value) => controller.buildingName.value = value,
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
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter door number';
                    }
                    return null;
                  },
                  onChanged: (value) => controller.doorNumber.value = value,
                ),
              ),
              const SizedBox(width: UIHelpers.spacingMedium),
              Expanded(
                child: UIHelpers.buildInputField(
                  label: 'Street Name',
                  hint: 'Enter street name',
                  prefixIcon: Icons.streetview_outlined,
                  isRequired: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter street name';
                    }
                    return null;
                  },
                  onChanged: (value) => controller.streetName.value = value,
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
            onChanged: (value) => controller.landmark.value = value,
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
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your city';
                    }
                    return null;
                  },
                  onChanged: (value) => controller.city.value = value,
                ),
              ),
              const SizedBox(width: UIHelpers.spacingMedium),
              Expanded(
                child: UIHelpers.buildInputField(
                  label: 'District',
                  hint: 'Enter your district',
                  prefixIcon: Icons.map_outlined,
                  isRequired: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your district';
                    }
                    return null;
                  },
                  onChanged: (value) => controller.district.value = value,
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
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your state';
                    }
                    return null;
                  },
                  onChanged: (value) => controller.state.value = value,
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
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter pincode';
                    }
                    if (value.length != 6 || int.tryParse(value) == null) {
                      return 'Please enter a valid 6-digit pincode';
                    }
                    return null;
                  },
                  onChanged: (value) => controller.pincode.value = value,
                ),
              ),
            ],
          ),

          const SizedBox(height: UIHelpers.spacingMedium),

          // Native Place Section
          Text(
            'Native Place (Where you are originally from)',
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
                  hint: 'Enter your native city',
                  prefixIcon: Icons.location_city_outlined,
                  isRequired: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your native city';
                    }
                    return null;
                  },
                  onChanged: (value) => controller.nativeCity.value = value,
                ),
              ),
              const SizedBox(width: UIHelpers.spacingMedium),
              Expanded(
                child: UIHelpers.buildInputField(
                  label: 'Native State',
                  hint: 'Enter your native state',
                  prefixIcon: Icons.flag_outlined,
                  isRequired: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your native state';
                    }
                    return null;
                  },
                  onChanged: (value) => controller.nativeState.value = value,
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
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your country';
              }
              return null;
            },
            onChanged: (value) => controller.country.value = value,
          ),
        ],
      ),
    );
  }
}
