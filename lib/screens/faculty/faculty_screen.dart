import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/app_design.dart';

class FacultyScreen extends StatelessWidget {
  const FacultyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      appBar: AppBar(
        title: Text(
          'FACULTY DIRECTORY',
          style: GoogleFonts.outfit(fontWeight: FontWeight.bold, letterSpacing: 1.5),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _buildFacultyCard(
            name: 'Dr. Sarah Wilson',
            position: 'Head of Computer Science',
            email: 's.wilson@university.edu',
            office: 'Room 402, Block B',
            hours: 'Mon, Wed: 2PM - 4PM',
            imageUrl: null,
          ),
          const SizedBox(height: 20),
          _buildFacultyCard(
            name: 'Prof. Michael Lee',
            position: 'Senior Lecturer, AI',
            email: 'm.lee@university.edu',
            office: 'Room 105, Block A',
            hours: 'Tue, Thu: 10AM - 12PM',
            imageUrl: null,
          ),
          const SizedBox(height: 20),
          _buildFacultyCard(
            name: 'Dr. Emily Chen',
            position: 'Assistant Professor, Math',
            email: 'e.chen@university.edu',
            office: 'Room 301, Block C',
            hours: 'Fri: 1PM - 3PM',
            imageUrl: null,
          ),
        ],
      ),
    );
  }

  Widget _buildFacultyCard({
    required String name,
    required String position,
    required String email,
    required String office,
    required String hours,
    String? imageUrl,
  }) {
    return Container(
      decoration: AppDesign.glassDecoration(radius: 24),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.person_rounded, color: AppColors.primary, size: 40),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.outfit(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      position,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.white60,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Divider(color: AppColors.glassBorder),
          const SizedBox(height: 16),
          _buildFacultyDetail(Icons.email_outlined, email),
          _buildFacultyDetail(Icons.location_on_outlined, office),
          _buildFacultyDetail(Icons.access_time_rounded, hours),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  'EMAIL',
                  Icons.mail_rounded,
                  () async {
                    final Uri url = Uri.parse('mailto:$email');
                    if (await canLaunchUrl(url)) await launchUrl(url);
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildActionButton(
                  'APPOINTMENT',
                  Icons.calendar_today_rounded,
                  () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFacultyDetail(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.primary),
          const SizedBox(width: 12),
          Text(
            text,
            style: GoogleFonts.inter(color: Colors.white70, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String label, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.primary.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.primary, size: 16),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.outfit(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
