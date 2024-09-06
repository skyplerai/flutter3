
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsAndConditionsCheckbox extends StatefulWidget {
  final bool isChecked;
  final ValueChanged<bool>? onChanged;

  TermsAndConditionsCheckbox({
    Key? key,
    this.isChecked = false,
    this.onChanged,
  }) : super(key: key);

  @override
  _TermsAndConditionsCheckboxState createState() => _TermsAndConditionsCheckboxState();
}

class _TermsAndConditionsCheckboxState extends State<TermsAndConditionsCheckbox> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.isChecked;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Checkbox(
          value: _isChecked,
          onChanged: (bool? value) {
            setState(() {
              _isChecked = value ?? false;
            });
            widget.onChanged?.call(_isChecked);
          },
          activeColor: Colors.orange,
          checkColor: Colors.white,
          side: BorderSide(color: Colors.white, width: 2),
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "I agree to the ",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                TextSpan(
                  text: "Terms and Conditions",
                  style: TextStyle(color: Colors.blue, fontSize: 16, decoration: TextDecoration.underline),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      const url = 'https://github.com/skyplerai';
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}