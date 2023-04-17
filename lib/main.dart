import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:month_picker_dialog_2/month_picker_dialog_2.dart';
import 'package:xarajat_hamyon/widget/add_expense.dart';
import 'header.dart';
import 'package:intl/intl.dart';
import './widget/body.dart';
import './models/expense.dart';
import './widget/add_expense.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();

  // SystemChrome.setPreferredOrientations(
  //   [
  //     DeviceOrientation.portraitUp,
  //     DeviceOrientation.portraitDown,
  //   ],
  // );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("My App Build");
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.blueAccent,
        textTheme: GoogleFonts.montserratTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      home: MyWallet(),
    );
  }
}

class MyWallet extends StatefulWidget {
  @override
  State<MyWallet> createState() => _MyWalletState();
}

class _MyWalletState extends State<MyWallet> with WidgetsBindingObserver {
  Expenses expenseDate = Expenses();
  DateTime selectedDate = DateTime.now();
  bool _showExpenseList = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print(state);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance!.removeObserver(this);
  }

  void showCalendar(BuildContext context) {
    showMonthPicker(
      context: context,
      initialDate: DateTime(2020),
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value != null) {
        setState(() {
          selectedDate = value;
        });
      }
    });
  }

  void previousMonth() {
    if (selectedDate.year == 2020 && selectedDate.month == 1) {
      return;
    }
    setState(() {
      selectedDate = DateTime(
        selectedDate.year,
        selectedDate.month - 1,
        selectedDate.day,
      );
    });
  }

  void nextMonth() {
    if (selectedDate.year == DateTime.now().year &&
        selectedDate.month == DateTime.now().month) {
      return;
    }
    setState(() {
      selectedDate = DateTime(
        selectedDate.year,
        selectedDate.month + 1,
        selectedDate.day,
      );
    });
  }

  void showAddExpenseWindow(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: false,
        context: context,
        builder: (ctx) {
          return AddExpense(addNewExpense);
        });
  }

  void addNewExpense(String title, double amount, DateTime date) {
    setState(() {
      expenseDate.addNewExpense(title, amount, date);
    });
  }

  void deleteExpense(String id) {
    setState(() {
      expenseDate.delete(id);
    });
  }

  Widget _showPortraitItems(totalByMonth, deviceHeight, deviceWidth) {
    print(deviceHeight);
    return Column(
      children: [
        Container(
          width: deviceWidth,
          height: deviceHeight > 750 ? deviceHeight * 0.2 : deviceHeight * 0.3,
          child: Header(
            showCalendar,
            selectedDate,
            previousMonth,
            nextMonth,
            totalByMonth,
          ),
        ),
        Container(
          height: deviceHeight > 750 ? deviceHeight * 0.8 : deviceHeight * 0.7,
          child: Body(
            expenseDate.itemsByMonth(selectedDate),
            totalByMonth,
            deleteExpense,
          ),
        ),
      ],
    );
  }

  Widget _showLandScapeItems(totalByMonth, deviceHeight, deviceWidth) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Ro\'yxatni ko\'rsating'),
            Platform.isAndroid
                ? Switch.adaptive(
                    value: _showExpenseList,
                    onChanged: (value) {
                      setState(
                        () {
                          _showExpenseList = value;
                        },
                      );
                    },
                  )
                : Container(),
          ],
        ),
        _showExpenseList
            ? Container(
                width: deviceWidth,
                height: deviceHeight * 0.9,
                child: Body(
                  expenseDate.itemsByMonth(selectedDate),
                  totalByMonth,
                  deleteExpense,
                ),
              )
            : Container(
                width: deviceWidth,
                height: deviceHeight * 0.9,
                child: Header(
                  showCalendar,
                  selectedDate,
                  previousMonth,
                  nextMonth,
                  totalByMonth,
                ),
              ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    print("MyWallet build");
    final totalByMonth = expenseDate.totalExpensesByMonth(selectedDate);
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final appBar = AppBar(
      title: Text(
        "UzClick",
        style: TextStyle(color: Colors.white),
      ),
      actions: Platform.isAndroid
          ? [
              IconButton(
                  onPressed: () {
                    showAddExpenseWindow(context);
                  },
                  icon: Icon(Icons.add))
            ]
          : [],
    );
    final topPadding = MediaQuery.of(context).padding.top;
    print(topPadding);
    final deviceHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        topPadding;
    final deviceWidth = MediaQuery.of(context).size.width;

    print(Platform.isIOS);
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            isLandscape
                ? _showLandScapeItems(totalByMonth, deviceHeight, deviceWidth)
                : _showPortraitItems(totalByMonth, deviceHeight, deviceWidth),
          ],
        ),
      ),
      floatingActionButton: Platform.isIOS
          ? FloatingActionButton(
              onPressed: () {
                showAddExpenseWindow(context);
              },
              child: Icon(Icons.add),
            )
          : Container(),
    );
  }
}
