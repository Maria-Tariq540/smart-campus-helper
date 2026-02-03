import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/app_design.dart';

class ResourcesScreen extends StatefulWidget {
  const ResourcesScreen({super.key});

  @override
  State<ResourcesScreen> createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends State<ResourcesScreen> {
  bool isFaculty = true; // Placeholder for role-based check

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      appBar: AppBar(
        title: Text(
          'RESOURCES',
          style: GoogleFonts.outfit(fontWeight: FontWeight.bold, letterSpacing: 1.5),
        ),
      ),
      body: Column(
        children: [
          _buildSearchAndFilter(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                _buildCourseFolder(
                  course: 'Computer Science',
                  filesCount: 12,
                  icon: Icons.code_rounded,
                  color: Colors.blueAccent,
                ),
                _buildCourseFolder(
                  course: 'Mathematics',
                  filesCount: 8,
                  icon: Icons.functions_rounded,
                  color: Colors.orangeAccent,
                ),
                _buildCourseFolder(
                  course: 'Physics',
                  filesCount: 5,
                  icon: Icons.psychology_rounded,
                  color: Colors.greenAccent,
                ),
                const SizedBox(height: 20),
                Text(
                  'RECENT UPLOADS',
                  style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white30, letterSpacing: 2),
                ),
                const SizedBox(height: 16),
                _buildFileItem(name: 'Algorithms_Lecture_1.pdf', size: '2.4 MB', date: 'Today'),
                _buildFileItem(name: 'Quantum_Mechanics_Notes.pdf', size: '1.8 MB', date: 'Yesterday'),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: isFaculty 
          ? FloatingActionButton.extended(
              onPressed: () {},
              backgroundColor: AppColors.primary,
              icon: const Icon(Icons.upload_file_rounded, color: Colors.white),
              label: const Text('UPLOAD NOTES', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            )
          : null,
    );
  }

  Widget _buildSearchAndFilter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: AppDesign.glassDecoration(radius: 16),
              child: const TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search resources...',
                  hintStyle: TextStyle(color: Colors.white24, fontSize: 14),
                  icon: Icon(Icons.search_rounded, color: Colors.white38),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: AppDesign.glassDecoration(radius: 12),
            child: const Icon(Icons.filter_list_rounded, color: AppColors.primary),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseFolder({
    required String course,
    required int filesCount,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: AppDesign.glassDecoration(radius: 20),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course,
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '$filesCount files',
                  style: const TextStyle(color: Colors.white38, fontSize: 13),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: Colors.white24),
        ],
      ),
    );
  }

  Widget _buildFileItem({required String name, required String size, required String date}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          const Icon(Icons.picture_as_pdf_rounded, color: Colors.redAccent, size: 30),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '$size • $date',
                  style: const TextStyle(color: Colors.white38, fontSize: 12),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert_rounded, color: Colors.white38),
          ),
        ],
      ),
    );
  }
}
