import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Location {
  double? latitude;
  double? longtitude;

  Location({
    this.latitude,
    this.longtitude,
  });

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(
          accuracy: LocationAccuracy.lowest,
          distanceFilter: 10,
        ),
      );

      latitude = position.latitude;
      longtitude = position.longitude;
    } catch (e) {
      debugPrint('Error: $e');
    }
  }
}
