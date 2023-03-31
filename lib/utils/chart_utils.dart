import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';


BarChartGroupData makeGroupData(int x, double y, double width) {
  return BarChartGroupData(
    x: x,
    barRods: [
      BarChartRodData(
        toY: y,
        color:const Color(0xFFf49e9e),
        width: width,
        borderRadius: BorderRadius.circular(6),
      ),
    ],
  );
}
