import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class BMIForm extends StatefulWidget {
  const BMIForm({
    super.key,
    required this.onCalculate,
    required this.result,
    required this.category,
    required this.onHeightChanged,
    required this.onWidthChanged,
  });

  final void Function() onCalculate;
  final double result;
  final String category;
  final void Function(double) onHeightChanged;
  final void Function(double) onWidthChanged;

  @override
  State<BMIForm> createState() => _BMIFormState();
}

class _BMIFormState extends State<BMIForm> {
  late double _height;
  late double _width;

  @override
  void initState() {
    super.initState();
    _height = 0.0;
    _width = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(3)
              ],
              onChanged: (value) {
                double? height = double.tryParse(value);
                if (height != null) {
                  widget.onHeightChanged(height);
                }
              },
              decoration: const InputDecoration(
                labelText: 'Height (in centimeters)',
              ),
            ),
            TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(3)
              ],
              onChanged: (value) {
                double? weight = double.tryParse(value);
                if (weight != null) {
                  widget.onWidthChanged(weight);
                }
              },
              decoration: const InputDecoration(
                labelText: 'Weight (in kilograms)',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                widget.onCalculate();
              },
              child: const Text('Calculate'),
            ),
            Text('Category: ${widget.category}'),
            SfRadialGauge(
              axes: [
                RadialAxis(
                  minimum: 16.5,
                  maximum: 35,
                  ranges: [
                    GaugeRange(startValue: 16.5, endValue: 18.5, color: Colors.green),
                    GaugeRange(startValue: 18.5, endValue: 25, color: Colors.yellow),
                    GaugeRange(startValue: 25, endValue: 30, color: Colors.orange),
                    GaugeRange(startValue: 30, endValue: 35, color: Colors.red)
                  ],
                  pointers: [
                    MarkerPointer(value: widget.result, color: Colors.black, markerOffset: -10)
                  ],
                  annotations: [
                    GaugeAnnotation(widget: Text(widget.result.toStringAsFixed(2), style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                      angle: 90, positionFactor: 0.5)
                  ],
                )],
            )],
        ),
      ),
    );
  }
}
