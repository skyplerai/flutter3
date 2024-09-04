import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:upi_india/upi_india.dart';

class UpiTransactionPage extends StatefulWidget {
  @override
  _UpiTransactionPageState createState() => _UpiTransactionPageState();
}

class _UpiTransactionPageState extends State<UpiTransactionPage> {
  late UpiIndia _upiIndia;
  UpiResponse? _upiResponse;
  UpiApp? _selectedUpiApp;

  @override
  void initState() {
    super.initState();
    _upiIndia = UpiIndia();
  }

  Future<void> _showAppSelectionDialog() async {
    final Map<UpiApp, String> appNames = {
      UpiApp.googlePay: 'Google Pay',
      UpiApp.phonePe: 'PhonePe',
      UpiApp.bhim: 'BHIM',
      UpiApp.amazonPay: 'Amazon Pay',
      // Add other supported apps and their names as needed
    };

    final selectedUpiApp = await showDialog<UpiApp>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.white, // Customize dialog background color
          child: Container(
            height: 350, // Set the height of the dialog
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Select UPI App',
                  style: TextStyle(
                    color: Colors.orange, // Title text color
                    fontSize: 22, // Title font size
                    fontWeight: FontWeight.bold, // Title font weight
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ListView(
                    children: appNames.entries.map((entry) {
                      return ListTile(
                        leading: Image(
                            image: AssetImage('assets/icons/${entry.key.name}.png'),
                          width: 30.0, // Custom width from the map
                        ),
                        title: Text(
                          '${entry.value}       >',
                          style: TextStyle(color: Colors.black,
                          fontWeight: FontWeight.w800), // Text color
                        ),
                        onTap: () {
                          Navigator.of(context).pop(entry.key); // Return the selected UPI app
                        },
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );


    if (selectedUpiApp != null) {
      setState(() {
        _selectedUpiApp = selectedUpiApp;
      });
    }
  }

  Future<void> _initiateTransaction() async {
    if (_selectedUpiApp == null) {
      await _showAppSelectionDialog();
    }

    if (_selectedUpiApp != null) {
      _upiResponse = await _upiIndia.startTransaction(
        app: _selectedUpiApp!,
        receiverUpiId: 'your-upi-id@bank',
        receiverName: 'The Third Eye',
        transactionRefId: 'TXNID12345',
        transactionNote: 'Payment for Full access of the Third Eye App',
        amount: 399.0,
      );

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'UPI Payment',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.orange,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Stack(
        children: [
          _buildBackgroundShapes(),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildPaymentDetails(),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: _initiateTransaction,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 60, vertical: 25),
                    ),
                    child: Text(
                      'Pay ₹399 via UPI',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  if (_upiResponse != null)
                    Text(
                      'Transaction Status: ${_getTransactionStatus(_upiResponse)}',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundShapes() {
    return Stack(
      children: [
        Positioned(
          top: -100,
          left: -100,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          bottom: -100,
          right: -100,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentDetails() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(
              'assets/icons/Rupee_icon.png',  // Path to your PNG asset
              width: 50.0,       // This only works with monochrome PNGs (i.e., white PNGs)
            ),
            SizedBox(height: 20),
            Text(
              'Receiver: The Third Eye',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'UPI ID: your-upi-id@bank',
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),
            SizedBox(height: 10),
            Text(
              'Amount: ₹399.00',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            SizedBox(height: 10),
            Text(
              'Note: Payment for Third Eye full Access',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  String _getTransactionStatus(UpiResponse? response) {
    if (response == null) {
      return 'Transaction Failed';
    }

    switch (response.status) {
      case UpiPaymentStatus.SUCCESS:
        return 'Transaction Successful';
      case UpiPaymentStatus.SUBMITTED:
        return 'Transaction Submitted';
      case UpiPaymentStatus.FAILURE:
        return 'Transaction Failed';
      default:
        return 'Received an Unknown status';
    }
  }
}
