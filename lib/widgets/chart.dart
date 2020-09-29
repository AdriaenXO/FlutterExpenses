import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import 'chart_bar.dart';

class Chart extends StatelessWidget {
  Chart(
    this.transactions,
  );
  final List<Transaction> transactions;

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(
      7,
      (index) {
        final weekDay = DateTime.now().subtract(
          Duration(days: index),
        );

        double amount = 0.0;
        for (var tx in transactions) {
          if (tx.date.difference(weekDay).inDays == 0 &&
              tx.date.day == weekDay.day) {
            amount += tx.amount;
          }
        }
        return {
          'day': DateFormat.E().format(weekDay),
          'amount': amount,
        };
      },
    ).reversed.toList();
  }

  double get totalAmount {
    // double amount = 0;
    // for (var tx in transactions) amount += tx.amount;

    // return amount;
    return transactions.fold(
        0, (previousValue, element) => previousValue + element.amount);
  }

  @override
  Widget build(BuildContext context) {
    print('chart build run');
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: groupedTransactionValues.map((data) {
            // return Text('${data['day']}: ${data['amount'].toString()}');
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                data['day'],
                data['amount'],
                totalAmount,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
