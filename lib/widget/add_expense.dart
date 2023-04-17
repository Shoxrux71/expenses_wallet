import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:xarajat_hamyon/widget/expenceList.dart';
import './adabtiveTextField.dart';
import './adabtiveButton.dart';
// import 'package:flutter_iconpicker/flutter_iconpicker.dart';

class AddExpense extends StatefulWidget {
  final Function addNewExpense;
  AddExpense(this.addNewExpense) {
    print("Add Expense Constructor");
  }

  @override
  // State<AddExpense> createState() => _AddExpenseState();
  //   @override
  State<AddExpense> createState() {
    print("Create Expense State");
    return _AddExpenseState();
  }
}

class _AddExpenseState extends State<AddExpense> {
  DateTime? selectedDate;
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    print("Init State");
  }

  @override
  void didUpdateWidget(covariant AddExpense oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("Did Update widget");
  }

  @override
  void dispose() {
    super.dispose();
    print("dispos");
  }

  void showNewExpenceCalendar(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      helpText: "Harajat kuni",
      cancelText: "Ortga",
      confirmText: "Tanlash",
    ).then((value) {
      setState(() {
        if (value != null) {
          selectedDate = value;
        }
      });
    });
  }

  // void showExpenseIconPicker(BuildContext context) {
  //   setState(() {
  //     FlutterIconPicker.showIconPicker(context).then((icon) {
  //       print(icon);
  //     });
  //   });
  // }

  void _submit() {
    if (_titleController.text.isEmpty ||
        _amountController.text.isEmpty ||
        selectedDate == null) {
      return;
    }
    var tite = _titleController.text;
    var amount = double.parse(_amountController.text);
    if (amount <= 0) {
      return;
    }

    widget.addNewExpense(tite, amount, selectedDate);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    print("Add expense build");
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom > 0
                ? MediaQuery.of(context).viewInsets.bottom
                : 80),
        child: Column(
          children: [
            adabtiveTextField(
              label: 'Xarajatlar nomi',
              controller: _titleController,
            ),
            SizedBox(
              height: 10,
            ),
            adabtiveTextField(
              label: 'Xarajatlar miqdori',
              controller: _amountController,
              keyboardType: TextInputType.number,
            ),
            // TextField(
            //   decoration: InputDecoration(
            //     labelText: "Xarajatlar miqdori",
            //   ),
            //   controller: _amountController,
            //   keyboardType: TextInputType.number,
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                selectedDate == null
                    ? const Text("Harajat kuni tanlanmadi!")
                    : Text(
                        "Harajat uni: ${DateFormat("dd MMMM y").format(selectedDate!)}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                TextButton(
                  onPressed: () {
                    showNewExpenceCalendar(context);
                  },
                  child: const Text(
                    "Kunni tanlash",
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Rasm tanlang!"),
                TextButton(
                  onPressed: () {
                    // showExpenseIconPicker(context);
                  },
                  child: const Text(
                    "Rasm tanlash",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    // pop hozirgi aktiv oynani yopadi
                    Navigator.of(context).pop();
                  },
                  child: Text("Bekor qilish"),
                ),
                adabtiveButton(
                  text: 'Kiritish',
                  handler: _submit,
                  // filled: true,
                ),
                // ElevatedButton(
                //   onPressed: () {
                //     _submit();
                //   },
                //   child: Text("Kiritish"),
                // ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
