import 'dart:io';

import 'package:auto_plant_care_system_v2/pages/data_select.dart';
import 'package:auto_plant_care_system_v2/pages/home.dart';
import 'package:auto_plant_care_system_v2/pages/light.dart';
import 'package:auto_plant_care_system_v2/pages/rain.dart';
import 'package:auto_plant_care_system_v2/pages/soil_moist.dart';
import 'package:auto_plant_care_system_v2/pages/temperature.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: "AIzaSyCyXf81Cof9ID4-JySrdldUlWfCsgYvy30",
              appId: "auto-plant-care-system",
              messagingSenderId: "510327131538",
              projectId: "auto-plant-care-system"),
        )
      : await Firebase.initializeApp();

  runApp(MaterialApp(
    initialRoute: '/home',
    routes: {
      '/home': (context) => const Home(),
      '/data': (context) => const DataSelect(),
      '/rain': (context) => const LiveRainChart(
            title: 'Rain',
         ),
      '/soil': (context) => const SoilPage(
            title: 'Soil Moisture',
          ),
      '/temperature': (context) => const TemperaturePage(
            title: 'Temperature',
          ),
      '/light': (context) => const LightPage(
            title: 'Light',
          ),
    },
  ));
}
