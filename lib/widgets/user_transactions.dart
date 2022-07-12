import 'package:expence_planner/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

import 'new_transaction.dart';
import '../models/transaction.dart';

class UserTransactions extends StatefulWidget {
  const UserTransactions({Key? key}) : super(key: key);

  @override
  State<UserTransactions> createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _userTransactions = [
    Transaction(
        id: '1',
        title: 'New spoon and plate',
        amount: 22.3,
        date: DateTime.now()),
    Transaction(
        id: '2',
        title: 'Bought new smartphone',
        amount: 81.3,
        date: DateTime.now()),
  ];

  _addNewTransaction(String title, double amount) {
    final newTx = Transaction(
        id: title, title: title, amount: amount, date: DateTime.now());

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(
          onAddTx: _addNewTransaction,
        ),
        TransactionList(_userTransactions)
      ],
    );
  }
}
