import 'dart:convert';
import 'package:clima/Model/weatherModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Api.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../Model/NewsModel.dart';



class WeatherDataProvider extends ChangeNotifier{

  WeatherModel? _weatherModel;
  WeatherModel? get weatherModel => _weatherModel;
  String? location;
  bool isCompleted = false;


  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Location services are disabled.');
      return;
    }

    // Check and request location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permission denied.');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print('Location permission permanently denied.');
      return;
    }

    // Now get the location (after permissions are OK)
    Position position = await Geolocator.getCurrentPosition(locationSettings: LocationSettings(accuracy: LocationAccuracy.medium)
    );

    print('Latitude: ${position.latitude}, Longitude: ${position.longitude}');
    getPlaceName(position.latitude, position.longitude);
  }





  Future<void> getPlaceName(double latitude, double longitude) async {

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[1]; // safe access
        String? cityName = place.locality;
        if (cityName != null && cityName.isNotEmpty) {
          await fetchWeather(cityName); // make sure to await this
          location = cityName;
          isCompleted=true;
          notifyListeners();
        } else {
          print('City name is null or empty');
        }
      } else {
        print('No placemark data found');
      }

    } catch (e) {
      print('Error occurred while getting place name: $e');
    }
    print(location);
    return null;
  }




  Future<WeatherModel?> fetchWeather(String city) async{
   final url = Uri.parse('http://api.weatherapi.com/v1/current.json?key=$weatherAPI&q=$city&aqi=yes');
   try{
     final response = await http.get(url);
     if(response.statusCode == 200)
       {
         final jsonData = jsonDecode(response.body);
         _weatherModel= WeatherModel.fromJson(jsonData);
         notifyListeners();
       }
     else{
       print('Failed to load weather: ${response.statusCode}');
     }
   }
   catch(e){
     print(e);
   }
   return null;
  }


}