import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/app_design.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          'ACADEMIC SCHEDULE',
          style: GoogleFonts.outfit(fontWeight: FontWeight.bold, letterSpacing: 1.5),
        ),
      ),
      body: Column(
        children: [
          _buildDaySelector(),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              children: [
                _buildScheduleItem(
                  time: '09:00 AM',
                  subject: 'Data Structures',
                  room: 'Lab 402',
                  instructor: 'Dr. Sarah Wilson',
                  color: Colors.blueAccent,
                ),
                _buildScheduleItem(
                  time: '11:30 AM',
                  subject: 'Machine Learning',
                  room: 'Seminar Hall 1',
                  instructor: 'Alex Johnson',
                  color: Colors.purpleAccent,
                ),
                _buildScheduleItem(
                  time: '02:00 PM',
                  subject: 'Web Development',
                  room: 'Room 105',
                  instructor: 'Prof. Michael Lee',
                  color: Colors.tealAccent,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add_rounded, color: Colors.white),
      ),
    );
  }

  Widget _buildDaySelector() {
    final days = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'];
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: days.length,
        itemBuilder: (context, index) {
          bool isSelected = index == 0; // Mock selection
          return Container(
            width: 70,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: isSelected
                ? BoxDecoration(
                    gradient: AppDesign.primaryGradient,
                    borderRadius: BorderRadius.circular(20),
                  )
                : AppDesign.glassDecoration(radius: 20),
            child: Center(
              child: Text(
                days[index],
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : Colors.white38,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildScheduleItem({
    required String time,
    required String subject,
    required String room,
    required String instructor,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Text(
                time.split(' ')[0],
                style: GoogleFonts.outfit(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                time.split(' ')[1],
                style: GoogleFonts.inter(fontSize: 12, color: Colors.white38),
              ),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: AppDesign.glassDecoration(radius: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        subject,
                        style: GoogleFonts.outfit(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Lecture',
                          style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined, size: 14, color: color),
                      const SizedBox(width: 4),
                      Text(room, style: const TextStyle(color: Colors.white60, fontSize: 13)),
                      const SizedBox(width: 16),
                      Icon(Icons.person_outline_rounded, size: 14, color: color),
                      const SizedBox(width: 4),
                      Text(instructor, style: const TextStyle(color: Colors.white60, fontSize: 13)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
