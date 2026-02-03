import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/app_design.dart';

class NoticesScreen extends StatelessWidget {
  const NoticesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      appBar: AppBar(
        title: Text(
          'NOTICES',
          style: GoogleFonts.outfit(fontWeight: FontWeight.bold, letterSpacing: 1.5),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _buildNoticeItem(
            title: 'Mid-Term Examination Schedule',
            issuer: 'Dean Office',
            time: '2 hours ago',
            tag: 'Exam',
            content: 'The mid-term examination schedule for Spring 2026 has been finalized. Please check your student portal for individual timetables.',
            tagColor: Colors.redAccent,
          ),
          _buildNoticeItem(
            title: 'Campus Maintenance Notice',
            issuer: 'Admin',
            time: '5 hours ago',
            tag: 'General',
            content: 'Scheduled maintenance of the university WiFi network will take place this Sunday from 8:00 AM to 12:00 PM.',
            tagColor: Colors.blueAccent,
          ),
          _buildNoticeItem(
            title: 'New Library Policies',
            issuer: 'Library Dept',
            time: 'Yesterday',
            tag: 'Library',
            content: 'Please be informed that the library hours have been extended until 11:00 PM for the upcoming exam season.',
            tagColor: Colors.greenAccent,
          ),
        ],
      ),
    );
  }

  Widget _buildNoticeItem({
    required String title,
    required String issuer,
    required String time,
    required String tag,
    required String content,
    required Color tagColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: AppDesign.glassDecoration(radius: 20),
      child: ExpansionTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: tagColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    tag.toUpperCase(),
                    style: TextStyle(color: tagColor, fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  time,
                  style: const TextStyle(color: Colors.white38, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: GoogleFonts.outfit(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        subtitle: Text(
          'Issued by $issuer',
          style: const TextStyle(color: Colors.white54, fontSize: 13),
        ),
        childrenPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        iconColor: AppColors.primary,
        collapsedIconColor: Colors.white38,
        children: [
          Text(
            content,
            style: GoogleFonts.inter(color: Colors.white70, fontSize: 14, height: 1.5),
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.download_rounded, size: 18),
              label: const Text('Download PDF'),
            ),
          ),
        ],
      ),
    );
  }
}
