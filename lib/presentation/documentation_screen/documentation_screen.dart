import 'package:flutter/material.dart';
import '../../core/app_export.dart';

class DocumentationScreen extends StatelessWidget {
  const DocumentationScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: 396.h,
          padding: EdgeInsets.only(top: 76.v),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 5.v),
              Text(
                "Doc",
                style: theme.textTheme.headlineMedium,
              )
            ],
          ),
        ),
      ),
    );
  }
}
