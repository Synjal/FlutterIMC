import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:im/UI/BMIForm.dart';

void main() {
  testWidgets('BMIForm calculates BMI correctly', (WidgetTester tester) async {
    double calculatedResult = 0.0;
    String calculatedCategory = '';

    void calculateBMI() {
      calculatedResult = 24.22;
      calculatedCategory = 'Normal';
    }

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: BMIForm(
            onCalculate: calculateBMI,
            result: calculatedResult,
            category: calculatedCategory,
            onHeightChanged: (height) {

            },
            onWidthChanged: (width) {

            },
          ),
        ),
      ),
    );

    await tester.enterText(find.byType(TextField).first, '170');
    await tester.enterText(find.byType(TextField).last, '70');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(find.text('BMI: 24.22'), findsOneWidget);
    expect(find.text('Category: Normal'), findsOneWidget);
  });

  testWidgets('BMIForm responds to height and weight changes', (WidgetTester tester) async {
    double calculatedResult = 0.0;
    String calculatedCategory = '';

    void calculateBMI() {
    }

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: BMIForm(
            onCalculate: calculateBMI,
            result: calculatedResult,
            category: calculatedCategory,
            onHeightChanged: (height) {

              calculatedResult = (70 / ((height / 100) * (height / 100)));
              calculatedCategory = (calculatedResult < 18.5) ? 'Underweight' :
              (calculatedResult < 25) ? 'Normal' :
              (calculatedResult < 30) ? 'Overweight' : 'Obesity';
            },
            onWidthChanged: (width) {
              calculatedResult = (width / ((170 / 100) * (170 / 100)));
              calculatedCategory = (calculatedResult < 18.5) ? 'Underweight' :
              (calculatedResult < 25) ? 'Normal' :
              (calculatedResult < 30) ? 'Overweight' : 'Obesity';
            },
          ),
        ),
      ),
    );

    await tester.enterText(find.byType(TextField).first, '170');
    await tester.enterText(find.byType(TextField).last, '70');
    final heightField = find.byType(TextField).first;
    await tester.enterText(heightField, '170');
    await tester.pump();

    final weightField = find.byType(TextField).last;
    await tester.enterText(weightField, '70');
    await tester.pump();

    expect(calculatedResult, closeTo(24.22, 0.01));
    expect(calculatedCategory, 'Normal');
  });
}
