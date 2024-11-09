class Report {
  final String id;
  final String description;
  final DateTime date;
  final String location;

  Report({required this.id, required this.description, required this.date, required this.location});

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['_id'],
      description: json['description'],
      date: DateTime.parse(json['date']),
      location: json['location'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'description': description,
      'date': date.toIso8601String(),
      'location': location,
    };
  }
}
