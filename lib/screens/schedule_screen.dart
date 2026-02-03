import 'package:flutter/material.dart';
import '../models/app_models.dart';
import '../services/data_service.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Class Schedule')),
      body: FutureBuilder<List<ScheduleModel>>(
        future: DataService.loadSchedule(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading schedule'));
          }
          final schedule = snapshot.data ?? [];
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: schedule.length,
            itemBuilder: (context, index) {
              final item = schedule[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(item.day[0]),
                  ),
                  title: Text(item.subject, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('${item.time}\n${item.location}'),
                  trailing: Text(item.faculty, style: const TextStyle(fontSize: 12)),
                  isThreeLine: true,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
