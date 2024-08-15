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
  runApp(const MyLightApp());
}

class MyLightApp extends StatelessWidget {
  const MyLightApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Rain',
      home: LightPage(
        title: 'Light',
      ),
    );
  }
}

class LightPage extends StatefulWidget {
  const LightPage({
    super.key,
    required this.title,
  });
  final String title;

  @override
  State<LightPage> createState() => _LightPageState();
}

class _LightPageState extends State<LightPage> {
  late List<LDRSensor> chartData = []; // Initialize chartData here

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
          .map((doc) => LDRSensor(
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
          title: const Text('Light'),
          titleTextStyle: const TextStyle(fontSize: 30, color: Colors.black),
        ),
        body: SfCartesianChart(
          tooltipBehavior: TooltipBehavior(enable: true),
          primaryXAxis: const CategoryAxis(),
          series: <LineSeries<LDRSensor, String>>[
            LineSeries<LDRSensor, String>(
              dataSource: chartData,
              xValueMapper: (LDRSensor data, _) => data.x!,
              yValueMapper: (LDRSensor data, _) => data.y!,
            )
          ],
        ),
      ),
    );
  }

  int time = 19;
  void updateDataSource(Timer timer) {
    setState(() {
      chartData.add(LDRSensor(
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

class LDRSensor {
  final String? x;
  final int? y;

  LDRSensor({required this.x, required this.y});
}
