# 🏠 Wallet Hunter - Family Registration Module

A comprehensive Flutter application for community-based family registration and management. This app allows users to register as family heads, add family members, visualize family trees, and export family data.

## 📋 Features

### 🔐 Authentication

- **OTP-based Login**: Secure mobile number authentication
- **Resend OTP**: Automatic resend functionality
- **Session Management**: Persistent login sessions

### 👨‍👩‍👧‍👦 Registration System

- **Head Registration**: Complete family head registration with all required fields
- **Family Member Registration**: Dynamic family member addition
- **Auto-linking**: Automatic family member connection via relationships
- **Photo Upload**: Profile photo management for family members

### 🌳 Family Tree Management

- **Visual Family Tree**: Interactive tree visualization
- **Member Details**: Comprehensive member information display
- **Edit Permissions**: Only family head can delete members
- **Export Functionality**: PDF export of family tree

### 🏛️ Community Features

- **Samaj Association**: Automatic temple association based on Samaj
- **Data Persistence**: Local storage with GetStorage
- **Responsive Design**: Mobile-first UI/UX

## 🛠️ Installation

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK (3.0.0 or higher)
- Android Studio / VS Code
- Git

### Setup Instructions

1. **Clone the repository**

   ```bash
   git clone <repository-url>
   cd flutter-wallet-hunter
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run
   ```

### Platform Support

- ✅ Android (API 21+)
- ✅ iOS (iOS 11.0+)
- ⚠️ Web (Limited support)
- ⚠️ Desktop (Not tested)

## 📱 Usage Guide

### 1. Getting Started

#### First Time Setup

1. **Launch the app** - You'll see the splash screen with app introduction
2. **Login** - Enter your mobile number
3. **OTP Verification** - Use demo OTP: `00000`
4. **Head Registration** - Complete your family head registration

#### Demo Credentials

- **Phone Number**: Any valid 10-digit number
- **OTP**: `00000` (Demo OTP for testing)

### 2. Head Registration

#### Required Information

- **Profile Summary**: Name, Age, Gender, Marital Status, Occupation, Samaj Name, Qualification
- **Personal Information**: Birth Date, Blood Group, Exact Nature of Duties
- **Contact Information**: Email, Phone Number, Alternative Number, Landline Number, Social Media Link
- **Address**: Complete address details including Door Number, Flat Number, Building Name, etc.
- **Native Place**: Native City and State

#### Registration Steps

1. Fill in all required fields (marked with \*)
2. Select birth date using the date picker
3. Choose appropriate dropdown values
4. Submit the form
5. You'll be redirected to the dashboard

### 3. Family Member Management

#### Adding Family Members

1. **Navigate to Dashboard** - After head registration
2. **Click "Add Family Member"** - Opens the family member registration form
3. **Fill Required Fields**:
   - **Personal Info**: First/Middle/Last Name, Birth Date, Age, Gender, etc.
   - **Contact Info**: Phone, Email, Alternative numbers
   - **Address**: Complete current address details
   - **Native Place**: Native city and state
   - **Photo**: Upload profile photo (optional)
4. **Submit** - Member will be added to your family tree

#### Family Member Fields

- **Personal Information**: Name, Age, Gender, Marital Status, Qualification, Occupation, Blood Group, Relation with Head
- **Contact Information**: Phone, Alternative Number, Landline, Email, Social Media
- **Current Address**: Complete address with Door Number, Flat Number, Building Name, etc.
- **Native Place**: Native City and State

### 4. Family Tree Visualization

#### Viewing the Tree

1. **From Dashboard** - Click "View Family Tree"
2. **Interactive Display** - See all family members in tree format
3. **Member Details** - Tap on any member to view full details
4. **Navigation** - Use back button to return to dashboard

#### Tree Features

- **Visual Hierarchy**: Clear parent-child relationships
- **Member Cards**: Compact information display
- **Detail Dialogs**: Full member information on tap
- **Responsive Layout**: Adapts to different screen sizes

### 5. Export Functionality

#### Generating PDF Reports

1. **From Dashboard** - Click "Export Family Tree"
2. **PDF Generation** - App creates a comprehensive PDF report
3. **Download** - PDF is saved to device storage
4. **Share** - Use device share functionality to send PDF

#### PDF Contents

- Family head information
- All family members with complete details
- Family tree structure
- Contact information
- Address details

### 6. Edit and Delete Operations

#### Editing Family Members

1. **From Dashboard** - Find the member in the list
2. **Click Edit Icon** - Opens edit form
3. **Modify Information** - Update any field
4. **Save Changes** - Updates are applied immediately

