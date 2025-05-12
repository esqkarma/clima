import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Provider/newsProvider.dart';
import '../../Provider/weatherDataProvider.dart';

// ignore: must_be_immutable
class CustomTextfield extends StatelessWidget {
  final String? hintText;
  final double? height;
  final double? width;
  final TextInputType? textInputType;
  final TextEditingController customController;
  final int? maxLength;
  VoidCallback? function;
  FocusNode? focusNode;

  CustomTextfield(
      {required this.customController,
      required this.hintText,
      this.height,
      this.width,
      this.textInputType,
      this.maxLength,
        this.function,
        this.focusNode,
      super.key});

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);
    final weatherDataProvider = Provider.of<WeatherDataProvider>(context);
    double wt = MediaQuery.of(context).size.width;
    return Container(
      // Adjust the height here
      width: width ?? wt * 0.70, // Adjust the width here
      decoration: BoxDecoration(
        // Border with dynamic size
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        maxLength: maxLength ?? 20,
        keyboardType:  textInputType??TextInputType.multiline,
        textInputAction: TextInputAction.send,
        showCursor: true,
        controller: customController,
       onSubmitted: (value)
        {

                weatherDataProvider.fetchWeather(value.trim());
                newsProvider.fetchNews(value.trim());
                customController.clear();
                FocusScope.of(context).unfocus();

        },

        onTapUpOutside: (_)=>FocusManager.instance.primaryFocus?.unfocus(),

        decoration: InputDecoration(
          hintFadeDuration: Duration(milliseconds: 250),
          hintMaxLines: 1,

          hintStyle: TextStyle(
            fontFamily: 'Cagody',
                letterSpacing: 1,
                color: Colors.grey[400]
          ),
          hintText: hintText,
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          border: InputBorder.none,
          //used to remove the limit show in text field
          counterText: ''
          // Remove default border
        ),
      ),
    );
  }
}
