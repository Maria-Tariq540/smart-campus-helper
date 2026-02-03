import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/app_design.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      appBar: AppBar(
        title: Text(
          'SETTINGS',
          style: GoogleFonts.outfit(fontWeight: FontWeight.bold, letterSpacing: 1.5),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _buildProfileSection(),
          const SizedBox(height: 32),
          _buildSettingsGroup('Preferences', [
            _buildSettingTile(Icons.dark_mode_rounded, 'Dark Mode', true),
            _buildSettingTile(Icons.notifications_active_rounded, 'Push Notifications', true),
            _buildSettingTile(Icons.location_on_rounded, 'Campus Location', false),
          ]),
          const SizedBox(height: 24),
          _buildSettingsGroup('Account', [
            _buildSettingTile(Icons.person_outline_rounded, 'Edit Profile', null),
            _buildSettingTile(Icons.lock_outline_rounded, 'Change Password', null),
          ]),
          const SizedBox(height: 40),
          _buildLogoutButton(),
        ],
      ),
    );
  }

  Widget _buildProfileSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: AppDesign.glassDecoration(radius: 24),
      child: Row(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: AppColors.primary.withOpacity(0.1),
            child: const Icon(Icons.person_rounded, color: AppColors.primary, size: 40),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Student User',
                  style: GoogleFonts.outfit(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                Text(
                  'student.user@university.edu',
                  style: GoogleFonts.inter(fontSize: 14, color: Colors.white60),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsGroup(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white30, letterSpacing: 2),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: AppDesign.glassDecoration(radius: 20),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildSettingTile(IconData icon, String title, bool? value) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary, size: 22),
      title: Text(title, style: GoogleFonts.inter(color: Colors.white, fontSize: 16)),
      trailing: value == null 
          ? const Icon(Icons.chevron_right_rounded, color: Colors.white24)
          : Switch(
              value: value,
              onChanged: (v) {},
              activeThumbColor: AppColors.primary,
            ),
    );
  }

  Widget _buildLogoutButton() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.redAccent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.redAccent.withOpacity(0.3)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.logout_rounded, color: Colors.redAccent, size: 20),
                const SizedBox(width: 12),
                Text(
                  'LOG OUT',
                  style: GoogleFonts.outfit(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
