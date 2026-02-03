import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/app_design.dart';
import 'home_tab.dart';
import 'settings_screen.dart';
import '../schedule/schedule_screen.dart';
import '../events/events_screen.dart';
import '../emergency/emergency_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeTab(),
    const ScheduleScreen(),
    const EventsScreen(),
    const EmergencyScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(),
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: const BoxDecoration(
          color: AppColors.darkBg,
          border: Border(top: BorderSide(color: AppColors.glassBorder)),
        ),
        child: Container(
          decoration: AppDesign.glassDecoration(radius: 25),
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: (index) => setState(() => _selectedIndex = index),
            backgroundColor: Colors.transparent,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: Colors.white38,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_filled),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month_rounded),
                label: 'Schedule',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications_active_rounded),
                label: 'Events',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.emergency_rounded),
                label: 'Emergency',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: AppColors.darkBg,
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(gradient: AppDesign.primaryGradient),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.school_rounded, color: Colors.white, size: 50),
                  const SizedBox(height: 10),
                  Text(
                    'SMART CAMPUS',
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),
          _buildDrawerTile(Icons.campaign_rounded, 'Notice Board', () {
            Navigator.pop(context);
            // Navigate to Notice Board (could be a tab or separate page)
          }),
          _buildDrawerTile(Icons.folder_shared_rounded, 'Resource Storage', () {}),
          _buildDrawerTile(Icons.people_alt_rounded, 'Faculty Connect', () {}),
          _buildDrawerTile(Icons.settings_suggest_rounded, 'App Settings', () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()));
          }),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              'v1.0.0 Alpha',
              style: GoogleFonts.inter(color: Colors.white24, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(
        title,
        style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w500),
      ),
      onTap: onTap,
    );
  }
}
