import 'dart:math';

import 'package:expence_planner/models/transaction.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: transactions.isEmpty
          ? LayoutBuilder(
              builder: ((context, constraints) => Column(
                    children: [
                      Text(
                        'No transactions added yet!',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                          height: constraints.maxHeight * 0.6,
                          child: Image.asset('assets/images/waiting.png'))
                    ],
                  )))
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return TrxItem(
                    key: ValueKey(transactions[index].id),
                    transaction: transactions[index],
                    deleteTransaction: deleteTransaction);
              },
              itemCount: transactions.length,
            ),
    );
  }
}

class TrxItem extends StatefulWidget {
  const TrxItem({
    Key? key,
    required this.transaction,
    required this.deleteTransaction,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTransaction;

  @override
  State<TrxItem> createState() => _TrxItemState();
}

class _TrxItemState extends State<TrxItem> {
  Color? _bgColor;

  @override
  void initState() {
    const avalColors = [Colors.red, Colors.black, Colors.blue, Colors.green];
    final number = Random(DateTime.now().microsecondsSinceEpoch).nextInt(4);
    _bgColor = avalColors[number];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      elevation: 5,
      child: ListTile(
        leading: CircleAvatar(
            backgroundColor: _bgColor,
            child: Padding(
              padding: EdgeInsets.all(4),
              child: FittedBox(
                child: Text(
                  '\$${widget.transaction.amount.toStringAsFixed(1)}',
                ),
              ),
            )),
        title: Text(
          widget.transaction.title,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(widget.transaction.date),
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.delete,
            color: Theme.of(context).errorColor,
          ),
          onPressed: () => widget.deleteTransaction(widget.transaction.id),
        ),
      ),
    );
  }
}
