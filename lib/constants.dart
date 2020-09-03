import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFFE5F4F4);
const Color labelColor = Color(0xFF346969);
const Color buttonColor = Color(0xFFE5DCA5);
const Color cardColor = Color(0xFFEBD9D7);

const InputDecoration textFieldDecoration = const InputDecoration(
  contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
  border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
  counterText: '',
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: labelColor),  
  ),
  
);

const TextStyle labelStyle =
    TextStyle(color: labelColor, fontWeight: FontWeight.w500, fontSize: 16.0);
