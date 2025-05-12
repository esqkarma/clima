import 'package:clima/Screen/Components/CustomText.dart';
import 'package:clima/Screen/Components/maps.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../Model/weatherModel.dart';
import '../../Provider/weatherDataProvider.dart';

class MiddleCard extends StatelessWidget {
  const MiddleCard({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final weatherDataProvider = Provider.of<WeatherDataProvider>(context);
    final WeatherModel? data = weatherDataProvider.weatherModel;
    return Column(
      children: [
        SizedBox(
          height: height * 0.09,
          width: width * 0.92,

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: height * 0.072,
                width: width * 0.44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),

                  //giving .withAlpha make the color 12% transparent, (range: 0 to 255).
                  color: Color(0xffD9D9D9).withAlpha(50),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      'Details',
                      style: TextStyle(fontSize: 16, color: Color(0xff535151)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Text(
                  data?.date != null
                      ? formatedDate(data!.date) : 'N/A',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: height * 0.23,
          width: width * 0.90,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              customText('Location :  ${data?.location??'N/A'}' ' ,''${data?.country??'N/A'}'),
              customText('Longitude :  ${data?.longitude??' N/A'}'),
              customText('Latitude :  ${data?.latitude??' N/A'}'),
              customText('Air quality : ${airQuality[data?.airQuality]??'N/A'}'),
              customText('Wind speed : ${data?.windSpeed != null ? '${data!.windSpeed} kph' : 'N/A'}'),
            ],
          ),
        ),
      ],
    );
  }
  String formatedDate(String? date){
    DateTime dateTime = DateTime.parse(date!);
    String formatted = DateFormat('dd-MM hh:mm a').format(dateTime);
    return formatted;
  }

}
