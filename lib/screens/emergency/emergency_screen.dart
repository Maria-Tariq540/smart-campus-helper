import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/app_design.dart';

class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          'EMERGENCY CONTACTS',
          style: GoogleFonts.outfit(fontWeight: FontWeight.bold, letterSpacing: 1.5),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _buildEmergencyCard(
            title: 'Campus Security',
            number: '+1 234 567 8900',
            icon: Icons.security_rounded,
            color: Colors.redAccent,
          ),
          const SizedBox(height: 20),
          _buildEmergencyCard(
            title: 'Medical Center',
            number: '+1 234 567 8911',
            icon: Icons.medical_services_rounded,
            color: Colors.blueAccent,
          ),
          const SizedBox(height: 20),
          _buildEmergencyCard(
            title: 'Fire Department',
            number: '911',
            icon: Icons.local_fire_department_rounded,
            color: Colors.orangeAccent,
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'These numbers are accessible 24/7 for immediate assistance within and around the campus.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(color: Colors.white38, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyCard({
    required String title,
    required String number,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      decoration: AppDesign.glassDecoration(radius: 24),
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(icon, color: color, size: 32),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.outfit(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  number,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: Colors.white60,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              final Uri url = Uri.parse('tel:$number');
              if (await canLaunchUrl(url)) {
                await launchUrl(url);
              }
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.call_rounded, color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}