#### Deleting Family Members

- **Permission**: Only the family head can delete members
- **Process**: Click delete icon next to member name
- **Confirmation**: Confirm deletion action
- **Update**: Family tree updates automatically

## 🏗️ Project Structure

```
lib/
├── app/
│   ├── bindings/           # GetX bindings
│   ├── controllers/        # Business logic
│   ├── models/            # Data models
│   ├── pages/             # UI screens
│   │   ├── auth/          # Authentication screens
│   │   ├── dashboard/     # Main dashboard
│   │   ├── family_tree/   # Family tree visualization
│   │   └── registration/  # Registration forms
│   ├── routes/            # App routing
│   └── services/          # Data services
└── main.dart              # App entry point
```

## 🔧 Configuration

### Environment Setup

- **Flutter Version**: 3.0.0+
- **Dart Version**: 3.0.0+
- **Minimum SDK**: Android API 21, iOS 11.0

### Dependencies

Key packages used:

- `get`: State management and routing
- `get_storage`: Local data persistence
- `image_picker`: Photo upload functionality
- `pdf`: PDF generation
- `path_provider`: File system access
- `flutter_datetime_picker_plus`: Date selection

## 🐛 Troubleshooting

### Common Issues

#### Build Errors

```bash
# Clean and rebuild
flutter clean
flutter pub get
flutter run
```

#### OTP Issues

- **Demo OTP**: Always use `00000` for testing
- **Network Issues**: Check internet connection
- **Phone Number**: Ensure 10-digit format

#### Photo Upload Issues

- **Permissions**: Grant camera/gallery permissions
- **Storage**: Ensure sufficient device storage
- **Image Size**: Large images are automatically compressed

#### Export Issues

- **Storage Permission**: Grant storage access
- **PDF Generation**: Wait for completion
- **File Access**: Check device file manager

### Debug Mode

```bash
# Run in debug mode
flutter run --debug

# Check for issues
flutter analyze
flutter doctor
```

## 📊 Data Management

### Local Storage

- **GetStorage**: All data stored locally
- **User Data**: Head and family member information
- **Session Data**: Login state and preferences
- **Export Files**: Generated PDFs

### Data Backup

- **Automatic**: Data persists between app sessions
- **Manual**: Export PDF for backup
- **Reset**: Clear app data to start fresh

## 🎨 UI/UX Features

### Design Principles

- **Mobile-First**: Optimized for mobile devices
- **Responsive**: Adapts to different screen sizes
- **Accessible**: Clear navigation and readable text
- **Modern**: Material Design with custom styling

### Color Scheme

- **Primary**: Blue gradient (#667eea to #764ba2)
- **Secondary**: Pink gradient (#f093fb to #f5576c)
- **Accent**: Green (#4CAF50)
- **Background**: Light gray (#F5F7FA)

## 🔒 Security & Privacy

### Data Protection

- **Local Storage**: All data stored on device
- **No Cloud Sync**: No external data transmission
- **User Control**: Full control over data
- **Export Control**: User-initiated exports only

### Permissions Required

- **Camera**: Photo upload functionality
- **Storage**: PDF export and photo storage
- **Phone**: OTP verification (demo mode)

## 🚀 Future Enhancements

### Planned Features

- [ ] Cloud synchronization
- [ ] Multiple family support
- [ ] Advanced search and filtering
- [ ] Family event calendar
- [ ] Push notifications
- [ ] Multi-language support
- [ ] Dark mode theme
- [ ] Advanced export options

### Technical Improvements

- [ ] Unit and widget tests
- [ ] Performance optimization
- [ ] Accessibility improvements
- [ ] Code documentation
- [ ] CI/CD pipeline

## 📞 Support

### Getting Help

- **Documentation**: Refer to this README
- **Issues**: Check existing GitHub issues
- **Community**: Flutter community forums

### Reporting Bugs

1. **Check existing issues** - Avoid duplicates
2. **Provide details** - Device, OS, steps to reproduce
3. **Include logs** - Debug information if available
4. **Screenshots** - Visual evidence of issues

## 📄 License

This project is developed for educational and demonstration purposes. Please refer to the license file for detailed terms and conditions.

## 👥 Contributing

### Development Setup

1. Fork the repository
2. Create feature branch
3. Make changes
4. Test thoroughly
5. Submit pull request

### Code Standards

- **Dart Style**: Follow official Dart style guide
- **Flutter Best Practices**: Use recommended patterns
- **Documentation**: Comment complex logic
- **Testing**: Add tests for new features

---

**Built with ❤️ using Flutter**

_Wallet Hunter - Connecting Families, Building Communities_
