import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wes_report/common/constants.dart';
import 'package:wes_report/screens/location_screen.dart';
import 'package:wes_report/services/location.dart';
import 'package:wes_report/services/networking.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Future<dynamic>? _locationFuture;
  // Future<dynamic>? _weatherData;

  @override
  void initState() {
    super.initState();
    _locationFuture = getLocation();
  }

  Future<dynamic> getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    Networking networking = Networking(
      url:
          'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric',
    );

    return await networking.getData();

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) {
    //       return LocationScreen(
    //         locationWeather: _weatherData,
    //       );
    //     },
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _locationFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return LocationScreen(locationWeather: snapshot.data);
            } else {
              return const Center(
                child: Text('Error: Unable to get location data.'),
              );
            }
          } else {
            return const Center(
              child: SpinKitDoubleBounce(
                size: 100.0,
                color: Colors.white,
              ),
            );
          }
        },
      ),
    );
  }
}
