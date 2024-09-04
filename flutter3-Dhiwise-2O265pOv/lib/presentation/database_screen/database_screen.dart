import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_drop_down.dart';
import '../../model/camera_user_detected.dart';
import '../../services/api_service.dart';

class DatabaseScreen extends StatefulWidget {
  const DatabaseScreen({Key? key}) : super(key: key);

  @override
  _DatabaseScreenState createState() => _DatabaseScreenState();
}

class _DatabaseScreenState extends State<DatabaseScreen> {
  final ApiService apiService = ApiService();
  late DateTime selectedDate;
  List<DetectedFace> detectedFaces = [];

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    fetchDetectedFaces();
  }

  Future<void> fetchDetectedFaces() async {
    try {
      final faces = await apiService.getDetectedFaces(
        date: selectedDate.day.toString().padLeft(2, '0'),
        month: selectedDate.month.toString().padLeft(2, '0'),
        year: selectedDate.year.toString(),
      );
      setState(() {
        detectedFaces = faces.results ?? [];
      });
    } catch (e) {
      print('Error fetching faces: $e');
      // Consider showing an error message to the user
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000), // Set the earliest date that can be picked
      lastDate: DateTime.now(),  // Set the latest date that can be picked
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: Colors.orange, // Header background color
              onPrimary: Colors.black, // Header text color
              surface: Colors.grey[900]!, // Background color
              onSurface: Colors.orange, // Text color
            ),
            dialogBackgroundColor: Colors.grey[800], // Popup background color
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        fetchDetectedFaces(); // Refresh the detected faces based on the new date
      });
    }
  }

  void _renameFace(DetectedFace face) async {
    final TextEditingController controller = TextEditingController(text: face.faceId);
    final newName = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900], // Background color of the AlertDialog
        title: Text(
          "Rename Face",
          style: TextStyle(color: Colors.orange), // Title text color
        ),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: "Enter new name",
            filled: true,
            hintStyle: TextStyle(color: Colors.white54), // Hint text color
            fillColor: Colors.grey[800], // Background color of the TextField
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.orange), // Border color
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.blueGrey, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.blue, width: 2), // Border color when focused
            ),
          ),
          cursorColor: Colors.orange,
          style: TextStyle(color: Colors.white), // Text color inside TextField
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.orange), // Cancel button text color
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(controller.text),
            child: Text(
              "Save",
              style: TextStyle(color: Colors.orange), // Save button text color
            ),
          ),
        ],
      ),
    );

    if (newName != null && newName.isNotEmpty) {
      try {
        final success = await apiService.renameFace(face.id!, newName);
        if (success) {
          fetchDetectedFaces();
        }
      } catch (e) {
        print('Error renaming face: $e');
        // Consider showing an error message to the user
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        body: Column(
          children: [
            SizedBox(height: 39),
            _buildRowDatabase(context),
            SizedBox(height: 22),
            _buildDateSelection(),
            SizedBox(height: 24),
            _buildDetectedFacesList(),
          ],
        ),
      ),
    );
  }

  Widget _buildRowDatabase(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Database",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
          ),
          IconButton(
            onPressed: () => Navigator.pushNamed(context, AppRoutes.notificationsScreen),
            icon: Icon(Icons.notifications_none, color: Colors.white, size: 40),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSelection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () => _selectDate(context),
            child: Text(
              DateFormat('dd MMMM yyyy').format(selectedDate),
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 26, vertical: 8),
              backgroundColor: Colors.orange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetectedFacesList() {
    return Expanded(
      child: detectedFaces.isEmpty
          ? Center(child: Text("No detected faces", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)))
          : ListView.builder(
        itemCount: detectedFaces.length,
        itemBuilder: (context, index) {
          final face = detectedFaces[index];
          return ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: CircleAvatar(
              backgroundImage: MemoryImage(base64Decode(face.image ?? '')),
              radius: 30,
            ),
            title: Text(
              face.faceId ?? "Unknown",
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              face.lastSeen ?? "",
              style: TextStyle(color: Colors.grey),
            ),
            trailing: IconButton(
              icon: Icon(Icons.edit, color: Colors.white),
              onPressed: () => _renameFace(face),
            ),
            tileColor: face.faceId != "unknown" ? Colors.grey[850] : Colors.red[900],
          );
        },
      ),
    );
  }
}
