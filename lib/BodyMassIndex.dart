import 'package:flutter/material.dart';
import 'package:im/UI/BMIForm.dart';

class BodyMassIndex extends StatefulWidget {
  const BodyMassIndex({super.key, required this.title});

  final String title;

  @override
  State<BodyMassIndex> createState() => _BodyMassIndexState();
}

class _BodyMassIndexState extends State<BodyMassIndex> {
  double _height = 0;
  double _width = 0;
  double _result = 0;
  String category = '';

  void _calculateImc() {
    if (_height <= 0 || _width <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid height and weight!')),
      );
      return;
    }

    setState(() {
      _result = (_width / (_height * _height)) * 10000;
      if (_result < 18.5) {
        category = 'Underweight';
      } else if (_result < 25) {
        category = 'Normal';
      } else if (_result < 30) {
        category = 'Overweight';
      } else {
        category = 'Obesity';
      }
    });
  }

  void setHeight(double height) {
    setState(() {
      _height = height;
    });
  }

  void setWidth(double width) {
    setState(() {
      _width = width;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: BMIForm(
        onCalculate: _calculateImc,
        result: _result,
        category: category,
        onHeightChanged: setHeight,
        onWidthChanged: setWidth,
      ),
    );
  }
}
