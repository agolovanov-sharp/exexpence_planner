import 'package:expence_planner/transaction.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeWidget(),
    );
  }
}

class HomeWidget extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(
        id: '1',
        title: 'New spoon and plate',
        amount: 22.3,
        date: DateTime.now()),
    Transaction(
        id: '2',
        title: 'Bought new smartphone',
        amount: 2222.3,
        date: DateTime.now()),
  ];

  HomeWidget({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expence planner'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: double.infinity,
            child: const Card(
              child: const Text('Chart'),
            ),
          ),
          Column(
            children: transactions
                .map((trans) => Card(
                      child: Text(trans.title),
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}
