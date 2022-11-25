import 'package:flutter/material.dart';
import 'package:project_final/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../implementations/textStyle.dart';
import '../implementations/xyzReading.dart';
import '../backend/calculation.dart';

class graph extends StatefulWidget {
  const graph({Key? key}) : super(key: key);

  @override
  _graphState createState() => _graphState();
}

class _graphState extends State<graph> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.blue,
        centerTitle: true,
        title: Container(
          child: textWidget("Graph Visuals"),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: const xyzReading(),
              ),
              SizedBox(
                height: 100,
              ),
              Container(
                margin: EdgeInsets.all(5),
                child: Card(
                  color: Colors.grey.shade800,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Consumer<calculate>(
                    builder: (context, model, child) => SfCartesianChart(
                        title: ChartTitle(text: 'X,Y,Z with Time'),
                        legend: Legend(
                          isVisible: true,
                          title: LegendTitle(text: 'Legend'),
                        ),
                        series: <LineSeries<LiveData, int>>[
                          //x axis
                          LineSeries<LiveData, int>(
                            legendItemText: 'X',
                            onRendererCreated:
                                (ChartSeriesController controller) {},
                            dataSource: model.values,
                            color: Colors.red,
                            xValueMapper: (LiveData value, _) => value.time,
                            yValueMapper: (LiveData value, _) => value.x,
                          ),
                          //y axis
                          LineSeries<LiveData, int>(
                            legendItemText: 'Y',
                            onRendererCreated:
                                (ChartSeriesController controller) {},
                            dataSource: model.values,
                            color: Colors.blue,
                            xValueMapper: (LiveData value, _) => value.time,
                            yValueMapper: (LiveData value, _) => value.y,
                          ),
                          //z axis
                          LineSeries<LiveData, int>(
                            legendItemText: 'Z',
                            onRendererCreated:
                                (ChartSeriesController controller) {},
                            dataSource: model.values,
                            color: Colors.green,
                            xValueMapper: (LiveData value, _) => value.time,
                            yValueMapper: (LiveData value, _) => value.z,
                          ),
                        ],
                        primaryXAxis: NumericAxis(
                            isVisible: false,
                            majorGridLines: const MajorGridLines(width: 0),
                            edgeLabelPlacement: EdgeLabelPlacement.shift,
                            interval: 3,
                            title: AxisTitle(text: 'Time(s)')),
                        primaryYAxis: NumericAxis(
                            axisLine: const AxisLine(width: 0),
                            majorTickLines: const MajorTickLines(size: 0),
                            title: AxisTitle(text: 'uTesla'))),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
