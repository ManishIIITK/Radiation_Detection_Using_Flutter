import 'dart:math';
import 'package:flutter/material.dart';
import 'package:motion_sensors/motion_sensors.dart';
import 'package:vector_math/vector_math_64.dart';

class calculate extends ChangeNotifier {
  double x = 0;
  double y = 0;
  double z = 0;
  double final_value = 0;
  int time = 0;
  // This list will contain the data for visualization
  List<LiveData> values = [];

  // initially making all the vectors zero
  Vector3 magnetometer = Vector3.zero();
  Vector3 _accelerometer = Vector3.zero();
  Vector3 _absoluteOrientation2 = Vector3.zero();
  // initially the radio button will be at 1 FPS
  int? groupvalue = 1;

  // this function is for the sensor. when user taps on the start and stop button. this function runs accordingly.
  start_listening(bool isListening) {
    motionSensors.magnetometer.listen((MagnetometerEvent event) {
      if (isListening == false) {
        magnetometer.setValues(event.x, event.y, event.z);
        var matrix =
            motionSensors.getRotationMatrix(_accelerometer, magnetometer);
        _absoluteOrientation2.setFrom(motionSensors.getOrientation(matrix));
        x = magnetometer.x;
        y = magnetometer.y;
        z = magnetometer.z;

        /* the values which we are getting thorough x, y and z axis are already magnetic fields. We are just calculating the  magnitude of the vector in 3 dimensional*/
        final_value = sqrt(
          (pow(magnetometer.x, 2)) +
              (pow(magnetometer.y, 2)) +
              (pow(magnetometer.z, 2)),
        );

        values.add(LiveData(x, y, z, time++));
        if (values.length > 50) {
          values.removeAt(0);
        }
      } else {
        final_value = 0;
      }
      notifyListeners();
    });
  }

  // this will select the radio button for the FPS
  setUpdateInterval(int? groupValue, int interval) {
    motionSensors.magnetometerUpdateInterval = interval;
    groupvalue = groupValue;
    print(groupvalue);
    notifyListeners();
  }
}

// cosntructor for the Live Data

class LiveData {
  LiveData(this.x, this.y, this.z, this.time);
  final double x;
  final double y;
  final double z;
  final int time;
}
