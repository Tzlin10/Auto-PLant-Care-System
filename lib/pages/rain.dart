import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Chart());
}

class Chart extends StatelessWidget {
  const Chart({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: "Rain",
        home: LiveRainChart(
          title: "Rain",
        ));
  }
}

class LiveRainChart extends StatefulWidget {
  const LiveRainChart({super.key, required String title});

  @override
  _LiveRainChartState createState() => _LiveRainChartState();
}

class _LiveRainChartState extends State<LiveRainChart> {
  List<_ChartData> chartData = <_ChartData>[];

  @override
  void initState() {
    getDataFromFireStore().then((results) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {});
      });
    });
    super.initState();
  }

  Future<void> getDataFromFireStore() async {
    var snapShotsValue =
        await FirebaseFirestore.instance.collection("chartData").get();
    List<_ChartData> list = snapShotsValue.docs
        .map((e) => _ChartData(
            x: e.data()['x'],
            // x: DateTime.fromMillisecondsSinceEpoch(
            //     e.data()['x'].millisecondsSinceEpoch),
            y: e.data()['y']))
        .toList();
    setState(() {
      chartData = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _showChart();
  }

  Widget _showChart() {
    return Scaffold(
      appBar: AppBar(),
      body: SfCartesianChart(
          tooltipBehavior: TooltipBehavior(enable: true),
          primaryXAxis: const CategoryAxis(),
          series: <LineSeries<_ChartData, String>>[
            LineSeries<_ChartData, String>(
                dataSource: chartData,
                xValueMapper: (_ChartData data, _) => data.x,
                yValueMapper: (_ChartData data, _) => data.y)
          ]),
    );
  }
}

class _ChartData {
  _ChartData({this.x, this.y});
  final String? x;
  final int? y;
}
