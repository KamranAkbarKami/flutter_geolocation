import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
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
  double longitude = 0.0;
  double latitude = 0.0;
  String address = "Your Address";

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
      setState(() {
        longitude = currentPosition.longitude;
        latitude = currentPosition.latitude;
      });
      log("Longitude: ${currentPosition.longitude}");
      log("Latitude: ${currentPosition.latitude}");
      getAddress(lat: latitude, long: longitude);
    }
  }

  //For convert lat long to address
  getAddress({required double lat, required double long}) async {
    List<Placemark> placeMark = await placemarkFromCoordinates(lat, long);
    setState(() {
      address =
          "${placeMark[0].postalCode} ${placeMark[0].subLocality!} ${placeMark[0].country!}";
    });

    for (int i = 0; i < placeMark.length; i++) {
      log("INDEX $i ${placeMark[i]}");
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
                child: const Text(
                  "Please Find Longitude and Latitude",
                  style: buttonTextStyle,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Latitude is: ${latitude.toString()}",
                textAlign: TextAlign.center,
                style: customTextStyle,
              ),
              const SizedBox(
                height: 20,
              ),
              Text("Longitude is: ${longitude.toString()}",
                  textAlign: TextAlign.center, style: customTextStyle),
              const SizedBox(
                height: 20,
              ),
              Text("Address is: ${address.toString()}",
                  textAlign: TextAlign.center, style: customTextStyle),
            ],
          ),
        ),
      ),
    );
  }
}

const TextStyle customTextStyle =
    TextStyle(fontSize: 18, fontWeight: FontWeight.w500);
const TextStyle buttonTextStyle =
    TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white);
