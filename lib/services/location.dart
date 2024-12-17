import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wes_report/services/networking.dart';

class Location {
  double? latitude;
  double? longitude;

  Location({
    this.latitude,
    this.longitude,
  });

  Future<void> getCurrentLocationData(String apiKey) async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(
          accuracy: LocationAccuracy.lowest,
          distanceFilter: 10,
        ),
      );

      latitude = position.latitude;
      longitude = position.longitude;

      Networking networking = Networking(
        url:
            'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric',
      );

      var weatherData = await networking.getData();
    } catch (e) {
      debugPrint('Error: $e');
    }
  }
}
