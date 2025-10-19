import 'package:flutter/material.dart';
import 'package:weather_app/app.dart';

void main() {
    await dotenv.load(fileName: ".env");

  runApp(const MyApp());
}
