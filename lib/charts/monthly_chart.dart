import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_app/data/transaction.dart';
import 'package:flutter_money_app/extensions/expenses_extensions.dart';
import '../utils/chart_utils.dart';


class MonthlyChart extends StatelessWidget {
  final List<Transaction> expenses;
  final DateTime startDate;
  final DateTime endDate;

  const MonthlyChart(
      {super.key,
      required this.expenses,
      required this.startDate,
      required this.endDate});

  Map<int, List<Transaction>> get groupedExpenses =>
      expenses.groupMonthly(startDate);

  Widget getTitles(double value, TitleMeta meta) {
    if (value % 5 != 0) {
      return Container();
    }

    const style = TextStyle(
      color: Color.fromARGB(255, 142, 142, 147),
      fontSize: 16,
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text("${value.toInt()}", style: style),
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
      height: 100,
      child: BarChart(
        BarChartData(
          borderData: FlBorderData(
                border: const Border(bottom: BorderSide.none, left: BorderSide.none)),
          barGroups: List.generate(
              groupedExpenses.length,
              (index) => makeGroupData(
                  index, groupedExpenses[index]?.sum() ?? 0.0, 6)),
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
