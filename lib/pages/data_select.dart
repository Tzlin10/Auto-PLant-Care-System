import 'package:flutter/material.dart';

class DataSelect extends StatefulWidget {
  const DataSelect({super.key});

  @override
  State<DataSelect> createState() => _DataSelectState();
}

class _DataSelectState extends State<DataSelect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 24, 123, 27),
        title: const Text('Choose the data you want to check'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          TextButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/rain');
            },
            icon: const Icon(Icons.data_array),
            label: const Text('Rain'),
          ),
          TextButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/soil');
            },
            icon: const Icon(Icons.data_array_outlined),
            label: const Text('Soil'),
          ),
          TextButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/temperature');
            },
            icon: const Icon(Icons.data_array_outlined),
            label: const Text('Temperature'),
          ),
          TextButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/light');
            },
            icon: const Icon(Icons.data_array_outlined),
            label: const Text('Light'),
          ),
        ],
      ),
    );
  }
}
