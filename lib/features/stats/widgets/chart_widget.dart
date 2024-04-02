import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyChart extends StatefulWidget {
  final List<double> expenses;
  final DateTime fromDate;
  final DateTime toDate;
  const MyChart(
      {required this.expenses,
      required this.fromDate,
      required this.toDate,
      super.key});

  @override
  State<MyChart> createState() => _MyChartState();
}

class _MyChartState extends State<MyChart> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animation,
        builder: (context, _) {
          return BarChart(
            mainBarData(widget.expenses, _animation.value),
          );
        });
  }

  BarChartGroupData makeGroupData(int x, double y, double animationValu) {
    return BarChartGroupData(x: x, barRods: [
      BarChartRodData(
          toY: y * animationValu,
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary,
              Theme.of(context).colorScheme.tertiary,
            ],
            transform: const GradientRotation(pi / 40),
          ),
          width: 20,
          backDrawRodData: BackgroundBarChartRodData(
              show: true, toY: 5, color: Colors.grey.shade300))
    ]);
  }

  List<BarChartGroupData> showingGroups(
      List<double> amounts, double animationValue) {
    List<BarChartGroupData> chartData = [];
    int index = 0;
    for (var amount in amounts) {
      chartData.add(makeGroupData(_getDate(index), amount, animationValue));
      index++;
    }
    return chartData;
  }
  // List.generate(7, (i) {
  //   switch (i) {
  //     case 0:
  //       return makeGroupData(0, 2, animationValue);
  //     case 1:
  //       return makeGroupData(1, 3, animationValue);
  //     case 2:
  //       return makeGroupData(2, 2, animationValue);
  //     case 3:
  //       return makeGroupData(3, 4.5, animationValue);
  //     case 4:
  //       return makeGroupData(4, 3.8, animationValue);
  //     case 5:
  //       return makeGroupData(5, 1.5, animationValue);
  //     case 6:
  //       return makeGroupData(6, 4, animationValue);
  //     case 7:
  //       return makeGroupData(7, 3.8, animationValue);
  //     default:
  //       return throw Error();
  //   }
  // });

  BarChartData mainBarData(List<double> amounts, double animationValue) {
    return BarChartData(
      titlesData: FlTitlesData(
        show: true,
        rightTitles:
            const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
            sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 38,
          getTitlesWidget: getTiles,
        )),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 38,
            getTitlesWidget: leftTitles,
          ),
        ),
      ),
      borderData: FlBorderData(show: false),
      gridData: const FlGridData(show: false),
      barGroups: showingGroups(amounts, animationValue),
    );
  }

  Widget getTiles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text = Text(
      value.toInt().toString(),
      style: style,
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    String text = value.toInt().toString();

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(text, style: style),
    );
  }

  int _getDate(int index) {
    DateTime date = widget.fromDate.add(Duration(days: index));

    return date.day;
  }

  // double _getMaximumValue(List<double> expenses) {
  //   double maxValue =
  //       expenses.reduce((value, element) => value > element ? value : element);
  //   return maxValue;
  // }

  // double _getMinimumValue(List<double> expenses) {
  //   double minValue =
  //       expenses.reduce((value, element) => value < element ? value : element);
  //   return minValue;
  // }
}
