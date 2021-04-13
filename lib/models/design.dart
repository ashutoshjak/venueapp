import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  fillColor: Colors.white12,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 4.0),
    borderRadius: const BorderRadius.all(
      const Radius.circular(100.0),
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey, width: 4.0),
    borderRadius: const BorderRadius.all(
      const Radius.circular(100.0),
    ),
  ),
);
