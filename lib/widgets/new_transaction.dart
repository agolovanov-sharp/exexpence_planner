import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function onAddTx;

  NewTransaction({Key? key, required this.onAddTx}) : super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  submitData() {
    final amount = double.parse(amountController.text);
    final title = titleController.text;

    if (title.isEmpty || amount <= 0) {
      return;
    }

    widget.onAddTx(title, double.parse(amountController.text));
    Navigator.of(context).pop();
  }

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
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
              controller: amountController,
              onSubmitted: (_) => submitData(),
            ),
            TextButton(
              onPressed: submitData,
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
