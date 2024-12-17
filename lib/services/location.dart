import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Location {
  double? latitude;
  double? longitude;

  Location({
    this.latitude,
    this.longitude,
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
      longitude = position.longitude;
    } catch (e) {
      debugPrint('Error: $e');
    }
  }
}
