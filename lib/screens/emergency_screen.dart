import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/app_models.dart';
import '../services/data_service.dart';

class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({super.key});

  Future<void> _makeCall(String number) async {
    final Uri launchUri = Uri(scheme: 'tel', path: number);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Emergency Contacts')),
      body: FutureBuilder<List<ContactModel>>(
        future: DataService.loadContacts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final contacts = snapshot.data ?? [];
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              final contact = contacts[index];
              final isEmergency = contact.type == 'Emergency';
              return Card(
                color: isEmergency ? Colors.red[50] : null,
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: isEmergency ? Colors.red : Colors.blue,
                    child: Icon(isEmergency ? Icons.warning : Icons.phone, color: Colors.white),
                  ),
                  title: Text(contact.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(contact.number),
                  trailing: IconButton(
                    icon: const Icon(Icons.call, color: Colors.green),
                    onPressed: () => _makeCall(contact.number),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
