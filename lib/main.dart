import 'package:expence_planner/models/transaction.dart';
import 'package:expence_planner/widgets/chart.dart';
import 'package:expence_planner/widgets/new_transaction.dart';
import 'package:expence_planner/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme =
        ThemeData(fontFamily: 'Quicksand', primarySwatch: Colors.purple);

    return MaterialApp(
      title: 'Personal Expences',
      theme: theme.copyWith(
          textTheme: ThemeData.light().textTheme.copyWith(
              titleSmall: const TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 18)),
          appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(fontFamily: 'OpenSans', fontSize: 20)),
          colorScheme: theme.colorScheme
              .copyWith(primary: Colors.purple, secondary: Colors.amber)),
      home: HomeWidget(),
    );
  }
}

class HomeWidget extends StatefulWidget {
  HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //     id: '1',
    //     title: 'New spoon and plate',
    //     amount: 22.3,
    //     date: DateTime.now()),
    // Transaction(
    //     id: '2',
    //     title: 'Bought new smartphone',
    //     amount: 81.3,
    //     date: DateTime.now()),
  ];

  void _addNewTransaction(String title, double amount) {
    final newTx = Transaction(
        id: title, title: title, amount: amount, date: DateTime.now());

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(onAddTx: _addNewTransaction);
        });
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions
        .where((tx) =>
            tx.date.isAfter(DateTime.now().subtract(const Duration(days: 7))))
        .toList();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expence planner'),
        actions: [
          IconButton(
              onPressed: () => _startAddNewTransaction(context),
              icon: const Icon(Icons.add))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(_recentTransactions),
            TransactionList(_userTransactions)
          ],
        ),
      ),
    );
  }
}
