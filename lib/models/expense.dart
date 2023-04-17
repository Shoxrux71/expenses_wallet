import 'package:flutter/material.dart';
import 'package:xarajat_hamyon/widget/expenceList.dart';

class Expense {
  final String id;
  final String title;
  final DateTime date;
  final double amount;
  final IconData icon;

  Expense({
    required this.id,
    required this.amount,
    required this.date,
    this.icon = Icons.ac_unit,
    required this.title,
  });
}

class Expenses {
  List<Expense> _items = [
    Expense(id: "e1", amount: 20000, date: DateTime.now(), title: "tarvuz"),
    Expense(id: "e2", amount: 290000, date: DateTime.now(), title: "krasovka"),
    // Expense(
    //     id: "e3",
    //     amount: 2000000,
    //     date: DateTime.now(),
    //     title: "flutter darsi"),
    // Expense(
    //     id: "e4",
    //     amount: 8000000,
    //     date: DateTime.now(),
    //     title: "new yorkga bilet"),
  ];

  List<Expense> get items {
    return _items;
  }

  List<Expense> itemsByMonth(DateTime date) {
    return _items
        .where((expense) =>
            expense.date.month == date.month && expense.date.year == date.year)
        .toList();
  }

  double totalExpensesByMonth(DateTime date) {
    final expensesByMonth = itemsByMonth(date);

    return expensesByMonth.fold(0, (previousValue, expense) {
      return previousValue + expense.amount;
    });
  }

  void addNewExpense(String title, double amount, DateTime date) {
    _items.add(
      Expense(
          id: "e{_items.length + 1}", amount: amount, date: date, title: title),
    );
  }

  void delete(String id) {
    _items.removeWhere((expense) => expense.id == id);
  }
}
