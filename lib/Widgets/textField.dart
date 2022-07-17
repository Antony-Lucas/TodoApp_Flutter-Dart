import 'package:flutter/material.dart';

Widget buildTextField({String? hint, required TextEditingController controller}){
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      fillColor: Colors.black12,
      labelText: hint,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black12),
        borderRadius: BorderRadius.circular(10.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black12),
        borderRadius: BorderRadius.circular(10.0),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
    ),
  );
}