import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

TextField buildPinTextField(TextEditingController pinController) {
  return TextField(
    controller: pinController,
    maxLength: 4,
    keyboardType: TextInputType.number,
    textAlign: TextAlign.center,
    style: const TextStyle(
      fontSize: 24,
      letterSpacing: 16,
      fontWeight: FontWeight.bold,
    ),
    decoration: InputDecoration(
      hintText: '••••',
      hintStyle: TextStyle(
        fontSize: 24,
        letterSpacing: 16,
        color: Colors.grey.shade400,
      ),
      counterText: '',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: Colors.blueAccent, width: 2.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: Colors.blue, width: 2.5),
      ),
    ),
    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
  );
}
