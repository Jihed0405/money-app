import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_app/data/transaction.dart';
import 'package:flutter_money_app/extensions/expenses_extensions.dart';

import '../utils/chart_utils.dart';


class YearlyChart extends StatelessWidget {
  final List<Transaction> expenses;

  const YearlyChart({super.key, required this.expenses});

  Map<int, List<Transaction>> get groupedExpenses => expenses.groupYearly();

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color:Color.fromARGB(255, 142, 142, 147),
      fontSize: 16,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Jan';
        break;
      case 1:
        text = 'Feb';
        break;
      case 2:
        text = 'Mar';
        break;
      case 3:
        text = 'Apr';
        break;
      case 4:
        text = 'May';
        break;
      case 5:
        text = 'Jun';
        break;
      case 6:
        text = 'Jul';
        break;
      case 7:
        text = 'Aug';
        break;
      case 8:
        text = 'Sep';
        break;
      case 9:
        text = 'Oct';
        break;
      case 10:
        text = 'Nov';
        break;
      case 11:
        text = 'Dec';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      angle: -0.85,
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
          barGroups: List.generate(
              groupedExpenses.length,
              (index) => makeGroupData(
                  index, groupedExpenses[index]?.sum() ?? 0.0, 15)),
          titlesData: titlesData,
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
          ),
        ),
      ),
    );
  }
}
