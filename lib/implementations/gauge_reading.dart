// import 'package:project_final/models/calculate.dart';
import 'package:project_final/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../backend/calculation.dart';

class Gauge extends StatefulWidget {
  const Gauge({Key? key}) : super(key: key);

  @override
  _GaugeState createState() => _GaugeState();
}

class _GaugeState extends State<Gauge> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Consumer<calculate>(
          builder: (context, model, child) => SfRadialGauge(
            axes: <RadialAxis>[
              RadialAxis(
                interval: 50,
                minimum: 0,
                maximum: 450,
                labelOffset: 20,
                tickOffset: 22,
                majorTickStyle: MajorTickStyle(
                    length: 0.09,
                    lengthUnit: GaugeSizeUnit.factor,
                    thickness: 2),
                minorTicksPerInterval: 4,
                minorTickStyle: MinorTickStyle(
                    length: 0.04,
                    lengthUnit: GaugeSizeUnit.factor,
                    thickness: 1),
                ranges: <GaugeRange>[
                  GaugeRange(
                    startValue: 0,
                    endValue: 150,
                    color: AppColors.green,
                    label: 'SAFE',
                    startWidth: 7,
                    endWidth: 30,
                    labelStyle: GaugeTextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  GaugeRange(
                    startValue: 150,
                    endValue: 300,
                    color: AppColors.orange,
                    label: 'MODERATE',
                    startWidth: 7,
                    endWidth: 30,
                    labelStyle: GaugeTextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  GaugeRange(
                    startValue: 300,
                    endValue: 450,
                    color: AppColors.red,
                    label: 'DANGER',
                    startWidth: 7,
                    endWidth: 30,
                    labelStyle: GaugeTextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )
                ],
                pointers: <GaugePointer>[
                  NeedlePointer(
                    value: model.final_value,
                    lengthUnit: GaugeSizeUnit.factor,
                    needleLength: 0.6,
                    needleColor: AppColors.red,
                    needleStartWidth: 1,
                    needleEndWidth: 7,
                    tailStyle: TailStyle(
                      length: 0.2,
                      width: 9,
                      gradient: LinearGradient(
                        colors: <Color>[
                          Color(0xFFFF6B78),
                          Color(0xFFFF6B78),
                          Color(0xFFE20A22),
                          Color(0xFFE20A22)
                        ],
                        stops: <double>[0, 0.5, 0.5, 1],
                      ),
                    ),
                    gradient: LinearGradient(colors: [
                      Color(0xFFFF6B78),
                      Color(0xFFFF6B78),
                      Color(0xFFE20A22),
                      Color(0xFFE20A22)
                    ]),
                    knobStyle: KnobStyle(
                        sizeUnit: GaugeSizeUnit.factor,
                        knobRadius: 0.07,
                        color: Colors.white70),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
