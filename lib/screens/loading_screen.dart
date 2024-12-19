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
  late Future<void> _locationFuture;
  Future<dynamic> _weatherData = Future.value(null);

  @override
  void initState() {
    super.initState();
    _locationFuture = getLocation();
  }

  Future<void> getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    Networking networking = Networking(
      url:
          'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric',
    );

    _weatherData = await networking.getData();

    debugPrint('Weather data: $_weatherData');
    debugPrint(_weatherData.toString());

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) {
    //       return LocationScreen(
    //         locationWeather: weatherData,
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
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LocationScreen(
              locationWeather: _weatherData,
            );
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
