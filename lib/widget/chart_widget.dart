import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';


import '../data/transaction.dart';



class LineChartWidget extends StatelessWidget {
  final List<Transaction> data;

  const LineChartWidget(this.data, {Key? key})
      : super(key: key);
 SideTitles get _bottomTitles => SideTitles(
    showTitles: true,
    getTitlesWidget: (value, meta) {
      String text = '';
      switch (value.toInt()) {
        case 1:
          text = 'Jan';
          break;
           case 2:
          text = 'Fev';
          break;
        case 3:
          text = 'Mar';
          break;
           case 4:
          text = 'Avr';
          break;
        case 5:
          text = 'May';
          break;
           case 6:
          text = 'Jun';
          break;
        case 7:
          text = 'Jul';
          break;
          case 7:
          text = 'Aug';
          break;
        case 9:
          text = 'Sept';
          break;
           case 9:
          text = 'Oct';
          break;
        case 11:
          text = 'Nov';
          break;
           case 11:
          text = 'Dec';
          break;
      }

      return Text(text);
    },
  );
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: LineChart(
        LineChartData(
            lineBarsData: [
              LineChartBarData(
                spots: data.map((point) => FlSpot(point.key, point.amount)).toList(),
              isCurved: true
                // dotData: FlDotData(
                //   show: false,
                // ),
              ),
              
            ],
              borderData: FlBorderData(
                border: const Border(bottom: BorderSide(), left: BorderSide())),
            gridData: FlGridData(show: false),
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(sideTitles: _bottomTitles),
              leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
          
          ),
           swapAnimationDuration: Duration(milliseconds: 150), // Optional
  swapAnimationCurve: Curves.linear, 
      ),
    );
  }
}