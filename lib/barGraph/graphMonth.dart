import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MonthlyExpensesChart extends StatefulWidget {
  final List<List<dynamic>> transactions;

  MonthlyExpensesChart({required this.transactions});

  @override
  _MonthlyExpensesChartState createState() => _MonthlyExpensesChartState();
}

class _MonthlyExpensesChartState extends State<MonthlyExpensesChart> {
  late List<BarChartGroupData> barGroups;

  double maxY = 0;

  @override
  void initState() {
    super.initState();
    generateBarGroups();
  }

  void generateBarGroups() {
    final List<double> monthlyExpenses = List.generate(12, (month) {
      final DateTime currentMonth = DateTime(DateTime.now().year, month + 1, 1);
      final DateTime nextMonth = DateTime(DateTime.now().year, month + 2, 1);

      final double totalExpense = widget.transactions
          .where((transaction) =>
              transaction[2] == true &&
              transaction[6].isAfter(currentMonth) &&
              transaction[6].isBefore(nextMonth))
          .map((transaction) =>
              double.tryParse(transaction[3].toString()) ?? 0.0)
          .fold(0, (a, b) => a + b);
      return totalExpense;
    });

    final List<double> monthlyEarnings = List.generate(12, (month) {
      final DateTime currentMonth = DateTime(DateTime.now().year, month + 1, 1);
      final DateTime nextMonth = DateTime(DateTime.now().year, month + 2, 1);

      final double totalEarning = widget.transactions
          .where((transaction) =>
              transaction[2] == false &&
              transaction[6].isAfter(currentMonth) &&
              transaction[6].isBefore(nextMonth))
          .map((transaction) =>
              double.tryParse(transaction[3].toString()) ?? 0.0)
          .fold(0, (a, b) => a + b);
      return totalEarning;
    });

    maxY = monthlyExpenses.reduce((a, b) => a > b ? a : b);
    maxY = maxY > monthlyEarnings.reduce((a, b) => a > b ? a : b)
        ? maxY
        : monthlyEarnings.reduce((a, b) => a > b ? a : b);

    barGroups = List.generate(12, (month) {
      return makeGroupData(month, monthlyExpenses[month], monthlyEarnings[month]);
    });
  }

  BarChartGroupData makeGroupData(int month, double totalExpense, double totalEarning) {
    return BarChartGroupData(
      x: month,
      barRods: [
        BarChartRodData(
          color: Color.fromARGB(255, 183, 228, 172), // Earnings color
          width: 8,
          toY: totalEarning,
        ),
        BarChartRodData(
          color: Color.fromARGB(255, 228, 175, 172), // Expenses color
          width: 8,
          toY: totalExpense,
        ),
      ],
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
  final List<String> monthNames = [
    'J', 'F', 'M', 'A', 'M', 'J',
    'J', 'A', 'S', 'O', 'N', 'D'
  ];

  final String title = monthNames[value.toInt()];

  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 16, // margin top
    child: Text(
      title,
      style: const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    generateBarGroups();
    return AspectRatio(
      aspectRatio: 3,
      child: BarChart(
        BarChartData(
          titlesData: FlTitlesData(
            show: true,
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: bottomTitles,
                reservedSize: 42,
              ),
            ),
          ),
          borderData: FlBorderData(
            show: false,
          ),
          barGroups: barGroups,
          gridData: const FlGridData(show: false),
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              tooltipBgColor: Colors.grey,
              getTooltipItem: (a, b, c, d) => null,
            ),
          ),
          maxY: maxY, // Adjust the maximum value as needed
        ),
      ),
    );
  }
}