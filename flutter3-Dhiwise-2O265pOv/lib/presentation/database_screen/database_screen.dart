//lib/presentation/database_screen.dart
// lib/presentation/database_screen.dart
import 'dart:async';
// import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
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
//   final ApiService apiService = ApiService();
//   late DateTime selectedDate;
//   List<Result> detectedFaces = [];

//   @override
//   void initState() {
//     super.initState();
//     selectedDate = DateTime.now();
//     fetchDetectedFaces();
//   }

  List results = [
    {
      "name": "dhanush",
      "result": [
        {
          "id": 105,
          "name": "First Result",
          "embedding": "embedding_data_1",
          "created_at": "2024-08-10T09:00:00Z"
        },
        {
          "id": 101,
          "name": "First Result",
          "embedding": "embedding_data_1",
          "created_at": "2024-08-10T09:00:00Z"
        },
        {
          "id": 102,
          "name": "Second Result",
          "embedding": "embedding_data_2",
          "created_at": "2024-08-10T10:30:00Z"
        },
        {
          "id": 103,
          "name": "Third Result",
          "embedding": "embedding_data_3",
          "created_at": "2024-08-10T11:45:00Z"
        },
        {
          "id": 104,
          "name": "Fourth Result",
          "embedding": "embedding_data_4",
          "created_at": "2024-08-10T11:45:00Z"
        }
      ],
      "isKnown": false,
      "id": 0,
    },
    {
      "name": "dk",
      "result": [
        {
          "id": 101,
          "name": "First Result",
          "embedding": "embedding_data_1",
          "created_at": "2024-08-10T09:00:00Z"
        },
        {
          "id": 102,
          "name": "Second Result",
          "embedding": "embedding_data_2",
          "created_at": "2024-08-10T10:30:00Z"
        },
        {
          "id": 103,
          "name": "Third Result",
          "embedding": "embedding_data_3",
          "created_at": "2024-08-10T11:45:00Z"
        },
        {
          "id": 104,
          "name": "Fourth Result",
          "embedding": "embedding_data_4",
          "created_at": "2024-08-10T11:45:00Z"
        }
      ],
      "isKnown": false,
      "id": 1,
    }
  ];

  final ApiService apiService = ApiService();
  late DateTime selectedDate;
  List<DetectedFace> detectedFaces = []; // Changed from Result to DetectedFace

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
    final TextEditingController controller =
    TextEditingController(text: face.faceId); // Changed from name to faceId
    final newName = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Rename Face"),
        backgroundColor: Colors.black87,
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: "Enter new name"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(controller.text),
            child: Text("Save"),
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

  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String text = textController.text;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            SizedBox(height: 39),
            _buildRowDatabase(context),
            SizedBox(height: 22),
            _buildDateSelection(),
            SizedBox(height: 24),

            _detectFace()
            // _buildDetectedFacesList()
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
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Colors.white),
          ),
          IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, AppRoutes.notificationsScreen),
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
      items:
      List.generate(31, (index) => (index + 1).toString().padLeft(2, '0')),
      onChanged: (value) {
        setState(() {
          selectedDate =
              DateTime(selectedDate.year, selectedDate.month, int.parse(value));
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
          selectedDate = DateTime(
              selectedDate.year,
              DateFormat.MMMM().dateSymbols.MONTHS.indexOf(value) + 1,
              selectedDate.day);
          fetchDetectedFaces();
        });
      },
    );
  }

  Widget _buildYearDropdown() {
    return CustomDropDown(
      width: 95,
      hintText: selectedDate.year.toString(),
      items: List.generate(
          10, (index) => (DateTime.now().year - index).toString()),
      onChanged: (value) {
        setState(() {
          selectedDate =
              DateTime(int.parse(value), selectedDate.month, selectedDate.day);
          fetchDetectedFaces();
        });
      },
    );
  }

  Widget _buildDetectedFacesList() {
    return Expanded(
      // Container(
      // height: 300,
      // width: 200,
      // color: Colors.red,
      child: detectedFaces.isEmpty
          ? Center(
          child: Text("No detected faces",
              style: TextStyle(color: Colors.white)))
          : Container(
        // color: Colors.white,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: detectedFaces.length,
          itemBuilder: (context, index) {
            final face = detectedFaces[index];
            return Container(
              child: Column(children: [
                Row(
                  children: [
                    Text(
                      results[index]['name'],
                      // face.name ?? "Unknown ${face.id}",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
              ]),
            );
          },
        ),
      ),
    );
  }

  Widget _detectFace() {
    return Expanded(
        child: detectedFaces.isEmpty
            ? Center(
            child: Text("No detected faces",
                style: TextStyle(color: Colors.white)))
            : ListView.builder(
            itemCount: detectedFaces.length,
            itemBuilder: (context, index) {
              final face = detectedFaces[index];
              // final face = detectedFaces[index];

              return Container(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 25),
                            child: Row(
                              children: [
                                Text(
                                  // "text",
                                  face.faceId ?? "Unknown",
                                  // face.name ?? "Unknown ${face.id}",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                GestureDetector(
                                  onTap: (() {
                                    _renameFace(face);
                                  }),
                                  child: Image(
                                      width: 20,
                                      image: AssetImage(
                                          "assets/images/img_image_20x20.png")),
                                )
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: (() {
                                  // results[index]["isKnown"] = true;

                                  setState(() {});
                                  print("false");
                                }),
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: results[index]["isKnown"] == false
                                          ? const Color.fromARGB(
                                          255, 94, 93, 93)
                                          : Colors.orange,
                                      border: Border(
                                        // // RER\left: BorderSide(
                                        // //   color: Colors.green,
                                        // //   width: 3,
                                        // ),
                                      ),
                                    ),
                                    width: 60,
                                    height: 20,
                                    child: Center(child: Text("known"))),
                              ),
                              GestureDetector(
                                onTap: (() {}),
                                child: Image(
                                    width: 15,
                                    image: AssetImage(
                                        "assets/images/img_image_29x23.png")),
                              ),
                              GestureDetector(
                                onTap: (() {
                                  print("false");
                                  // results[index]["isKnown"] = false;
                                  setState(() {});
                                }),
                                child: Container(
                                    margin: EdgeInsets.only(right: 20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: results[index]["isKnown"] == false
                                          ? Colors.orange
                                          : const Color.fromARGB(
                                          255, 94, 93, 93),
                                      // border: Border(
                                      //   // left: BorderSide(
                                      //   //   color: Colors.green,
                                      //   //   width: 3,
                                      //   ),
                                      // ),
                                    ),
                                    width: 60,
                                    height: 20,
                                    child: Center(
                                        child: Text("unknown",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)))),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 25, right: 20),
                          width: double.infinity,
                          height: 100,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: detectedFaces.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: [
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(right: 13),
                                      child: CircleAvatar(
                                        radius: 34,
                                        backgroundImage:
                                        NetworkImage(face.imageUrl!),
                                        //    child: Image(
                                        //width:30,
                                        //color: Colors.blue,
                                        //image:
                                        // NetworkImage(face.imageUrl!),
                                      )),
                                  //  ),
                                  Container(
                                    child: Text(
                                      face.lastSeen ?? "",
                                    ),
                                  )
                                ],
                              );
                            },
                          ))
                    ],
                  ));
            }));
  }
}