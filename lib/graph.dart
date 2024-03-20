import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class BarChartWidget extends StatefulWidget {
  final Map<String, double> data;

  const BarChartWidget({Key? key, required this.data}) : super(key: key);

  @override
  _BarChartWidgetState createState() => _BarChartWidgetState();
}

class _BarChartWidgetState extends State<BarChartWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(0),
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: getMaxY(),
            barGroups: getData(),
            gridData: FlGridData(
              show: true,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: Colors.white,
                  strokeWidth: 0.2,
                );
              },
              drawVerticalLine: true,
              getDrawingVerticalLine: (value) {
                return FlLine(
                  color: Colors.white,
                  strokeWidth: 0.25,
                );
              },
            ),
          ),
        ));
  }

  double getMaxY() {
    double maxValue = 0;
    widget.data.values.forEach((value) {
      if (value > maxValue) {
        maxValue = value;
      }
    });
    return maxValue + 1; // Adding 1 for some margin at the top
  }

  List<BarChartGroupData> getData() {
    List<BarChartGroupData> bars = [];

    widget.data.forEach((seconds, value) {
      bars.add(
        BarChartGroupData(
          x: int.parse(seconds),
          barRods: [
            BarChartRodData(
              fromY: 0,
              toY: value,
              color: Colors.red,
              width: 5,
            ),
          ],
        ),
      );
    });

    return bars;
  }
}
