import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expence_planner/models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      print('index: $index');
      final weekday = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekday.day &&
            recentTransactions[i].date.month == weekday.month &&
            recentTransactions[i].date.year == weekday.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      print('day: ${DateFormat.E().format(weekday)} amount: $totalSum');

      return {'day': DateFormat.E().format(weekday), 'amount': totalSum};
    });
  }

  @override
  Widget build(BuildContext context) {
    groupedTransactions;

    return Card(
        elevation: 6,
        margin: EdgeInsets.all(18),
        child: Row(
          children: [],
        ));
  }
}
