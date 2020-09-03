import 'package:flutter/material.dart';
import 'package:payments_card_animation/card_details_page.dart';
import 'package:payments_card_animation/card_front_ui.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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