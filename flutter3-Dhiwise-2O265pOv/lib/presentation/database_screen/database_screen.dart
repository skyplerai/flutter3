import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/app_export.dart';
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
  CameraDetectedUsers? detectedUsers;
  bool showKnown = true; // State variable to toggle between known and unknown faces

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    fetchDetectedFaces();
  }

  Future<void> fetchDetectedFaces() async {
    try {
      final users = await apiService.getDetectedFaces(
        date: selectedDate.day.toString().padLeft(2, '0'),
        month: selectedDate.month.toString().padLeft(2, '0'),
        year: selectedDate.year.toString(),
      );
      setState(() {
        detectedUsers = users;
      });
    } catch (e) {
      print('Error fetching faces: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching faces')),
      );
    }
  }

  void _renameFace(DetectedFace face) async {
    final TextEditingController controller = TextEditingController(text: face.faceId);
    final newName = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text("Rename Face", style: TextStyle(color: Colors.orange)),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: "Enter new name",
            hintStyle: TextStyle(color: Colors.white54),
            fillColor: Colors.grey[800],
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.orange),
            ),
          ),
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Cancel", style: TextStyle(color: Colors.orange)),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(controller.text),
            child: Text("Save", style: TextStyle(color: Colors.orange)),
          ),
        ],
      ),
    );

    if (newName != null && newName.isNotEmpty) {
      try {
        final success = await apiService.renameFace(
          oldFaceId: face.faceId!,
          newFaceId: newName,
        );
        if (success) {
          fetchDetectedFaces();
        } else {
          _showSnackBar(context, 'Failed to rename face.');
        }
      } catch (e) {
        _showSnackBar(context, 'Error renaming face: $e');
      }
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.black,
        duration: Duration(seconds: 3),
      ),
    );
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
            _buildToggleButtons(),
            SizedBox(height: 16),
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: Colors.orange,
              onPrimary: Colors.black,
              surface: Colors.grey[900]!,
              onSurface: Colors.orange,
            ),
            dialogBackgroundColor: Colors.grey[800],
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        fetchDetectedFaces();
      });
    }
  }

  Widget _buildToggleButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ChoiceChip(
            label: Text("Known", style: TextStyle(color: Colors.white)),
            selected: showKnown,
            onSelected: (selected) {
              setState(() {
                showKnown = true;
              });
            },
            selectedColor: Colors.orange,
            backgroundColor: Colors.grey[800],
            labelStyle: TextStyle(color: Colors.white),
          ),
          SizedBox(width: 16),
          ChoiceChip(
            label: Text("Unknown", style: TextStyle(color: Colors.white)),
            selected: !showKnown,
            onSelected: (selected) {
              setState(() {
                showKnown = false;
              });
            },
            selectedColor: Colors.orange,
            backgroundColor: Colors.grey[800],
            labelStyle: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildDetectedFacesList() {
    final faces = detectedUsers?.results?.where((face) =>
    (showKnown && face.isKnown == true) || (!showKnown && face.isKnown == false)).toList();

    return Expanded(
      child: faces == null || faces.isEmpty
          ? Center(child: Text("No detected faces", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)))
          : ListView.builder(
        itemCount: faces.length,
        itemBuilder: (context, index) {
          final face = faces[index];
          return Card(
            color: face.isKnown == true ? Colors.grey[850] : Colors.red[900],
            child: ExpansionTile(
              leading: CircleAvatar(
                backgroundImage: MemoryImage(base64Decode(face.faceVisits?.first.image ?? '')),
                radius: 30,
              ),
              title: Text(
                face.faceId ?? "Unknown",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "Total visits: ${face.totalVisits ?? 0}",
                style: TextStyle(color: Colors.grey),
              ),
              trailing: IconButton(
                icon: Icon(Icons.edit, color: Colors.white),
                onPressed: () => _renameFace(face),
              ),
              children: [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Quality Score: ${face.qualityScore?.toStringAsFixed(2) ?? "N/A"}", style: TextStyle(color: Colors.white)),
                      Text("Is Known: ${face.isKnown == true ? "Yes" : "No"}", style: TextStyle(color: Colors.white)),
                      SizedBox(height: 16),
                      Text("Face Visits:", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      _buildFaceVisitsGrid(face.faceVisits),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFaceVisitsGrid(List<FaceVisit>? faceVisits) {
    if (faceVisits == null || faceVisits.isEmpty) {
      return Text("No visits recorded", style: TextStyle(color: Colors.grey));
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.75,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: faceVisits.length,
      itemBuilder: (context, index) {
        final visit = faceVisits[index];
        return Column(
          children: [
            Expanded(
              child: Image.memory(
                base64Decode(visit.image ?? ''),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 4),
            Text(
              visit.detectedTime ?? "Unknown",
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ],
        );
      },
    );
  }
}
