import 'package:flutter/material.dart';
import '../services/report_service.dart';
import '../models/report.dart';

class UpdateList extends StatelessWidget {
  final ReportService _reportService = ReportService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Report>>(
      future: _reportService.getReports(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No reports found'));
        } else {
          final reports = snapshot.data!;
          return ListView.builder(
            itemCount: reports.length,
            itemBuilder: (context, index) {
              final report = reports[index];
              return ListTile(
                title: Text(report.description),
                subtitle: Text(report.location),
                trailing: Text(report.date.toString()),
              );
            },
          );
        }
      },
    );
  }
}
