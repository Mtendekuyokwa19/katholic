import 'package:flutter/material.dart';
import 'package:forui/widgets/line_calendar.dart';
import 'package:njirayamtanda/feature_home/widgets/date_wid.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: Column(children: [DateWid()])),
    );
  }
}
