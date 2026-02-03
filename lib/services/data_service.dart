import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/app_models.dart';

class DataService {
  static Future<List<ScheduleModel>> loadSchedule() async {
    final String response = await rootBundle.loadString('assets/data/schedule.json');
    final List<dynamic> data = json.decode(response);
    return data.map((json) => ScheduleModel.fromJson(json)).toList();
  }

  static Future<List<FacultyModel>> loadFaculty() async {
    final String response = await rootBundle.loadString('assets/data/faculty.json');
    final List<dynamic> data = json.decode(response);
    return data.map((json) => FacultyModel.fromJson(json)).toList();
  }

  static Future<List<EventModel>> loadEvents() async {
    final String response = await rootBundle.loadString('assets/data/events.json');
    final List<dynamic> data = json.decode(response);
    return data.map((json) => EventModel.fromJson(json)).toList();
  }

  static Future<List<ContactModel>> loadContacts() async {
    final String response = await rootBundle.loadString('assets/data/contacts.json');
    final List<dynamic> data = json.decode(response);
    return data.map((json) => ContactModel.fromJson(json)).toList();
  }
}
