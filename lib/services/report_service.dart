import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/report.dart';

class ReportService {
  final String apiUrl = 'http://localhost:5000/api/reports';

  Future<void> addReport(Report report) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'description': report.description,
          'location': report.location,
        }),
      );

      if (response.statusCode != 201) {
        throw Exception('Failed to create report');
      }
    } catch (e) {
      throw Exception('Failed to create report: $e');
    }
  }

  Future<List<Report>> getReports() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        return body.map((dynamic item) => Report.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load reports');
      }
    } catch (e) {
      throw Exception('Failed to load reports: $e');
    }
  }
}
