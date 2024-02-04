import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AutomationScreen extends StatefulWidget {
  @override
  _AutomationScreenState createState() => _AutomationScreenState();
}

class _AutomationScreenState extends State<AutomationScreen> {
  TextEditingController _startTimeController = TextEditingController();
  TextEditingController _stopTimeController = TextEditingController();
  final DatabaseReference _start =
  FirebaseDatabase.instance.reference().child('AutomaticSwitch/start-time');
  final DatabaseReference _stop =
  FirebaseDatabase.instance.reference().child('AutomaticSwitch/stop-time');

  Timer? timer;
  late FirebaseFirestore firestore;

  @override
  void initState() {
    super.initState();


    // Start a timer to check the time periodically
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        // Check if the current time is within the specified range
        bool isSwitchOn = _isCurrentTimeInRange();


      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Center(child: Text('Switch Control with Counter')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildTimeTextField(
              controller: _startTimeController,
              labelText: 'Start Time',
              hintText: 'HH:MM',
            ),
            SizedBox(height: 16),
            _buildTimeTextField(
              controller: _stopTimeController,
              labelText: 'Stop Time',
              hintText: 'HH:MM',
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _updateFirebase,
              child: Text('Save Data'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeTextField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        suffixIcon: IconButton(
          onPressed: () {
            _selectTime(context, isStart: controller == _startTimeController);
          },
          icon: Icon(Icons.access_time),
        ),
      ),
      keyboardType: TextInputType.datetime,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^([01]?[0-9]|2[0-3]):[0-5][0-9]$')),
      ],
    );
  }

  Future<void> _selectTime(BuildContext context, {required bool isStart}) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      final String formattedTime =
          '${picked.hour}:${picked.minute.toString().padLeft(2, '0')}';

      setState(() {
        if (isStart) {
          _startTimeController.text = formattedTime;
        } else {
          _stopTimeController.text = formattedTime;
        }
      });

      // Update Firebase with the new start or stop time
      //_updateFirebase();
    }
  }

  bool _isCurrentTimeInRange() {
    final DateTime now = DateTime.now();
    final DateTime startTime =
    DateTime.parse("2024-01-01 ${_startTimeController.text}:00");
    final DateTime stopTime =
    DateTime.parse("2024-01-01 ${_stopTimeController.text}:00");

    return now.isAfter(startTime) && now.isBefore(stopTime);
  }

  void _updateFirebase() {
    // Update Firebase with the new start or stop time
    _start.set(_startTimeController.text);
    _stop.set(_stopTimeController.text);
  }

  @override
  void dispose() {
    // Cancel the timer to avoid memory leaks
    timer?.cancel();
    super.dispose();
  }
}
