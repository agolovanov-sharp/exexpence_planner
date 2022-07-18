import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function onAddTx;

  NewTransaction({Key? key, required this.onAddTx}) : super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  DateTime? _selectedDate;

  submitData() {
    final amount = double.parse(amountController.text);
    final title = titleController.text;

    if (title.isEmpty || amount <= 0 || _selectedDate == null) {
      return;
    }

    widget.onAddTx(title, double.parse(amountController.text), _selectedDate);
    Navigator.of(context).pop();
  }

  void _showDatepicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      primary: Theme.of(context).primaryColor,
      minimumSize: Size(88, 36),
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2.0)),
      ),
    );

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
            Container(
              height: 70,
              child: Row(
                children: [
                  Text(_selectedDate == null
                      ? 'No date chosen!'
                      : DateFormat.yMd().format(_selectedDate!)),
                  TextButton(
                    style: flatButtonStyle,
                    onPressed: () {
                      _showDatepicker();
                    },
                    child: Text('Choose Date'),
                  )
                ],
              ),
            ),
            ElevatedButton(
              onPressed: submitData,
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.white)),
              child: const Text('Add Transaction'),
            )
          ],
        ),
      ),
    );
  }
}
