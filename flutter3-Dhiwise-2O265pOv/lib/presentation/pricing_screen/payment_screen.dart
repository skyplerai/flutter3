import 'package:flutter/material.dart';
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
      UpiApp.paytm: 'Paytm',
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
          backgroundColor: Colors.orange,
          child: Container(
            height: 300, // Set the height of the dialog
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Select UPI App',
                    style: TextStyle(
                      color: Colors.white, // Title text color
                      fontSize: 20, // Title font size
                      fontWeight: FontWeight.w700, // Title font weight
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: ListView(
                      children: appNames.entries.map((entry) {
                        return ListTile(
                          title: Text(
                            entry.value, // Display the app name
                            style: TextStyle(color: Colors.white), // Text color
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
        receiverUpiId: 'your-upi-id@bank', // Replace with the actual receiver UPI ID
        receiverName: 'The Third Eye', // Replace with the receiver's name
        transactionRefId: 'TXNID12345', // Unique transaction ID
        transactionNote: 'Payment for Full access of the Third Eye App', // Note for the payment
        amount: 399.0, // The fixed amount to be paid
      );

      setState(() {});
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'UPI Payment',
          style: TextStyle(
            color: Colors.white, // Title text color
            fontSize: 24, // Title font size
            fontWeight: FontWeight.bold, // Title font weight
            fontFamily: 'Roboto', // Custom font family, ensure it's added in pubspec.yaml
          ),
        ),
        backgroundColor: Colors.orange,
        iconTheme: IconThemeData(
          color: Colors.white, // Back button color
        ),
      ),
      body: Stack(
        children: [
          _buildBackgroundShapes(),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min, // This keeps the column centered
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
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
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
            Icon(Icons.account_balance_wallet, size: 50, color: Colors.lightBlue),
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
}
