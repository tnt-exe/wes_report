import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Networking {
  final String url;

  Networking({required this.url});

  Future getData() async {
    final dio = Dio();
    final response = await dio.get(url);

    if (response.statusCode == 200) {
      String data = response.data.toString();

      return data;
    } else {
      debugPrint('Error: ${response.statusCode}');
    }
  }
}
