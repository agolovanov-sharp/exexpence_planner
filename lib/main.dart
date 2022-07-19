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
          colorScheme: theme.colorScheme.copyWith(
              primary: Colors.purple,
              secondary: Colors.amber,
              error: Colors.red)),
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
  final List<Transaction> _userTransactions = [];
  bool _showChart = false;

  void _addNewTransaction(String title, double amount, DateTime selectedDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: selectedDate);

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

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
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
    final appBar = AppBar(
      title: const Text('Expence planner'),
      actions: [
        IconButton(
            onPressed: () => _startAddNewTransaction(context),
            icon: const Icon(Icons.add))
      ],
    );

    return Scaffold(
      appBar: appBar,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Show Chart'),
                Switch(
                    value: _showChart,
                    onChanged: (value) {
                      setState(() {
                        _showChart = value;
                      });
                    })
              ],
            ),
            _showChart
                ? Container(
                    height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height -
                            MediaQuery.of(context).padding.top -
                            MediaQuery.of(context).padding.bottom) *
                        0.7,
                    child: Chart(_recentTransactions))
                : Container(
                    height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height -
                            MediaQuery.of(context).padding.top -
                            MediaQuery.of(context).padding.bottom) *
                        0.7,
                    child:
                        TransactionList(_userTransactions, _deleteTransaction))
          ],
        ),
      ),
    );
  }
}
