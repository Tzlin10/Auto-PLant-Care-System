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
  runApp(const MyTempApp());
}

class MyTempApp extends StatelessWidget {
  const MyTempApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Rain',
      home: TemperaturePage(
        title: 'Light',
      ),
    );
  }
}

class TemperaturePage extends StatefulWidget {
  const TemperaturePage({
    super.key,
    required this.title,
  });
  final String title;

  @override
  State<TemperaturePage> createState() => _TemperaturePageState();
}

class _TemperaturePageState extends State<TemperaturePage> {
  late List<DH11Sensor> chartData = []; // Initialize chartData here

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
          .map((doc) => DH11Sensor(
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
          title: const Text('Temperature'),
          titleTextStyle: const TextStyle(fontSize: 30, color: Colors.black),
        ),
        body: SfCartesianChart(
          tooltipBehavior: TooltipBehavior(enable: true),
          primaryXAxis: const CategoryAxis(),
          series: <LineSeries<DH11Sensor, String>>[
            LineSeries<DH11Sensor, String>(
              dataSource: chartData,
              xValueMapper: (DH11Sensor data, _) => data.x!,
              yValueMapper: (DH11Sensor data, _) => data.y!,
            )
          ],
        ),
      ),
    );
  }

  int time = 19;
  void updateDataSource(Timer timer) {
    setState(() {
      chartData.add(DH11Sensor(
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

class DH11Sensor {
  final String? x;
  final int? y;

  DH11Sensor({required this.x, required this.y});
}
