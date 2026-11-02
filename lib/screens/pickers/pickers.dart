import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';

class DepartmentPicker extends StatefulWidget {
  const DepartmentPicker({super.key});

  @override
  State<DepartmentPicker> createState() => _DepartmentPickerState();
}

class _DepartmentPickerState extends State<DepartmentPicker> {
  final _formKey = GlobalKey<FormState>();
  String? selectedDepartment;
  String? submittedDepartment;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String? message = 'No file selected';

  final List<String> departments = ['Date', 'Time', 'File', 'Marketing'];

  Future<void> pickDate() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  Future<void> pickTime() async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (time != null) {
      setState(() {
        selectedTime = time;
      });
    }
  }

  Future<void> pickFile() async {
    final PlatformFile? file = await FilePicker.pickFile();

    final v = await file?.length();

    setState(() {
      message = (file?.isBlank ?? true)
          ? "File selection cancelled"
          : 'Name: ${file?.name}\nSize: $v bytes';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Employee Registration')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                initialValue: selectedDepartment,
                decoration: const InputDecoration(
                  labelText: 'Select Department',
                  border: OutlineInputBorder(),
                ),
                items: departments.map((department) {
                  return DropdownMenuItem<String>(
                    value: department,
                    child: Text(department),
                  );
                }).toList(),
                onChanged: (department) {
                  setState(() {
                    selectedDepartment = department;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please select something';
                  }
                  return null;
                },
              ),

              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      submittedDepartment = selectedDepartment;
                    });
                  }
                },
                child: Text('submit'),
              ),
              SizedBox(height: 20),
              if (submittedDepartment != null)
                submittedDepartment == 'Date'
                    ? datePicker()
                    : submittedDepartment == 'Time'
                    ? timePicker()
                    : submittedDepartment == 'File'
                    ? filePicker()
                    : Text('selected dept: $submittedDepartment'),
            ],
          ),
        ),
      ),
    );
  }

  Widget datePicker() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton(onPressed: pickDate, child: const Text('Select Date')),
          const SizedBox(height: 20),
          Text(
            selectedDate == null
                ? 'No date selected'
                : 'selected Date: '
                      '${selectedDate!.day}/'
                      '${selectedDate!.month}/'
                      '${selectedDate!.year}',
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }

  Widget timePicker() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton(onPressed: pickTime, child: const Text('Select Time')),
          const SizedBox(height: 20),
          Text(
            selectedTime == null
                ? 'No time selected'
                : 'selected time: '
                      '${selectedTime!.hour}:'
                      '${selectedTime!.minute}',
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }

  Widget filePicker() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton(
            onPressed: pickFile,
            child: const Text('Pick any file'),
          ),
          const SizedBox(height: 20),
          Text(message ?? 'No file selected'),
        ],
      ),
    );
  }
}
