import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/app_design.dart';
import '../notices/notices_screen.dart';
import '../resources/resources_screen.dart';
import '../faculty/faculty_screen.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          'UNIVERSITY HELPER',
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.account_circle_outlined, size: 28),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeHeader(),
            const SizedBox(height: 32),
            _buildQuickAccessGrid(context),
            const SizedBox(height: 32),
            _buildNearbyEventsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hello, Student!',
          style: GoogleFonts.outfit(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Ready for an amazing academic day?',
          style: GoogleFonts.inter(
            fontSize: 16,
            color: Colors.white60,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickAccessGrid(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,
      childAspectRatio: 1.1,
      children: [
        _buildMenuCard(
          context,
          title: 'Notices',
          subtitle: 'Latest updates',
          icon: Icons.campaign_rounded,
          color: Colors.orangeAccent,
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NoticesScreen())),
        ),
        _buildMenuCard(
          context,
          title: 'Resources',
          subtitle: 'PDFs & Notes',
          icon: Icons.folder_shared_rounded,
          color: Colors.lightBlueAccent,
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ResourcesScreen())),
        ),
        _buildMenuCard(
          context,
          title: 'Faculty',
          subtitle: 'Contact info',
          icon: Icons.people_alt_rounded,
          color: Colors.greenAccent,
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FacultyScreen())),
        ),
        _buildMenuCard(
          context,
          title: 'Settings',
          subtitle: 'Profile & App',
          icon: Icons.settings_suggest_rounded,
          color: Colors.pinkAccent,
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildMenuCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: AppDesign.glassDecoration(radius: 20),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Colors.white38,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNearbyEventsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Upcoming Events',
              style: GoogleFonts.outfit(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          decoration: AppDesign.glassDecoration(radius: 24),
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  gradient: AppDesign.primaryGradient,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.event_available_rounded, color: Colors.white, size: 30),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'AI Conference 2026',
                      style: GoogleFonts.outfit(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Today • 2:00 PM • Auditorium',
                      style: GoogleFonts.inter(fontSize: 14, color: Colors.white60),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
