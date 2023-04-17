import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog_2/month_picker_dialog_2.dart';

class Header extends StatelessWidget {
  final double totalByMont;
  final Function showCalendar;
  final DateTime selectedDate;
  final Function() previousMonth;
  final Function() nextMonth;

  Header(
    this.showCalendar,
    this.selectedDate,
    this.previousMonth,
    this.nextMonth,
    this.totalByMont,
  );

  @override
  Widget build(BuildContext context) {
    final isLastDate = selectedDate.year == DateTime.now().year &&
        selectedDate.month == DateTime.now().month;
    final isFirsthDate = selectedDate.year == 2020 && selectedDate.month == 1;

    return Padding(
      padding: const EdgeInsets.only(left: 22, right: 22),
      child: Column(
        children: [
          TextButton(
            onPressed: () {
              showCalendar(context);
            },
            child: Text(
              DateFormat("MMMM y").format(selectedDate),
              style: TextStyle(
                color: Colors.black54,
                fontSize: 20,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40,
                height: 40,
                child: IconButton(
                  padding: EdgeInsets.all(0),
                  onPressed: previousMonth,
                  icon: Icon(
                    Icons.arrow_left,
                    size: 30,
                    color: isFirsthDate ? Colors.grey : Colors.black,
                  ),
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: isFirsthDate ? Colors.grey : Colors.blue,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    totalByMont.toStringAsFixed(0),
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "so'm",
                    style: TextStyle(height: 0.8),
                  ),
                ],
              ),
              Container(
                width: 40,
                height: 40,
                child: IconButton(
                  padding: EdgeInsets.all(0),
                  onPressed: nextMonth,
                  icon: Icon(
                    Icons.arrow_right,
                    size: 30,
                    color: isLastDate ? Colors.grey : Colors.black,
                  ),
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: isLastDate ? Colors.grey : Colors.blue,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
