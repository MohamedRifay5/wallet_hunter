import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_hunter/app/controllers/registration_controller.dart';
import 'package:wallet_hunter/app/models/user_model.dart';

class FamilyTreePage extends StatelessWidget {
  const FamilyTreePage({super.key});

  @override
  Widget build(BuildContext context) {
    final RegistrationController controller = Get.find<RegistrationController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          'Family Tree',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF4A90E2),
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: const Icon(Icons.download, color: Colors.white),
              onPressed: () => _exportFamilyTree(context, controller),
            ),
          ),
        ],
      ),
      body: Obx(() {
        final head = controller.currentHead.value;
        if (head == null) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4A90E2)),
                ),
                SizedBox(height: 16),
                Text(
                  'Loading family tree...',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF4A90E2), Color(0xFF357ABD)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Icon(
                        Icons.account_tree,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Family Tree',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${controller.familyMembers.length + 1} members in your family',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Family Tree Visualization
              if (controller.familyMembers.isEmpty)
                Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4A90E2).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Icon(
                          Icons.account_tree_outlined,
                          size: 64,
                          color: const Color(0xFF4A90E2).withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'No Family Members Added',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Add family members to see your beautiful family tree',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: () => Get.toNamed('/family-member-registration'),
                        icon: const Icon(Icons.add),
                        label: const Text('Add First Member'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4A90E2),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              else
                _buildFamilyTree(head, controller.familyMembers),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildFamilyTree(UserModel head, List<UserModel> members) {
    return Column(
      children: [
        // Head of Family
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: _buildFamilyMemberCard(head, isHead: true),
        ),

        // Connection Line
        Container(
          width: 3,
          height: 30,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF4A90E2), Color(0xFF357ABD)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 20),

        // Family Members Grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.9,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: members.length,
          itemBuilder: (context, index) {
            final member = members[index];
            return _buildFamilyMemberCard(member, isHead: false);
          },
        ),
      ],
    );
  }

  Widget _buildFamilyMemberCard(UserModel member, {required bool isHead}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isHead ? Colors.blue.withOpacity(0.2) : Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
        border: isHead ? Border.all(color: const Color(0xFF4A90E2), width: 2) : null,
      ),
      child: InkWell(
        onTap: () => _showMemberDetails(member),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Avatar
              Container(
                width: isHead ? 50 : 40,
                height: isHead ? 50 : 40,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isHead
                        ? [const Color(0xFF4A90E2), const Color(0xFF357ABD)]
                        : [const Color(0xFF4CAF50), const Color(0xFF45A049)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(isHead ? 16 : 12),
                  boxShadow: [
                    BoxShadow(
                      color: (isHead ? Colors.blue : Colors.green).withOpacity(0.3),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  _getGenderIcon(member.gender),
                  size: isHead ? 24 : 20,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),

              // Name
              Text(
                member.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: isHead ? 14 : 12,
                  color: isHead ? const Color(0xFF4A90E2) : Colors.black87,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              // Role/Relation
              Container(
                margin: const EdgeInsets.only(top: 3),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                decoration: BoxDecoration(
                  color: isHead ? const Color(0xFF4A90E2).withOpacity(0.1) : const Color(0xFF4CAF50).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  isHead ? 'Head' : (member.relationWithHead ?? 'Member'),
                  style: TextStyle(
                    fontSize: 9,
                    color: isHead ? const Color(0xFF4A90E2) : const Color(0xFF4CAF50),
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              // Age
              Container(
                margin: const EdgeInsets.only(top: 4),
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '${member.age}y',
                  style: const TextStyle(
                    fontSize: 9,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              // Special indicators
              if (isHead)
                Container(
                  margin: const EdgeInsets.only(top: 6),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF4A90E2), Color(0xFF357ABD)],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'HEAD',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getGenderIcon(String gender) {
    switch (gender.toLowerCase()) {
      case 'male':
        return Icons.male;
      case 'female':
        return Icons.female;
      default:
        return Icons.person;
    }
  }

  void _showMemberDetails(UserModel member) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: member.isHead
                            ? [const Color(0xFF4A90E2), const Color(0xFF357ABD)]
                            : [const Color(0xFF4CAF50), const Color(0xFF45A049)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(
                      _getGenderIcon(member.gender),
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          member.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 4),
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: member.isHead
                                ? const Color(0xFF4A90E2).withOpacity(0.1)
                                : const Color(0xFF4CAF50).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            member.isHead ? 'Family Head' : (member.relationWithHead ?? 'Member'),
                            style: TextStyle(
                              fontSize: 12,
                              color: member.isHead ? const Color(0xFF4A90E2) : const Color(0xFF4CAF50),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Details
              _buildDetailRow('Age', '${member.age} years'),
              _buildDetailRow('Gender', member.gender),
              _buildDetailRow('Marital Status', member.maritalStatus),
              _buildDetailRow('Occupation', member.occupation),
              _buildDetailRow('Qualification', member.qualification),
              _buildDetailRow('Blood Group', member.bloodGroup),
              _buildDetailRow('Phone', member.phoneNumber),
              _buildDetailRow('Email', member.email),
              _buildDetailRow('Address', '${member.flatNumber}, ${member.buildingName}, ${member.city}'),

              const SizedBox(height: 24),

              // Action Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    if (!member.isHead) {
                      Get.toNamed('/edit-family-member', arguments: member);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4A90E2),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(member.isHead ? 'Close' : 'Edit Member'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  void _exportFamilyTree(BuildContext context, RegistrationController controller) async {
    final pdfPath = await controller.exportFamilyTree();
    if (pdfPath != null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Family tree exported successfully!\nPath: $pdfPath'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 5),
            action: SnackBarAction(
              label: 'OK',
              textColor: Colors.white,
              onPressed: () {},
            ),
          ),
        );
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to export family tree. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
