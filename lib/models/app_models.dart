class ScheduleModel {
  final String id;
  final String subject;
  final String time;
  final String location;
  final String day;
  final String faculty;

  ScheduleModel({
    required this.id,
    required this.subject,
    required this.time,
    required this.location,
    required this.day,
    required this.faculty,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      id: json['id'],
      subject: json['subject'],
      time: json['time'],
      location: json['location'],
      day: json['day'],
      faculty: json['faculty'],
    );
  }
}

class FacultyModel {
  final String id;
  final String name;
  final String department;
  final String designation;
  final String email;
  final String phone;
  final String office;

  FacultyModel({
    required this.id,
    required this.name,
    required this.department,
    required this.designation,
    required this.email,
    required this.phone,
    required this.office,
  });

  factory FacultyModel.fromJson(Map<String, dynamic> json) {
    return FacultyModel(
      id: json['id'],
      name: json['name'],
      department: json['department'],
      designation: json['designation'],
      email: json['email'],
      phone: json['phone'],
      office: json['office'],
    );
  }
}

class EventModel {
  final String id;
  final String title;
  final String date;
  final String description;
  final String location;

  EventModel({
    required this.id,
    required this.title,
    required this.date,
    required this.description,
    required this.location,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'],
      title: json['title'],
      date: json['date'],
      description: json['description'],
      location: json['location'],
    );
  }
}

class ContactModel {
  final String name;
  final String number;
  final String type;

  ContactModel({
    required this.name,
    required this.number,
    required this.type,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      name: json['name'],
      number: json['number'],
      type: json['type'],
    );
  }
}
