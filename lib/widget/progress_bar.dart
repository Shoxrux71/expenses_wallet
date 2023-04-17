import 'package:flutter/material.dart';

class progresBar extends StatelessWidget {
  final double totalLimitPersentage;

  progresBar(this.totalLimitPersentage);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      width: double.infinity,
      height: 6,
      decoration: BoxDecoration(
        color: Color.fromRGBO(212, 219, 239, 1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: FractionallySizedBox(
        heightFactor: 2,
        widthFactor: totalLimitPersentage / 100,
        child: Container(
          width: double.infinity,
          height: 5,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue,
                Colors.blueAccent,
                Colors.blue.shade100,
                Colors.lightBlue,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.blue,
                blurRadius: 10,
                spreadRadius: -3,
              ),
            ],
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
