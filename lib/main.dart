import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:payments_card_animation/card_details_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Payments Card Animation',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: CardDetailsPage(),
    );
  }
}
