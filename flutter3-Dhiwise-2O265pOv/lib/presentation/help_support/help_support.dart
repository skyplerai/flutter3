import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpAndSupportScreen extends StatelessWidget {
  const HelpAndSupportScreen({Key? key}) : super(key: key);

  // Function to launch email
  void _launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'support@example.com', // Replace with your support email
      query: 'subject=Help%20and%20Support', // Optional subject
    );
    if (await canLaunch(emailUri.toString())) {
      await launch(emailUri.toString());
    } else {
      throw 'Could not launch email';
    }
  }

  // Function to launch WhatsApp
  void _launchWhatsApp() async {
    final Uri whatsappUri = Uri.parse("https://wa.me/1234567890?text=Hello"); // Replace with your WhatsApp number
    if (await canLaunch(whatsappUri.toString())) {
      await launch(whatsappUri.toString());
    } else {
      throw 'Could not launch WhatsApp';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Help and Support", style: TextStyle(color: Colors.white))),
        backgroundColor: Color.fromRGBO(0, 0, 0, 0.01),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              onPressed: _launchEmail,
              icon: Icon(Icons.email, color: Colors.white), // Icon color
              label: Text(
                'Email Support',
                style: TextStyle(color: Colors.white), // Text color
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Button color
                padding: EdgeInsets.symmetric(vertical: 25.0),
                textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: _launchWhatsApp,
              icon: Icon(Icons.chat, color: Colors.white), // Icon color
              label: Text(
                'WhatsApp Support',
                style: TextStyle(color: Colors.white), // Text color
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Button color
                padding: EdgeInsets.symmetric(vertical: 25.0),
                textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
