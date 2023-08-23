import 'package:expense_management/bar%20graph/bar_graph.dart';
import 'package:expense_management/data/Expense_data.dart';
import 'package:expense_management/dateTime/Date_Time_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime stateOfWeek;
  const ExpenseSummary({
    super.key,
    required this.stateOfWeek,
  });

  // calculate max amount in bar graph
  double calculateMax(
    ExpenseData value,
    String sunday,
    String monday,
    String tuesday,
    String wednesday,
    String thursday,
    String friday,
    String saturday,
  ) {
    double? max = 100;

    List<double> values = [
      value.calculateDailyExpenseSummary()[sunday] ?? 0,
      value.calculateDailyExpenseSummary()[monday] ?? 0,
      value.calculateDailyExpenseSummary()[tuesday] ?? 0,
      value.calculateDailyExpenseSummary()[wednesday] ?? 0,
      value.calculateDailyExpenseSummary()[thursday] ?? 0,
      value.calculateDailyExpenseSummary()[friday] ?? 0,
      value.calculateDailyExpenseSummary()[saturday] ?? 0,
    ];

    values.sort();

    max = values.last * 1.1;

    return max == 0 ? 100 : max;
    
  }

  // calculate week total

  String calculateWeekTotal(
    ExpenseData value,
    String sunday,
    String monday,
    String tuesday,
    String wednesday,
    String thursday,
    String friday,
    String saturday,
  ) {
    List<double> values = [
      value.calculateDailyExpenseSummary()[sunday] ?? 0,
      value.calculateDailyExpenseSummary()[monday] ?? 0,
      value.calculateDailyExpenseSummary()[tuesday] ?? 0,
      value.calculateDailyExpenseSummary()[wednesday] ?? 0,
      value.calculateDailyExpenseSummary()[thursday] ?? 0,
      value.calculateDailyExpenseSummary()[friday] ?? 0,
      value.calculateDailyExpenseSummary()[saturday] ?? 0,
    ];

    double total = 0;
    for (int i = 0; i < values.length; i++) {
      total += values[i];
    }

    return total.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    // get yyyymmdd for each day of this week

    String sunday =
        converDateTimeToString(stateOfWeek.add(const Duration(days: 0)));
    String monday =
        converDateTimeToString(stateOfWeek.add(const Duration(days: 1)));
    String tuesday =
        converDateTimeToString(stateOfWeek.add(const Duration(days: 2)));
    String wednseday =
        converDateTimeToString(stateOfWeek.add(const Duration(days: 3)));
    String thursday =
        converDateTimeToString(stateOfWeek.add(const Duration(days: 4)));
    String firday =
        converDateTimeToString(stateOfWeek.add(const Duration(days: 5)));
    String saturday =
        converDateTimeToString(stateOfWeek.add(const Duration(days: 6)));

    return Consumer<ExpenseData>(
      builder: (context, value, child) => Column(
        children: [
          // week total
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              children: [
                const Text(
                  "Week Total: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("\₹" +
                    calculateWeekTotal(value, sunday, monday, tuesday,
                        wednseday, thursday, firday, saturday)),
              ],
            ),
          ),
          SizedBox(
            height: 200,
            child: MyBarGraph(
                maxY: calculateMax(value, sunday, monday, tuesday, wednseday,
                    thursday, firday, saturday),
                sunAmount: value.calculateDailyExpenseSummary()[sunday] ?? 0,
                monAmount: value.calculateDailyExpenseSummary()[monday] ?? 0,
                tueAmount: value.calculateDailyExpenseSummary()[tuesday] ?? 0,
                wedAmount: value.calculateDailyExpenseSummary()[wednseday] ?? 0,
                thurAmount: value.calculateDailyExpenseSummary()[thursday] ?? 0,
                friAmount: value.calculateDailyExpenseSummary()[firday] ?? 0,
                satAmount: value.calculateDailyExpenseSummary()[saturday] ?? 0),
          ),
        ],
      ),
    );
  }
}
