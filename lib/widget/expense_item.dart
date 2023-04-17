import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseItem extends StatelessWidget {
  final String title;
  final DateTime date;
  final double amount;
  final Key key;
  final Function deleteExpense;
  final String id;

  ExpenseItem(
      this.id, this.date, this.title, this.amount, this.key, this.deleteExpense)
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (direction) {
        deleteExpense(id);
      },
      direction: DismissDirection.endToStart,
      background: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.centerRight,
        color: Colors.white,
        child: Icon(
          Icons.delete,
          color: Colors.blue,
        ),
      ),
      key: key,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue,
        ),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(DateFormat("dd MMMM, y").format(date),
            style: TextStyle(fontSize: 12)),
        trailing: Text("$amount so'm"),
      ),
    );
  }
}
