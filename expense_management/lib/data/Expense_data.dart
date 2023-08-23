import 'package:expense_management/data/sql.dart';
import 'package:expense_management/dateTime/Date_Time_helper.dart';
import 'package:expense_management/models/Expense_items.dart';
import 'package:flutter/material.dart';

class ExpenseData extends ChangeNotifier {
  // list of All expenses

  List<ExpenseItem> overallExpenseList = [];

  // get expense list

  List<ExpenseItem> getAllExpenseList() {
    return overallExpenseList;
  }

  // prepare data to display

  final db = HiveDataBase();
  void prepareDate() {
    if (db.readData().isNotEmpty) {
      overallExpenseList = db.readData();
    }
  }

  // add new expense

  void addNewExpense(ExpenseItem newExpense) {
    overallExpenseList.add(newExpense);

    notifyListeners();
    db.saveData(overallExpenseList);
  }

  // delete expense

  void deleteExpense(ExpenseItem expense) {
    overallExpenseList.remove(expense);

    notifyListeners();
    db.saveData(overallExpenseList);
  }

  // get week days from a dateTime object

  String getDayName(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thur';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  // get the date for the start of week

  DateTime startOfWeekDate() {
    DateTime? startOfWeek;

    // get todays date
    DateTime today = DateTime.now();

    // go backwards from today to find sunday
    for (int i = 0; i < 7; i++) {
      if (getDayName(today.subtract(Duration(days: i))) == "Sun") {
        startOfWeek = today.subtract(Duration(days: i));
      }
    }

    return startOfWeek!;
  }

  /*
    
    conver overall list of expenses into a daily expense summary

  */

  Map<String, double> calculateDailyExpenseSummary() {
    Map<String, double> dailayExpenseSummary = {};

    for (var expense in overallExpenseList) {
      String date = converDateTimeToString(expense.dateTime);
      double amount = double.parse(expense.amount);

      if (dailayExpenseSummary.containsKey(date)) {
        double currentAmount = dailayExpenseSummary[date]!;
        currentAmount += amount;
        dailayExpenseSummary[date] = currentAmount;
      } else {
        dailayExpenseSummary.addAll({date: amount});
      }
    }

    return dailayExpenseSummary;
  }
}
