import 'package:flutter/material.dart';

import 'dialpad_ios.dart';
import 'dialpad_metro.dart';
import 'dialpad_basic.dart';

class DialPadSelection extends StatelessWidget {
  const DialPadSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text("Flutter Dialpad", style: Theme.of(context).textTheme.headlineMedium),
            SizedBox(height: 4),
            Text("View some of the designs below, click on a style", style: Theme.of(context).textTheme.bodyMedium),
            Divider(),
            SizedBox(height: 24),

            /// iOS-Style
            TextButton.icon(
              icon: Icon(Icons.apple),
              label: Text("iOS-style"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => DialPadIos()));
              },
            ),
            SizedBox(height: 24),

            /// Metro-Style
            TextButton.icon(
              icon: Icon(Icons.window),
              label: Text("Metro-style"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => DialPadMetro()));
              },
            ),
            SizedBox(height: 24),

            /// Plain-Style
            TextButton(
              child: Text("Basic-style"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => DialPadBasic()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
