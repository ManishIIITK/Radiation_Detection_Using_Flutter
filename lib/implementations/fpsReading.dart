import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../backend/calculation.dart';

class fpsReading extends StatefulWidget {
  const fpsReading({Key? key}) : super(key: key);

  @override
  _fpsReadingState createState() => _fpsReadingState();
}

class _fpsReadingState extends State<fpsReading> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<calculate>(
          builder: (context, model, child) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Radio(
                value: 1,
                groupValue: model.groupvalue,
                onChanged: (dynamic value) => model.setUpdateInterval(
                    1, Duration.microsecondsPerSecond ~/ 1),
              ),
              Text("1 FPS"),
              Radio(
                value: 2,
                groupValue: model.groupvalue,
                onChanged: (dynamic value) => model.setUpdateInterval(
                    2, Duration.microsecondsPerSecond ~/ 30),
              ),
              Text("30 FPS"),
            ],
          ),
        ),
      ],
    );
  }
}