import 'package:clima/Api.dart';
import 'package:clima/Model/NewsModel.dart';
import 'package:clima/Provider/newsProvider.dart';
import 'package:clima/Provider/weatherDataProvider.dart';
import 'package:clima/Screen/Components/BottomBar.dart';
import 'package:clima/Screen/Components/NewsCard.dart';
import 'package:clima/Screen/Components/middleCard.dart';
import 'package:clima/Screen/Components/topCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isMiddleCard = true;
  final PageController pageController = PageController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final locationProvider = Provider.of<WeatherDataProvider>(context, listen: false);
      final newsProvider = Provider.of<NewsProvider>(context, listen: false);

      await locationProvider.getCurrentLocation();
      if (locationProvider.location != null) {
        print('Calling fetchNews with city: ${locationProvider.location}');
        await newsProvider.fetchNews(locationProvider.location!);
      } else {
        print("City name not available.");
      }
    });
  }




  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TopCard(isDetail: isMiddleCard,),
                SizedBox(
                  height: isMiddleCard? height*0.35:height*0.65,
                  child: PageView(
                    controller:pageController,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (value){
                      if(value==1)
                        {
                          setState(() {

                            isMiddleCard=false;
                          });
                        }
                      else
                        {
                          setState(() {
                            isMiddleCard=true;
                          });
                        }
                    },
                    children: [
                      MiddleCard(),
                      NewsCard()

                    ],
                  ),
                ),

                SizedBox(
                  width: 30,
                  height: 10,
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                      CircleAvatar(radius: 5,backgroundColor: isMiddleCard?Colors.black:Colors.grey[300],),
                      CircleAvatar(radius: 5,backgroundColor:isMiddleCard?Colors.grey[300]:Colors.black,)
                    ]),
                  ),
                ),
                isMiddleCard?BottomBar(isDetailCard: isMiddleCard,):SizedBox.shrink(),
            ]
            ),
          ),
        ),
      ));
  }

}
