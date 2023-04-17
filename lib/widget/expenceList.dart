import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../models/expense.dart';
import 'package:intl/intl.dart';
import './expense_item.dart';

class expenceList extends StatelessWidget {
  final List<Expense> expenses;
  final Function deleteExpense;
  expenceList(this.expenses, this.deleteExpense);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
          clipBehavior: Clip.hardEdge,
          width: MediaQuery.of(context).size.width,
          height: constraints.maxHeight - 104,
          margin: EdgeInsets.only(top: 104),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          child: expenses.length > 0
              ? ListView.builder(
                  padding: const EdgeInsets.only(top: 10, right: 5),
                  itemBuilder: (ctx, i) {
                    return ExpenseItem(
                      expenses[i].id,
                      expenses[i].date,
                      expenses[i].title,
                      expenses[i].amount,
                      ValueKey(expenses[i].id),
                      deleteExpense,
                    );
                  },
                  itemCount: expenses.length,
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: [
                      Text(
                        "Harajatlar yo'q!",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Image.asset(
                        "assets/images/money.png",
                        fit: BoxFit.cover,
                        width: 340,
                      ),
                    ],
                  ),
                ));
    });
  }
}
