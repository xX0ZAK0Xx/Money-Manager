import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class WeeklyExpensesChart extends StatefulWidget {
  final List<List<dynamic>> transactions;

  WeeklyExpensesChart({required this.transactions});

  @override
  _WeeklyExpensesChartState createState() => _WeeklyExpensesChartState();
}

class _WeeklyExpensesChartState extends State<WeeklyExpensesChart> {
  final double width = 7;
  late List<BarChartGroupData> barGroups;

  double maxY=0;

  @override
  void initState() {
    super.initState();
    generateBarGroups();
  }

  void generateBarGroups() {
    // Initialize your data here based on your transaction model
    // For each day of the week, calculate the total expenses
    // You can modify this code to fit your data structure
    final DateTime now = DateTime.now();
    final DateTime lastWeek = now.subtract(Duration(days: 7));

    final List<double> weeklyExpenses = List.generate(7, (day) {
      final DateTime currentDay = lastWeek.add(Duration(days: day));
      final double totalExpense = widget.transactions
          .where((transaction) =>
              transaction[2] == true &&
              transaction[6].isAfter(currentDay) &&
              transaction[6].isBefore(currentDay.add(Duration(days: 1))))
          .map((transaction) =>
              double.tryParse(transaction[3].toString()) ?? 0.0)
          .fold(0, (a, b) => a + b);
      return totalExpense;
    });
    final List<double> weeklyEarnings = List.generate(7, (day) {
      final DateTime currentDay = lastWeek.add(Duration(days: day));
      final double totalEarning = widget.transactions
          .where((transaction) =>
              transaction[2] == false &&
              transaction[6].isAfter(currentDay) &&
              transaction[6].isBefore(currentDay.add(Duration(days: 1))))
          .map((transaction) =>
              double.tryParse(transaction[3].toString()) ?? 0.0)
          .fold(0, (a, b) => a + b);
      return totalEarning;
    });

    double maxExpense = weeklyExpenses.reduce((a, b) => a > b ? a : b);
    double maxEarning = weeklyEarnings.reduce((a, b) => a > b ? a : b);
    maxY = maxExpense > maxEarning ? maxExpense : maxEarning;

    // for(var ex in weeklyExpenses){
    //   print(ex);
    // }

    // Create BarChartGroupData for each day
    barGroups = List.generate(7, (day) {
      return makeGroupData(day, weeklyExpenses[day], weeklyEarnings[day]);
    });
  }

  BarChartGroupData makeGroupData(int day, double totalExpense, double totalEarning){
    return BarChartGroupData(
      x: day,
      barRods: [
        BarChartRodData(
          color: Color.fromARGB(255, 183, 228, 172), // Set your desired bar color here
          width: 10,
          toY: totalEarning,
        ),
        BarChartRodData(
          color: Color.fromARGB(255, 228, 175, 172), // Set your desired bar color here
          width: 10,
          toY: totalExpense,
        ),
      ],
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final today = DateTime.now();
    final dayAbbreviations = <String>[];
    
    for (int i = 6; i >= 0; i--) {
      final day = today.subtract(Duration(days: i));
      final dayAbbreviation = DateFormat.E().format(day).substring(0, 2);
      dayAbbreviations.add(dayAbbreviation);
    }
    
    final String title = dayAbbreviations[value.toInt()];

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, //margin top
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
