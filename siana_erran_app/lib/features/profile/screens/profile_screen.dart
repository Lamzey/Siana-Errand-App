import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:siana_erran_app/features/Errands/screens/errand_history.dart';
import 'package:siana_erran_app/features/profile/screens/edit_profile_screen.dart';
import 'package:siana_erran_app/widgets/customappbar_widgets.dart';

class ProfileScreen extends StatelessWidget {
  final bool addLeading;
  const ProfileScreen({super.key, this.addLeading = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "My Profile", addLeading: addLeading),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.black.withValues(alpha: 0.05),
                //     blurRadius: 10,
                //     offset: const Offset(0, 2),
                //   ),
                // ],
              ),
              child: Row(
                children: [
                  // Profile Avatar
                  CircleAvatar(
                    radius: 36,
                    backgroundColor: Colors.grey.shade200,
                    child: const Icon(
                      Icons.person,
                      size: 35,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 23),
                  // Name
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Gao Pena',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),

                      Text(
                        'gaopena@example.com',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Edit Profile Button
                      OutlinedButton(
                        onPressed: () {
                          pushScreenWithNavBar(context, EditProfileScreen());
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.pink),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 8,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Edit Profile',
                              style: TextStyle(
                                color: Colors.pink,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(Icons.chevron_right, color: Colors.pink),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // Email
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Menu Items
            _buildMenuSection([
              _buildMenuItem(
                icon: Icons.person_outline,
                title: 'Personal Information',
                onTap: () {
                  pushScreenWithNavBar(context, ErrandHistoryScreen());
                },
              ),
              _buildMenuItem(
                icon: Icons.credit_card_outlined,
                title: 'Wallet',
                onTap: () {},
              ),
              _buildMenuItem(
                icon: Icons.history,
                title: 'Errand History',
                onTap: () {
                  pushScreenWithNavBar(context, ErrandHistoryScreen());
                },
              ),
              _buildMenuItem(
                icon: Icons.description_outlined,
                title: 'Verification Centre',
                onTap: () {},
              ),
              _buildMenuItem(
                icon: Icons.star_outline,
                title: 'Ratings and Review',
                onTap: () {},
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuSection(List<Widget> items) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(children: items),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      padding: const EdgeInsets.all(6),
      margin: EdgeInsets.only(top: 8, bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: Colors.deepPurple.shade400, size: 28),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        trailing: Icon(Icons.chevron_right, color: Colors.black),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),
    );
  }
}
