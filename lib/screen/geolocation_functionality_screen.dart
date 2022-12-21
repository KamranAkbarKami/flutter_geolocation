import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class GeolocationFunctionalityScreen extends StatefulWidget {
  const GeolocationFunctionalityScreen({Key? key}) : super(key: key);

  @override
  State<GeolocationFunctionalityScreen> createState() =>
      _GeolocationFunctionalityScreenState();
}

class _GeolocationFunctionalityScreenState
    extends State<GeolocationFunctionalityScreen> {
  // Function for Getting Latitude and Longitude using Geo locator Plugin
  void getCurrentPosition() async {
    //Permission
    LocationPermission permission = await Geolocator.checkPermission();
    //If permission is not Granted
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      log("Permission not Given");
      //Ask for Permission
      LocationPermission asked = await Geolocator.requestPermission();
    }
    // If permission is Granted
    else {
      //Get Current Position with Location Accuracy from best to low
      Position currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      log("Longitude: ${currentPosition.longitude}");
      log("Latitude: ${currentPosition.latitude}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Geolocation Latitude and Longitude",
          style: TextStyle(fontSize: 15),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          height: context.height * 1,
          width: context.width * 1,
          child: ListView(
            shrinkWrap: true,
            children: [
              ElevatedButton(
                onPressed: () {
                  getCurrentPosition();
                },
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(context.width * 0.8, 60)),
                child: const Text("Please Find Longitude and Latitude"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
