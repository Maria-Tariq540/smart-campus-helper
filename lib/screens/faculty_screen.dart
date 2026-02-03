import 'package:flutter/material.dart';
import '../models/app_models.dart';
import '../services/data_service.dart';

class FacultyScreen extends StatefulWidget {
  const FacultyScreen({super.key});

  @override
  State<FacultyScreen> createState() => _FacultyScreenState();
}

class _FacultyScreenState extends State<FacultyScreen> {
  String _searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Faculty Directory')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) => setState(() => _searchQuery = value.toLowerCase()),
              decoration: const InputDecoration(
                hintText: 'Search by name or department',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<FacultyModel>>(
              future: DataService.loadFaculty(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final faculty = snapshot.data ?? [];
                final filtered = faculty.where((f) =>
                    f.name.toLowerCase().contains(_searchQuery) ||
                    f.department.toLowerCase().contains(_searchQuery)).toList();

                return ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final prof = filtered[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ListTile(
                        leading: const CircleAvatar(child: Icon(Icons.person)),
                        title: Text(prof.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text('${prof.designation} - ${prof.department}'),
                        onTap: () => _showFacultyDetails(context, prof),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showFacultyDetails(BuildContext context, FacultyModel prof) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(prof.name, style: Theme.of(context).textTheme.headlineSmall),
            const Divider(),
            _detailRow(Icons.email, prof.email),
            _detailRow(Icons.phone, prof.phone),
            _detailRow(Icons.location_on, 'Office: ${prof.office}'),
          ],
        ),
      ),
    );
  }

  Widget _detailRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue, size: 20),
          const SizedBox(width: 12),
          Text(text),
        ],
      ),
    );
  }
}
