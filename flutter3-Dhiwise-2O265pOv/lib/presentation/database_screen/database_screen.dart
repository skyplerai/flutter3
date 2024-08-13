//lib/presentation/database_screen.dart
// lib/presentation/database_screen.dart
import 'dart:async';

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
  final ApiService apiService = ApiService();
  late DateTime selectedDate;
  List<Result> detectedFaces = [];

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    fetchDetectedFaces();
  }

  List results = [
    {
      "name": "dhanush",
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
  String dateformat(created_at) {
    DateTime dateTime = DateTime.parse(created_at);

    // Format the time portion
    return DateFormat('HH:mm')
        .format(dateTime); // Use 'hh:mm a' for 12-hour format with AM/PM
  }

  var date = DateTime.parse('2024-08-10T11:45:00Z');

// print(dateTimeWithTimeZone);

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
    } finally {
      setState(() {});
    }
  }

  void _renameFace(Result face) async {
    final TextEditingController controller =
        TextEditingController(text: face.name);
    final newName = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Rename Face"),
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
                  // : ListTile(
                  //     contentPadding:
                  //         EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  //     leading: CircleAvatar(
                  //       backgroundImage: NetworkImage(face.embedding ?? ''),
                  //       radius: 30,
                  //     ),
                  //     title: Text(
                  //       face.name ?? "Unknown ${face.id}",
                  //       style: TextStyle(color: Colors.white),
                  //     ),
                  //     subtitle: Text(
                  //       face.createdAt ?? "",
                  //       style: TextStyle(color: Colors.grey),
                  //     ),
                  //     trailing: IconButton(
                  //       icon: Icon(Icons.edit, color: Colors.white),
                  //  onPressed: () => _renameFace(face),
                  //     ),
                  //     tileColor: face.name != null
                  //         ? Colors.grey[850]
                  //         : Colors.red[900],
                  //   );
                },
              ),
            ),
    );
  }

  Widget _detectFace() {
    String text = textController.text;
    return Expanded(
        child: ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
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
                              results[index]["name"],
                              // face.name ?? "Unknown ${face.id}",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            GestureDetector(
                              onTap: (() {
                                textController.text = results[index]["name"];
                                showDialog(
                                    barrierColor: Colors.black,
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                          title: const Text('Add a new name'),
                                          content: TextField(
                                            onTap: () {},
                                            controller: textController,
                                            autofocus: true,
                                            decoration: const InputDecoration(
                                                hintText: "Enter the name"),
                                          ),
                                          actions: [
                                            TextButton(
                                              child: Text('Cancel'),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                            TextButton(
                                              child: Text('Add'),
                                              onPressed: () {
                                                Navigator.pop(
                                                    context,
                                                    results[index]["name"] =
                                                        textController.text);

                                                setState(() {});
                                              },
                                            ),
                                          ]);
                                    });
                                // _renameFace(face);
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
                              results[index]["isKnown"] = true;

                              setState(() {});
                              print("false");
                            }),
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: results[index]["isKnown"] == false
                                      ? const Color.fromARGB(255, 94, 93, 93)
                                      : Colors.orange,
                                  // border: Border(
                                  //   // left: BorderSide(
                                  //   //   color: Colors.green,
                                  //   //   width: 3,
                                  //   ),
                                  // ),
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
                              results[index]["isKnown"] = false;
                              setState(() {});
                            }),
                            child: Container(
                                margin: EdgeInsets.only(right: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: results[index]["isKnown"] == false
                                      ? Colors.orange
                                      : const Color.fromARGB(255, 94, 93, 93),
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
                        itemCount: results[index]['result'].length,
                        itemBuilder: (BuildContext context, int index2) {
                          return Column(
                            children: [
                              SizedBox(
                                width: 4,
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 13),
                                child: CircleAvatar(
                                  radius: 34,
                                  child: Image(
                                      color: Colors.blue,
                                      image: NetworkImage(results[index]
                                          ['result'][index2]['embedding'])),
                                ),
                              ),
                              Container(
                                child: Text(dateformat(results[index]['result']
                                    [index2]['created_at'])),
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
