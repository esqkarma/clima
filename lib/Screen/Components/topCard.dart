import 'package:clima/Model/weatherModel.dart';
import 'package:clima/Provider/weatherDataProvider.dart';
import 'package:clima/Screen/Components/maps.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopCard extends StatelessWidget {
  bool isDetail;
  TopCard({required this.isDetail, super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final weatherDataProvider = Provider.of<WeatherDataProvider>(context);
    final WeatherModel? data = weatherDataProvider.weatherModel;
    // round off temperature value
    String? temp = data?.temperature.round().toString();
    String? condi = data?.weatherCondition.trim().toLowerCase();

    return Center(
      child: AnimatedContainer(
        height: isDetail ? height * 0.42 : height * 0.22,
        width: width * 0.92,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.black54,
        ),
        duration: Duration(milliseconds: 600),
        curve: Curves.easeInOutSine,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: isDetail ? height * 0.20 : height * 0.11,
                width: width * 0.8188,
                child: Image.asset(
                  iconsPath[condi] ?? 'assets/weatherCondition/rocket.png',
                  filterQuality: FilterQuality.high,
                ),
              ),
              SizedBox(
                height: isDetail ? height * 0.13 : height * 0.065,
                width: width * 0.50,
                child: Center(
                  child: Text(
                    temp != null ? '${temp}\u00B0C' : 'N/A',
                    style: TextStyle(fontSize: isDetail ? 70 : 30, color: Colors.white),
                  ),
                ),
              ),
              Text(data?.weatherCondition ?? 'N/A', style: TextStyle(color: Colors.grey[400])),
            ],
          ),
        ),
      )

    );
  }
}
