import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'schedule_screen.dart';
import 'faculty_screen.dart';
import 'events_screen.dart';
import 'emergency_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Campus Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Hello, ${authProvider.userName}!',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(16),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                _buildMenuCard(
                  context,
                  'Schedule',
                  Icons.calendar_today,
                  Colors.orange,
                  () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ScheduleScreen())),
                ),
                _buildMenuCard(
                  context,
                  'Faculty',
                  Icons.people,
                  Colors.green,
                  () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FacultyScreen())),
                ),
                _buildMenuCard(
                  context,
                  'Events',
                  Icons.event,
                  Colors.blue,
                  () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EventsScreen())),
                ),
                _buildMenuCard(
                  context,
                  'Emergency',
                  Icons.emergency,
                  Colors.red,
                  () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EmergencyScreen())),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: color),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
