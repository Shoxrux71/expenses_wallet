import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './progress_bar.dart';
import './edit_monthly_budget.dart';

class Budget extends StatefulWidget {
  final double totalByMonth;

  Budget(this.totalByMonth);

  @override
  State<Budget> createState() => _BudgetState();
}

class _BudgetState extends State<Budget> {
  double budgetimit = 1000000;

  void showMOnthlyBudgetWindoow(BuildContext context) {
    showModalBottomSheet(
        isDismissible: false,
        context: context,
        builder: (ctx) {
          return EditMonthlyBudget(changeBudgetLimit, budgetimit);
        });
  }

  void changeBudgetLimit(double amount) {
    setState(() {
      budgetimit = amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Header");
    var totalLimitPersentage = 100 * widget.totalByMonth / budgetimit;
    totalLimitPersentage =
        totalLimitPersentage > 100 ? 100 : totalLimitPersentage;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          height: constraints.maxHeight,
          decoration: BoxDecoration(
            color: Color.fromRGBO(239, 240, 250, 1),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text("Oylik byudjet"),
                      TextButton.icon(
                        onPressed: () {
                          showMOnthlyBudgetWindoow(context);
                        },
                        icon: Icon(Icons.edit),
                        label: Text("${budgetimit.toStringAsFixed(0)} so'm"),
                      ),
                    ],
                  ),
                  Text("${totalLimitPersentage.toStringAsFixed(0)}%"),
                ],
              ),
              progresBar(totalLimitPersentage),
            ],
          ),
        );
      },
    );
  }
}
