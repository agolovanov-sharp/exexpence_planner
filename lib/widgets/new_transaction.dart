import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final Function onAddTx;

  NewTransaction({Key? key, required this.onAddTx}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: titleController,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
              controller: amountController,
            ),
            TextButton(
              onPressed: () {
                onAddTx(
                    titleController.text, double.parse(amountController.text));
              },
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.purple)),
              child: const Text('Add Transaction'),
            )
          ],
        ),
      ),
    );
  }
}
