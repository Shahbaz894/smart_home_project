import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BmeSensorChart extends StatefulWidget {
  const BmeSensorChart({Key? key}) : super(key: key);

  @override
  State<BmeSensorChart> createState() => _BmeSensorChartState();
}

class _BmeSensorChartState extends State<BmeSensorChart> {
  @override
  Widget build(BuildContext context) {
    final DatabaseReference databaseReference =
    FirebaseDatabase.instance.reference().child('UsersData');
    return Scaffold(
      appBar: AppBar(
        title: const Text('BME Sensor Graph'),
      ),
      body: StreamBuilder(
        stream: databaseReference.onValue,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          }

          // Sample data with hardcoded values for demonstration
          final data = [
            {
              'timestamp': '2024-01-25T12:00:00',
              'temperature': 8.5,
              'humidity': 50.2,
              'pressure': 1010.0,
            },
            {
              'timestamp': '2024-01-25T13:00:00',
              'temperature': 70.0,
              'humidity': 51.0,
              'pressure': 1012.0,
            },
            {
              'timestamp': '2024-01-25T14:00:00',
              'temperature': 30.8,
              'humidity': 49.5,
              'pressure': 1008.0,
            },
            // Add more data points as needed
          ];

          final chartData = _convertDocumentsToChartData(data);

          return SfCartesianChart(
            primaryXAxis: DateTimeAxis(),
            series: <ChartSeries>[
              LineSeries<ChartSampleData, DateTime>(
                dataSource: chartData,
                xValueMapper: (sales, _) => sales.x,
                yValueMapper: (sales, _) => sales.y[0],
                name: 'Temperature',
              ),
              LineSeries<ChartSampleData, DateTime>(
                dataSource: chartData,
                xValueMapper: (sales, _) => sales.x,
                yValueMapper: (sales, _) => sales.y[1],
                name: 'Humidity',
              ),
              LineSeries<ChartSampleData, DateTime>(
                dataSource: chartData,
                xValueMapper: (sales, _) => sales.x,
                yValueMapper: (sales, _) => sales.y[2],
                name: 'Pressure',
              ),
            ],
          );
        },
      ),
    );
  }

  List<ChartSampleData> _convertDocumentsToChartData(List<dynamic> data) {
    final chartData = <ChartSampleData>[];
    for (var item in data) {
      final timestamp = DateTime.parse(item['timestamp']);
      final temperature = (item['temperature'] as double);
      final humidity = (item['humidity'] as double);
      final pressure = (item['pressure'] as double);

      chartData.add(ChartSampleData(
        x: timestamp,
        y: [temperature, humidity, pressure],
      ));
    }
    return chartData;
  }
}

class ChartSampleData {
  final DateTime x;
  final List<double> y;

  const ChartSampleData({required this.x, required this.y});
}
