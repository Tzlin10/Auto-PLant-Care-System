import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:syncfusion_flutter_charts/charts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyCyXf81Cof9ID4-JySrdldUlWfCsgYvy30",
        appId: "auto-plant-care-system",
        messagingSenderId: "510327131538",
        projectId: "auto-plant-care-system"),
  );
  runApp(const MySoilApp());
}

class MySoilApp extends StatelessWidget {
  const MySoilApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Soil Moisture',
      home: SoilPage(
        title: 'Soil Moisture',
      ),
    );
  }
}

class SoilPage extends StatefulWidget {
  const SoilPage({
    super.key,
    required this.title,
  });
  final String title;

  @override
  State<SoilPage> createState() => _SoilPageState();
}

class _SoilPageState extends State<SoilPage> {
  late List<SoilMoistureSensor> chartData = []; // Initialize chartData here

  @override
  void initState() {
    super.initState();
    getDataFromFirestore(); // Fetch initial data
    Timer.periodic(
        const Duration(seconds: 1), updateDataSource); // Start periodic update
  }

  Future<void> getDataFromFirestore() async {
    var snapshots =
        await FirebaseFirestore.instance.collection('chartData').get();
    setState(() {
      chartData = snapshots.docs
          .map((doc) => SoilMoistureSensor(
                x: doc.data()['x'].toString(),
                y: doc.data()['y'],
              ))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Soil Moisture'),
          backgroundColor: Colors.white,
          titleTextStyle: const TextStyle(fontSize: 30, color: Colors.black),
        ),
        body: SfCartesianChart(
          tooltipBehavior: TooltipBehavior(enable: true),
          primaryXAxis: const CategoryAxis(),
          series: <LineSeries<SoilMoistureSensor, String>>[
            LineSeries<SoilMoistureSensor, String>(
              dataSource: chartData,
              xValueMapper: (SoilMoistureSensor data, _) => data.x!,
              yValueMapper: (SoilMoistureSensor data, _) => data.y!,
            )
          ],
        ),
      ),
    );
  }

  int time = 19;
  void updateDataSource(Timer timer) {
    setState(() {
      chartData.add(SoilMoistureSensor(
        x: time.toString(),
        y: (DateTime.now().millisecondsSinceEpoch % 100)
            .toInt(), // Simulated y value
      ));
      if (chartData.length > 10) {
        chartData.removeAt(0);
      }
    });
    time++;
  }
}

class SoilMoistureSensor {
  final String? x;
  final int? y;

  SoilMoistureSensor({required this.x, required this.y});
}
