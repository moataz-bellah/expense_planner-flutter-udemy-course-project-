import 'transaction_list.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();
  var _selectedDate;

  void submitData() {
    if (titleController.text.isEmpty ||
        amountController.text.isEmpty ||
        _selectedDate == null) {
      return;
    }
    final String enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    widget.addTx(enteredTitle, enteredAmount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'No Date Chosen!'
                          : '${_selectedDate}',
                    ),
                  ),
                  ElevatedButton(
                      onPressed: _presentDatePicker,
                      child: Text('Choose Date')),
                ],
              ),
            ),
            ElevatedButton(
                onPressed: submitData, child: Text('Add Transaction')),
          ],
        ),
      ),
    );
  }
}
