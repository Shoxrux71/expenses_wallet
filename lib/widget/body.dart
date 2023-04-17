import 'package:flutter/material.dart';
import 'package:xarajat_hamyon/models/expense.dart';
import 'budget.dart';
import 'expenceList.dart';
import '../models/expense.dart';

class Body extends StatelessWidget {
  final List<Expense> expenses;
  final double totalByMonth;
  final Function deleteExpense;

  Body(this.expenses, this.totalByMonth, this.deleteExpense);

  @override
  Widget build(BuildContext context) {
    print("Body build");
    return Stack(
      children: [
        Budget(totalByMonth),
        expenceList(expenses, deleteExpense),
      ],
    );
  }
}
