import 'package:flutter/material.dart';
import '../services/report_service.dart';
import '../models/report.dart';
import 'package:uuid/uuid.dart';

class ReportForm extends StatefulWidget {
  @override
  _ReportFormState createState() => _ReportFormState();
}

class _ReportFormState extends State<ReportForm> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final ReportService _reportService = ReportService();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _descriptionController,
            decoration: InputDecoration(labelText: 'Description'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a description';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _locationController,
            decoration: InputDecoration(labelText: 'Location'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a location';
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                final report = Report(
                  id: Uuid().v4(),
                  description: _descriptionController.text,
                  date: DateTime.now(),
                  location: _locationController.text,
                );
                try {
                  await _reportService.addReport(report);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Report submitted')));
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to submit report')));
                }
              }
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}
