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
                return Card(
                  margin: EdgeInsets.all(8),
                  elevation: 5,
                  child: ListTile(
                    leading: CircleAvatar(
                        child: Padding(
                      padding: EdgeInsets.all(4),
                      child: FittedBox(
                        child: Text(
                          '\$${transactions[index].amount.toStringAsFixed(1)}',
                        ),
                      ),
                    )),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(ctx).textTheme.titleSmall,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Theme.of(context).errorColor,
                      ),
                      onPressed: () =>
                          deleteTransaction(transactions[index].id),
                    ),
                  ),
                );
                // return Card(
                //     child: Row(
                //   children: [
                //     Container(
                //       margin: const EdgeInsets.symmetric(
                //           vertical: 10, horizontal: 15),
                //       decoration: BoxDecoration(
                //           border: Border.all(
                //               color: Theme.of(ctx).primaryColor, width: 2)),
                //       padding: const EdgeInsets.all(10),
                //       child: Text(
                //         '\$${transactions[index].amount.toStringAsFixed(2)}',
                //         style: TextStyle(
                //             fontWeight: FontWeight.bold,
                //             fontSize: 20,
                //             color: Theme.of(ctx).primaryColor),
                //       ),
                //     ),
                //     Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Text(
                //           transactions[index].title,
                //           style: Theme.of(ctx).textTheme.titleSmall,
                //         ),
                //         Text(
                //           DateFormat.yMMMd().format(transactions[index].date),
                //           style:
                //               const TextStyle(fontSize: 16, color: Colors.grey),
                //         )
                //       ],
                //     )
                //   ],
                // ));
              },
              itemCount: transactions.length,
            ),
    );
  }
}
