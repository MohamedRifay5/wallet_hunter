import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UIHelpers {
  // Colors
  static const Color primaryColor = Color(0xFF2196F3);
  static const Color secondaryColor = Color(0xFF1976D2);
  static const Color accentColor = Color(0xFF64B5F6);
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color cardColor = Colors.white;
  static const Color textColor = Color(0xFF333333);
  static const Color subtitleColor = Color(0xFF666666);
  static const Color errorColor = Color(0xFFD32F2F);
  static const Color successColor = Color(0xFF388E3C);
  static const Color warningColor = Color(0xFFF57C00);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryColor, secondaryColor],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [cardColor, Color(0xFFFAFAFA)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Text Styles
  static const TextStyle headingStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: textColor,
  );

  static const TextStyle sectionTitleStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: primaryColor,
  );

  static const TextStyle labelStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: textColor,
  );

  static const TextStyle subtitleStyle = TextStyle(
    fontSize: 12,
    color: subtitleColor,
  );

  static const TextStyle buttonTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  // Spacing
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double spacingSmall = 8.0;
  static const double spacingMedium = 16.0;
  static const double spacingLarge = 24.0;

  // Border Radius
  static const double borderRadiusSmall = 8.0;
  static const double borderRadiusMedium = 12.0;
  static const double borderRadiusLarge = 16.0;

  // Shadows
  static List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> elevatedShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.15),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
  ];

  // Helper Widgets
  static Widget buildSectionHeader(String title, IconData icon, {String? subtitle}) {
    return Container(
      margin: const EdgeInsets.only(bottom: spacingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: primaryGradient,
                  borderRadius: BorderRadius.circular(borderRadiusSmall),
                ),
                child: Icon(icon, color: Colors.white, size: 20),
              ),
              const SizedBox(width: spacingSmall),
              Expanded(
                child: Text(
                  title,
                  style: sectionTitleStyle,
                ),
              ),
            ],
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: subtitleStyle,
            ),
          ],
        ],
      ),
    );
  }

  static Widget buildInfoCard({
    required String title,
    required String value,
    IconData? icon,
    Color? valueColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(paddingMedium),
      decoration: BoxDecoration(
        gradient: cardGradient,
        borderRadius: BorderRadius.circular(borderRadiusMedium),
        boxShadow: cardShadow,
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, color: primaryColor, size: 20),
            const SizedBox(width: spacingSmall),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: subtitleStyle,
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: labelStyle.copyWith(
                    color: valueColor ?? textColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildFormCard({
    required Widget child,
    EdgeInsetsGeometry? padding,
  }) {
    return Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(paddingMedium),
      decoration: BoxDecoration(
        gradient: cardGradient,
        borderRadius: BorderRadius.circular(borderRadiusMedium),
        boxShadow: cardShadow,
      ),
      child: child,
    );
  }

  static Widget buildInputField({
    required String label,
    required String hint,
    IconData? prefixIcon,
    IconData? suffixIcon,
    TextInputType? keyboardType,
    bool isRequired = false,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
    TextEditingController? controller,
    bool enabled = true,
    int? maxLines = 1,
    bool obscureText = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (isRequired)
              const Text(
                '* ',
                style: TextStyle(color: errorColor, fontSize: 16),
              ),
            Text(
              label,
              style: labelStyle,
            ),
          ],
        ),
        const SizedBox(height: spacingSmall),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          enabled: enabled,
          maxLines: maxLines,
          obscureText: obscureText,
          validator: validator,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: subtitleStyle,
            prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: primaryColor) : null,
            suffixIcon: suffixIcon != null ? Icon(suffixIcon, color: primaryColor) : null,
            filled: true,
            fillColor: enabled ? Colors.white : Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadiusSmall),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadiusSmall),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadiusSmall),
              borderSide: const BorderSide(color: primaryColor, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadiusSmall),
              borderSide: const BorderSide(color: errorColor),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: paddingMedium,
              vertical: paddingMedium,
            ),
          ),
        ),
      ],
    );
  }

  // Helper method to create styled dropdown items
  static List<DropdownMenuItem<String>> createStyledDropdownItems(List<String> items, {double fontSize = 13}) {
    return items
        .map((item) => DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: labelStyle.copyWith(fontSize: fontSize),
                overflow: TextOverflow.ellipsis,
              ),
            ))
        .toList();
  }

  // Helper method to create compact dropdown items
  static List<DropdownMenuItem<String>> createCompactDropdownItems(List<String> items) {
    return createStyledDropdownItems(items, fontSize: 12);
  }

  // Helper method to create dropdown items with proper text handling
  static List<DropdownMenuItem<String>> createDropdownItems(List<String> items) {
    return createStyledDropdownItems(items, fontSize: 13);
  }

  static Widget buildDropdownField({
    required String label,
    required String hint,
    required List<DropdownMenuItem<String>> items,
    required String value,
    required void Function(String?) onChanged,
    IconData? prefixIcon,
    bool isRequired = false,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (isRequired)
              const Text(
                '* ',
                style: TextStyle(color: errorColor, fontSize: 16),
              ),
            Text(
              label,
              style: labelStyle,
            ),
          ],
        ),
        const SizedBox(height: spacingSmall),
        DropdownButtonFormField<String>(
          value: value,
          items: items,
          onChanged: onChanged,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: subtitleStyle,
            prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: primaryColor) : null,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadiusSmall),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadiusSmall),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadiusSmall),
              borderSide: const BorderSide(color: primaryColor, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: paddingMedium,
              vertical: paddingMedium,
            ),
          ),
          style: labelStyle.copyWith(fontSize: 13),
          icon: const Icon(Icons.keyboard_arrow_down, color: primaryColor),
          isDense: true,
          isExpanded: true,
          menuMaxHeight: 300,
          dropdownColor: Colors.white,
        ),
      ],
    );
  }

  static Widget buildDatePickerField({
    required String label,
    required DateTime? selectedDate,
    required void Function(DateTime) onDateSelected,
    IconData? prefixIcon,
    bool isRequired = false,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (isRequired)
              const Text(
                '* ',
                style: TextStyle(color: errorColor, fontSize: 16),
              ),
            Text(
              label,
              style: labelStyle,
            ),
          ],
        ),
        const SizedBox(height: spacingSmall),
        InkWell(
          onTap: () async {
            final DateTime? picked = await showDatePicker(
              context: Get.context!,
              initialDate: selectedDate ?? DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: const ColorScheme.light(
                      primary: primaryColor,
                      onPrimary: Colors.white,
                      surface: Colors.white,
                      onSurface: textColor,
                    ),
                  ),
                  child: child!,
                );
              },
            );
            if (picked != null) {
              onDateSelected(picked);
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: paddingMedium,
              vertical: paddingMedium,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(borderRadiusSmall),
            ),
            child: Row(
              children: [
                Icon(prefixIcon ?? Icons.calendar_today, color: primaryColor),
                const SizedBox(width: spacingSmall),
                Expanded(
                  child: Text(
                    selectedDate != null
                        ? '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'
                        : 'Select Date',
                    style: selectedDate != null ? labelStyle : subtitleStyle,
                  ),
                ),
                const Icon(Icons.keyboard_arrow_down, color: primaryColor),
              ],
            ),
          ),
        ),
      ],
    );
  }

  static Widget buildPrimaryButton({
    required String text,
    required VoidCallback onPressed,
    bool isLoading = false,
    IconData? icon,
  }) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        gradient: primaryGradient,
        borderRadius: BorderRadius.circular(borderRadiusMedium),
        boxShadow: elevatedShadow,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(borderRadiusMedium),
          child: Center(
            child: isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (icon != null) ...[
                        Icon(icon, color: Colors.white, size: 20),
                        const SizedBox(width: spacingSmall),
                      ],
                      Text(
                        text,
                        style: buttonTextStyle,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  static Widget buildSecondaryButton({
    required String text,
    required VoidCallback onPressed,
    IconData? icon,
  }) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: primaryColor),
        borderRadius: BorderRadius.circular(borderRadiusMedium),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(borderRadiusMedium),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  Icon(icon, color: primaryColor, size: 20),
                  const SizedBox(width: spacingSmall),
                ],
                Text(
                  text,
                  style: buttonTextStyle.copyWith(color: primaryColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget buildErrorWidget(String message) {
    return Container(
      padding: const EdgeInsets.all(paddingMedium),
      margin: const EdgeInsets.only(bottom: spacingMedium),
      decoration: BoxDecoration(
        color: errorColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(borderRadiusSmall),
        border: Border.all(color: errorColor.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: errorColor, size: 20),
          const SizedBox(width: spacingSmall),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: errorColor, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildSuccessWidget(String message) {
    return Container(
      padding: const EdgeInsets.all(paddingMedium),
      margin: const EdgeInsets.only(bottom: spacingMedium),
      decoration: BoxDecoration(
        color: successColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(borderRadiusSmall),
        border: Border.all(color: successColor.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle_outline, color: successColor, size: 20),
          const SizedBox(width: spacingSmall),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: successColor, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildInfoWidget(String message, {IconData? icon}) {
    return Container(
      padding: const EdgeInsets.all(paddingMedium),
      margin: const EdgeInsets.only(bottom: spacingMedium),
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(borderRadiusSmall),
        border: Border.all(color: primaryColor.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(icon ?? Icons.info_outline, color: primaryColor, size: 20),
          const SizedBox(width: spacingSmall),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: primaryColor, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildProgressIndicator({
    required int currentStep,
    required int totalSteps,
    String? title,
  }) {
    return Column(
      children: [
        if (title != null) ...[
          Text(
            title,
            style: sectionTitleStyle,
          ),
          const SizedBox(height: spacingMedium),
        ],
        Row(
          children: List.generate(totalSteps, (index) {
            final isCompleted = index < currentStep;
            final isCurrent = index == currentStep - 1;

            return Expanded(
              child: Container(
                height: 4,
                margin: EdgeInsets.only(
                  right: index < totalSteps - 1 ? 4 : 0,
                ),
                decoration: BoxDecoration(
                  color: isCompleted || isCurrent ? primaryColor : Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: spacingSmall),
        Text(
          'Step $currentStep of $totalSteps',
          style: subtitleStyle,
        ),
      ],
    );
  }

  static Widget buildSectionDivider() {
    return Container(
      height: 1,
      margin: const EdgeInsets.symmetric(vertical: spacingLarge),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.grey[300]!, Colors.grey[100]!, Colors.grey[300]!],
        ),
      ),
    );
  }

  static Widget buildRequiredFieldNote() {
    return Container(
      padding: const EdgeInsets.all(paddingSmall),
      margin: const EdgeInsets.only(bottom: spacingMedium),
      decoration: BoxDecoration(
        color: warningColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(borderRadiusSmall),
        border: Border.all(color: warningColor.withOpacity(0.3)),
      ),
      child: const Row(
        children: [
          Icon(Icons.warning_amber_outlined, color: warningColor, size: 16),
          SizedBox(width: spacingSmall),
          Text(
            'Fields marked with * are required',
            style: TextStyle(color: warningColor, fontSize: 12),
          ),
        ],
      ),
    );
  }

  // Responsive dropdown field that handles overflow better
  static Widget buildResponsiveDropdownField({
    required String label,
    required String hint,
    required List<DropdownMenuItem<String>> items,
    required String value,
    required void Function(String?) onChanged,
    IconData? prefixIcon,
    bool isRequired = false,
    String? Function(String?)? validator,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // If screen is narrow, stack vertically
        if (constraints.maxWidth < 400) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (isRequired)
                    const Text(
                      '* ',
                      style: TextStyle(color: errorColor, fontSize: 16),
                    ),
                  Text(
                    label,
                    style: labelStyle,
                  ),
                ],
              ),
              const SizedBox(height: spacingSmall),
              DropdownButtonFormField<String>(
                value: value,
                items: items,
                onChanged: onChanged,
                validator: validator,
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: subtitleStyle.copyWith(fontSize: 11),
                  prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: primaryColor, size: 18) : null,
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadiusSmall),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadiusSmall),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadiusSmall),
                    borderSide: const BorderSide(color: primaryColor, width: 2),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: paddingSmall,
                    vertical: paddingSmall,
                  ),
                ),
                style: labelStyle.copyWith(fontSize: 12),
                icon: const Icon(Icons.keyboard_arrow_down, color: primaryColor, size: 18),
                isDense: true,
                isExpanded: true,
                menuMaxHeight: 250,
                dropdownColor: Colors.white,
              ),
            ],
          );
        }

        // For wider screens, use the standard layout
        return buildDropdownField(
          label: label,
          hint: hint,
          items: items,
          value: value,
          onChanged: onChanged,
          prefixIcon: prefixIcon,
          isRequired: isRequired,
          validator: validator,
        );
      },
    );
  }
}
