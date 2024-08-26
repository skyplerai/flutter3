import 'package:flutter/material.dart';

class DocumentationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('How to Connect Your CCTV Camera'),
        backgroundColor: Colors.orange,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'We’re excited to help you get your CCTV camera connected to the ThirdEye app. Just follow these simple steps, and you’ll be up and running in no time!',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 30),
            Text(
              'Step 1: Open the App',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Once you’ve logged in, you’ll land on the home screen. To add your CCTV camera, tap the "Tap to Connect" button. It’s right there on the main page!',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Container(
              height: 800,  // Adjusted for mobile screenshot
              child: Center(
                child: Image.asset(
                  'assets/screen_shots/screen_shot_1.png',  // Replace with your actual image asset path
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 30),
            Text(
              'Step 2: Choose Your Camera Type',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'After tapping "Tap to Connect," you’ll see a pop-up with two options: "Static" and "DDNS." Simply choose the option that matches your camera setup.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Container(
              height: 800,  // Adjusted for mobile screenshot
              child: Center(
                child: Image.asset(
                  'assets/screen_shots/screen_shot_2.png',  // Replace with your actual image asset path
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 30),
            Text(
              'Step 3: Enter Camera Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Next, you’ll be asked to enter some details about your camera: the IP Network, Username, and Password. Make sure everything is correct, then press "Connect." Voilà! You should now see the live stream from your CCTV camera.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Container(
              height: 800,  // Adjusted for mobile screenshot
              child: Center(
                child: Image.asset(
                  'assets/screen_shots/screen_shot_3.png',  // Replace with your actual image asset path
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 30),
            Text(
              'And that’s it!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'You’ve successfully connected your CCTV camera to the ThirdEye app. Now, sit back and keep an eye on what matters most, right from your phone.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
