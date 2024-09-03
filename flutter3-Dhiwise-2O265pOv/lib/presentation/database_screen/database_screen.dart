///lib/presentation/database_screen.dart
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildDateDropdown(),
          _buildMonthDropdown(),
          _buildYearDropdown(),
        ],
      ),
    );
  }

  Widget _buildDateDropdown() {
    return CustomDropDown(
      width: 70,
      hintText: selectedDate.day.toString().padLeft(2, '0'),
      items: List.generate(31, (index) => (index + 1).toString().padLeft(2, '0')),
      onChanged: (value) {
        setState(() {
          selectedDate = DateTime(selectedDate.year, selectedDate.month, int.parse(value));
          fetchDetectedFaces();
        });
      },
    );
  }

  Widget _buildMonthDropdown() {
    return CustomDropDown(
      width: 140,
      hintText: DateFormat('MMMM').format(selectedDate),
      items: DateFormat.MMMM().dateSymbols.MONTHS,
      onChanged: (value) {
        setState(() {
          selectedDate = DateTime(selectedDate.year, DateFormat.MMMM().dateSymbols.MONTHS.indexOf(value) + 1, selectedDate.day);
          fetchDetectedFaces();
        });
      },
    );
  }

  Widget _buildYearDropdown() {
    return CustomDropDown(
      width: 95,
      hintText: selectedDate.year.toString(),
      items: List.generate(10, (index) => (DateTime.now().year - index).toString()),
      onChanged: (value) {
        setState(() {
          selectedDate = DateTime(int.parse(value), selectedDate.month, selectedDate.day);
          fetchDetectedFaces();
        });
      },
    );
  }

  Widget _buildDetectedFacesList() {
    return Expanded(
      child: detectedFaces.isEmpty
          ? Center(child: Text("No detected faces", style: TextStyle(color: Colors.white)))
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