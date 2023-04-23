import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_app/data/transaction.dart';
import 'package:flutter_money_app/extensions/expenses_extensions.dart';
import 'package:flutter_money_app/utils/constants.dart';

import '../utils/chart_utils.dart';




class WeeklyChart extends StatelessWidget {
  final Map<String, List<Transaction>> expenses;

  const WeeklyChart({super.key, required this.expenses});

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color:fontSubHeading,
      fontSize: 16,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'M';
        break;
      case 1:
        text = 'T';
        break;
      case 2:
        text = 'W';
        break;
      case 3:
        text = 'T';
        break;
      case 4:
        text = 'F';
        break;
      case 5:
        text = 'S';
        break;
      case 6:
        text = 'S';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 55,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 32),
      height: 117,
      child: BarChart(
        
        BarChartData(
           borderData: FlBorderData(
                border: const Border(bottom: BorderSide.none, left: BorderSide.none)),
          barGroups: [
            makeGroupData(0, expenses["Monday"]?.sum() ?? 0.0, 39),
            makeGroupData(1, expenses["Tuesday"]?.sum() ?? 0.0, 39),
            makeGroupData(2, expenses["Wednesday"]?.sum() ?? 0.0, 39),
            makeGroupData(3, expenses["Thursday"]?.sum() ?? 0.0, 39),
            makeGroupData(4, expenses["Friday"]?.sum() ?? 0.0, 39),
            makeGroupData(5, expenses["Saturday"]?.sum() ?? 0.0, 39),
            makeGroupData(6, expenses["Sunday"]?.sum() ?? 0.0, 39),
          ],
          titlesData: titlesData,
          
          gridData: FlGridData(
            show: false,
          ),
        ),
      ),
    );
  }
}
