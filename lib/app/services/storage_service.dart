import 'package:get_storage/get_storage.dart';
import 'package:wallet_hunter/app/models/user_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class StorageService {
  static const String _usersKey = 'users';
  static const String _currentUserKey = 'currentUser';
  static const String _isLoggedInKey = 'isLoggedIn';
  static const String _otpKey = 'otp';

  final GetStorage _storage = GetStorage();

  // User Management
  Future<void> saveUser(UserModel user) async {
    final users = await getUsers();
    final existingUserIndex = users.indexWhere((u) => u.id == user.id);

    if (existingUserIndex != -1) {
      users[existingUserIndex] = user;
    } else {
      users.add(user);
    }

    await _storage.write(_usersKey, users.map((u) => u.toJson()).toList());
  }

  Future<List<UserModel>> getUsers() async {
    final usersData = _storage.read(_usersKey) as List<dynamic>? ?? [];
    return usersData.map((json) => UserModel.fromJson(json)).toList();
  }

  Future<UserModel?> getUserById(String id) async {
    final users = await getUsers();
    try {
      return users.firstWhere((user) => user.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<UserModel?> getHeadByPhone(String phoneNumber) async {
    final users = await getUsers();
    try {
      return users.firstWhere((user) => user.isHead && user.phoneNumber == phoneNumber);
    } catch (e) {
      return null;
    }
  }

  Future<List<UserModel>> getFamilyMembers(String headId) async {
    final users = await getUsers();
    return users.where((user) => user.headId == headId).toList();
  }

  Future<void> deleteUser(String id) async {
    final users = await getUsers();
    users.removeWhere((user) => user.id == id);
    await _storage.write(_usersKey, users.map((u) => u.toJson()).toList());
  }

  // Authentication
  Future<void> setCurrentUser(UserModel user) async {
    await _storage.write(_currentUserKey, user.toJson());
    await _storage.write(_isLoggedInKey, true);
  }

  Future<UserModel?> getCurrentUser() async {
    final userData = _storage.read(_currentUserKey);
    if (userData != null) {
      return UserModel.fromJson(userData);
    }
    return null;
  }

  Future<bool> isLoggedIn() async {
    return _storage.read(_isLoggedInKey) ?? false;
  }

  Future<void> logout() async {
    await _storage.remove(_currentUserKey);
    await _storage.write(_isLoggedInKey, false);
  }

  // OTP Management
  Future<void> saveOTP(String phoneNumber, String otp) async {
    await _storage.write(_otpKey, {'phoneNumber': phoneNumber, 'otp': otp});
  }

  Future<Map<String, String>?> getOTP() async {
    final otpData = _storage.read(_otpKey);
    if (otpData != null) {
      return {
        'phoneNumber': otpData['phoneNumber'],
        'otp': otpData['otp'],
      };
    }
    return null;
  }

  Future<void> clearOTP() async {
    await _storage.remove(_otpKey);
  }

  // Export Functionality
  Future<String> exportFamilyTreeAsPDF(UserModel head, List<UserModel> familyMembers) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        header: (pw.Context context) {
          return pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                'Family Tree - ${head.name}',
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Text(
                'Generated on: ${DateTime.now().toString().split('.')[0]}',
                style: const pw.TextStyle(fontSize: 12),
              ),
            ],
          );
        },
        footer: (pw.Context context) {
          return pw.Text(
            'Generated by Wallet Hunter App',
            style: const pw.TextStyle(fontSize: 10),
            textAlign: pw.TextAlign.center,
          );
        },
        build: (pw.Context context) {
          return [
            // Head Information
            pw.Container(
              padding: const pw.EdgeInsets.all(16),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(),
                borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'Family Head',
                    style: pw.TextStyle(
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 8),
                  _buildInfoRow('Name', head.name),
                  _buildInfoRow('Age', '${head.age} years'),
                  _buildInfoRow('Gender', head.gender),
                  _buildInfoRow('Occupation', head.occupation),
                  _buildInfoRow('Samaj', head.samajName),
                  _buildInfoRow('Phone', head.phoneNumber),
                  _buildInfoRow('Email', head.email),
                  _buildInfoRow('Address', '${head.flatNumber}, ${head.buildingName}, ${head.city}'),
                ],
              ),
            ),

            pw.SizedBox(height: 20),

            // Family Members
            pw.Text(
              'Family Members (${familyMembers.length})',
              style: pw.TextStyle(
                fontSize: 18,
                fontWeight: pw.FontWeight.bold,
              ),
            ),

            pw.SizedBox(height: 10),

            // Family Members Table
            if (familyMembers.isNotEmpty)
              pw.Table(
                border: pw.TableBorder.all(),
                children: [
                  // Header row
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text('Name', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text('Relation', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text('Age', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text('Occupation', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text('Phone', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                    ],
                  ),
                  // Data rows
                  ...familyMembers.map((member) => pw.TableRow(
                        children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8),
                            child: pw.Text(member.name),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8),
                            child: pw.Text(member.relationWithHead ?? 'N/A'),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8),
                            child: pw.Text('${member.age} years'),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8),
                            child: pw.Text(member.occupation),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8),
                            child: pw.Text(member.phoneNumber),
                          ),
                        ],
                      )),
                ],
              )
            else
              pw.Text('No family members added yet.'),

            pw.SizedBox(height: 20),
          ];
        },
      ),
    );

    // Save PDF
    final output = await getTemporaryDirectory();
    final file = File('${output.path}/family_tree_${head.name.replaceAll(' ', '_')}.pdf');
    await file.writeAsBytes(await pdf.save());

    return file.path;
  }

  pw.Widget _buildInfoRow(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 2),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.SizedBox(
            width: 80,
            child: pw.Text(
              '$label:',
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.Expanded(
            child: pw.Text(value),
          ),
        ],
      ),
    );
  }

  // Utility Methods
  Future<void> clearAllData() async {
    await _storage.erase();
  }

  String generateId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }
}
