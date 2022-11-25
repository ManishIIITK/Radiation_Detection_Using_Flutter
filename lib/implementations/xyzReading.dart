import 'package:flutter/material.dart';
import 'package:project_final/implementations/textStyle.dart';
import 'package:provider/provider.dart';
import '../backend/calculation.dart';

class xyzReading extends StatefulWidget {
  const xyzReading({super.key});

  @override
  State<xyzReading> createState() => _xyzReadingState();
}

class _xyzReadingState extends State<xyzReading> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30),
        Center(
          child: Consumer<calculate>(
            builder: (context, model, child) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                /*These text widget are for showing the individual reading of the magnetometer in x ,y and z direction in the visualization page*/
                textWidget('x: ${model.x.toStringAsFixed(2)}'),
                textWidget('y: ${model.y.toStringAsFixed(2)}'),
                textWidget('z: ${model.z.toStringAsFixed(2)}'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
