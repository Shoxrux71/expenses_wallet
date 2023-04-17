import 'package:flutter/material.dart';

class EditMonthlyBudget extends StatefulWidget {
  final Function changeBudgetLimit;
  final double budgetimit;

  EditMonthlyBudget(this.changeBudgetLimit, this.budgetimit);
  @override
  State<EditMonthlyBudget> createState() => _EditMonthlyBudgetState();
}

class _EditMonthlyBudgetState extends State<EditMonthlyBudget> {
  late TextEditingController _budgetAmountController;

  @override
  void initState() {
    _budgetAmountController = TextEditingController();
    _budgetAmountController.text = widget.budgetimit.toStringAsFixed(0);

    super.initState();
  }

  @override
  void dispose() {
    _budgetAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: "Oylik byudjet miqdori",
            ),
            controller: _budgetAmountController,
            keyboardType: TextInputType.number,
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Bekor qilish"),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_budgetAmountController.text.isEmpty) {
                    return;
                  }
                  final amount = double.parse(_budgetAmountController.text);
                  if (amount > 0) {
                    widget.changeBudgetLimit(amount);
                  }
                  Navigator.of(context).pop();
                },
                child: Text("Kiritish"),
              )
            ],
          )
        ],
      ),
    );
  }
}
