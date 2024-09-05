import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../Services/shared_services.dart';

class UserProfileEditPage extends StatefulWidget {
  @override
  _UserProfileEditPageState createState() => _UserProfileEditPageState();
}

class _UserProfileEditPageState extends State<UserProfileEditPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  File? _profileImage;
  double _completionPercentage = 0.0;
  String _countryCode = '+91'; // Default country code
  String _flag = '🇮🇳'; // Default flag emoji
  String? _phoneNumber;

  final Map<String, String> _countryCodeMap = {
    'IN': '+91',
    'US': '+1',
    'GB': '+44',
    'CA': '+1',
    'AU': '+61',
    'DE': '+49',
    'FR': '+33',
    // Add more country codes as needed
  };

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _updateCompletionPercentage();
  }

  Future<void> _loadUserData() async {
    final user = await UserSharedServices.loginDetails();
    if (user != null && user.userInfo != null) {
      setState(() {
        _usernameController.text = user.userInfo!.username ?? '';
        _updateCompletionPercentage();
      });
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
        _updateCompletionPercentage();
      });
    }
  }

  void _updateCompletionPercentage() {
    int filledFields = 0;
    if (_usernameController.text.isNotEmpty) filledFields++;
    if (_locationController.text.isNotEmpty) filledFields++;
    if (_profileImage != null) filledFields++;

    setState(() {
      _completionPercentage = (filledFields / 3) * 100;
    });
  }

  void _saveProfileData() async {
    // Implement the logic to save the updated profile details
    print("Saving user data...");
    print("Phone: $_phoneNumber");

    // Show the "Details Saved" message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Details Saved'),
        duration: Duration(seconds: 2),
      ),
    );

    // Navigate to the settings page
    Navigator.pop(context); // Adjust the route name if necessary

    // Wait for 2 seconds before navigating
    await Future.delayed(Duration(seconds: 2));


  }

  void _onCountryChanged(String? countryCode) {
    setState(() {
      _countryCode = _countryCodeMap[countryCode ?? 'IN'] ?? '+91'; // Default to '+91' if no country code is found
      _flag = _getFlagForCountryCode(countryCode);
    });
  }

  String _getFlagForCountryCode(String? countryCode) {
    switch (countryCode) {
      case 'IN':
        return '🇮🇳';
      case 'US':
        return '🇺🇸';
      case 'GB':
        return '🇬🇧';
      case 'CA':
        return '🇨🇦';
      case 'AU':
        return '🇦🇺';
      case 'DE':
        return '🇩🇪';
      case 'FR':
        return '🇫🇷';
      default:
        return '🌍';
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: _profileImage == null ? Colors.orange : Colors.transparent,
                  backgroundImage: _profileImage != null
                      ? FileImage(_profileImage!)
                      : null,
                  child: _profileImage == null
                      ? Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 30,
                  )
                      : null,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle: TextStyle(color: Colors.orange),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                ),
                onChanged: (value) => _updateCompletionPercentage(),
              ),
              SizedBox(height: 20),
              IntlPhoneField(
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  labelStyle: TextStyle(color: Colors.orange),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                ),
                initialCountryCode: 'IN',
                onChanged: (phone) {
                  setState(() {
                    _phoneNumber = phone.number;
                  });
                },
                onCountryChanged: (country) {
                  _onCountryChanged(country.code);
                },
              ),
              SizedBox(height: 20),
              CSCPicker(
                defaultCountry: CscCountry.India, // Default to India
                onCountryChanged: (countryCode) {
                  _onCountryChanged(countryCode);
                },
                onStateChanged: (state) {
                  _locationController.text = state ?? '';
                  _updateCompletionPercentage();
                },
                onCityChanged: (city) {
                  _locationController.text = city ?? '';
                  _updateCompletionPercentage();
                },
                showStates: true,
                showCities: true,
                dropdownDecoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                selectedItemStyle: TextStyle(color: Colors.orange, fontWeight: FontWeight.w700),
                disabledDropdownDecoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                ),
                dropdownItemStyle: TextStyle(color: Colors.orange), // Dropdown item text color
              ),
              SizedBox(height: 20),
              LinearProgressIndicator(
                value: _completionPercentage / 100,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              ),
              SizedBox(height: 10),
              Text(
                '${_completionPercentage.toInt()}% Complete',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveProfileData,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.orange, // Text color of the button
                  minimumSize: Size(150, 50), // Size of the button (width, height)
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Button border radius
                  ),
                ),
                child: Text(
                  'Save',
                  style: TextStyle(
                    fontSize: 18, // Text size
                    fontWeight: FontWeight.bold, // Text weight
                  ),
                ),
              )
              ,
            ],
          ),
        ),
      ),
    );
  }
}
