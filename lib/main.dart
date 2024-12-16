import 'package:flutter/material.dart';
import 'package:wes_report/screens/loading_screen.dart';

void main() {
  runApp(const WesReport());
}

class WesReport extends StatelessWidget {
  const WesReport({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: LoadingScreen(),
    );
  }
}
