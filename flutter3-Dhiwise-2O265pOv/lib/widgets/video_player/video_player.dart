//video_player.dart
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sriram_s_application3/constants/stream_urls.dart';
import 'package:sriram_s_application3/core/app_export.dart';
import 'package:sriram_s_application3/widgets/custom_icon_button.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketVideoPlayer extends StatefulWidget {
  final String webSocketUrl;
  final String authToken; // Add auth token parameter

  WebSocketVideoPlayer({required this.webSocketUrl, required this.authToken});

  @override
  _WebSocketVideoPlayerState createState() => _WebSocketVideoPlayerState();
}

class _WebSocketVideoPlayerState extends State<WebSocketVideoPlayer> {
  late WebSocketChannel _channel;
  Image? _currentFrame;
  List<Map<String, dynamic>> _detectedFaces = [];
  bool isError = false;
  String errorMessage = '';
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeWebSocket();
  }

  final streamUrlController = Get.put(StreamUrlController());
  void _initializeWebSocket() {
    final wsUrl =
        '${widget.webSocketUrl}?token=${widget.authToken}'; // Include token in the URL
    print('Initializing WebSocket with URL: $wsUrl');
    try {
      _channel = WebSocketChannel.connect(Uri.parse(wsUrl));
      _channel.stream.listen(
        (message) {
          final data = jsonDecode(message);
          setState(() {
            if (data['frame'] != null) {
              _currentFrame = Image.memory(
                base64Decode(data['frame']),
                gaplessPlayback: true,
              );
            }
            if (data['detected_faces'] != null) {
              _detectedFaces =
                  List<Map<String, dynamic>>.from(data['detected_faces']);
            }
          });
        },
        onError: (error) {
          print('WebSocket error: $error');
          setState(() {
            isError = true;
            errorMessage = error.toString();
          });
        },
        onDone: () {
          print('WebSocket connection closed.');
          setState(() {
            isError = true;
            errorMessage = 'WebSocket connection closed.';
          });
        },
      );
    } catch (e) {
      print('Error initializing WebSocket: $e');
      setState(() {
        isError = true;
        errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: isError
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // _buildColumnOne(
                //   context,
                //   connectCCTVText: "Connect CCTV",
                //   camerasCounterText:
                //       "${streamUrlController.streamUrls.length} cameras",
                //   tapToConnectText: "Tap to connect",
                // ),
                Text('Error: $errorMessage'),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isError = false;
                      errorMessage = '';
                      _initializeWebSocket();
                    });
                  },
                  child: Text('Retry'),
                ),
              ],
            )
          : _currentFrame != null
              ? Column(
                  children: [
                    _buildColumnOne(
                      context,
                      connectCCTVText: "Connect CCTV",
                      camerasCounterText:
                          "${streamUrlController.streamUrls.length} cameras",
                      tapToConnectText: "Tap to connect",
                    ),
                    _currentFrame!,
                    ..._detectedFaces.map((face) {
                      return Positioned(
                        left: face['coordinates']['left'].toDouble(),
                        top: face['coordinates']['top'].toDouble(),
                        child: Container(
                          width: (face['coordinates']['right'] -
                                  face['coordinates']['left'])
                              .toDouble(),
                          height: (face['coordinates']['bottom'] -
                                  face['coordinates']['top'])
                              .toDouble(),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.red, width: 2),
                          ),
                          child: Text(face['name'],
                              style: TextStyle(color: Colors.red)),
                        ),
                      );
                    }).toList()
                  ],
                )
              : CircularProgressIndicator(),
    );
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }

  Widget _buildColumnOne(
    BuildContext context, {
    required String connectCCTVText,
    required String camerasCounterText,
    required String tapToConnectText,
  }) {
    textController.text = connectCCTVText;
    return StatefulBuilder(builder: (context, StateSetter setState) {
      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: 13.h,
          vertical: 14.v,
        ),
        decoration: AppDecoration.fillBlueGray.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder18,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      connectCCTVText,
                      style: theme.textTheme.titleSmall!.copyWith(
                        color: appTheme.whiteA700,
                      ),
                    ),
                    Row(
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgImage16x13,
                          height: 10.v,
                          width: 10.h,
                          margin: EdgeInsets.symmetric(vertical: 1.v),
                        ),
                        Text(
                          camerasCounterText,
                          style: theme.textTheme.bodySmall!.copyWith(
                            color: appTheme.whiteA700,
                          ),
                        )
                      ],
                    )
                  ],
                ),
                CustomImageView(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                              title: const Text('Add a new class'),
                              content: TextField(
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
                                    // ignore: unused_element
                                    Navigator.pop(context,
                                        connectCCTVText = textController.text);
                                    print("print>>>>>>>$connectCCTVText");
                                    setState(() {});
                                  },
                                ),
                              ]);
                        });
                  },
                  imagePath: ImageConstant.imgImage20x20,
                  height: 15.adaptSize,
                  width: 15.adaptSize,
                  margin: EdgeInsets.only(
                    left: 4.h,
                    top: 4.v,
                    bottom: 23.v,
                  ),
                )
              ],
            ),
          ],
        ),
      );
    });
  }
}
