import 'package:flutter/material.dart';
import '../widgets/update_list.dart';

class UpdateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Updates'),
      ),
      body: UpdateList(),
    );
  }
}
