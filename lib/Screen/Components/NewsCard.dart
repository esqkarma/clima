import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Model/NewsModel.dart';
import '../../Provider/newsProvider.dart';
import '../../Provider/weatherDataProvider.dart';

class NewsCard extends StatefulWidget {
  const NewsCard({super.key});

  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {

 bool isExpanded= false;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final newsProvider = Provider.of<NewsProvider>(context);
    final locationProvider = Provider.of<WeatherDataProvider>(context, listen: false);

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
                  color: Color(0xffD9D9D9).withAlpha(50),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      'News',
                      style: TextStyle(fontSize: 16, color: Color(0xff535151)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Text(""),
              ),
              IconButton(onPressed: (){
                print(locationProvider.location);
              newsProvider.fetchNews(locationProvider.location!);
              }, icon: Icon(Icons.refresh))
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 15, top: 10),
          child: Align(
            alignment: Alignment.topLeft,
              child: Text('Top Headlines', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25))),
        ),
        newsProvider.articles.isEmpty?Center(
          child: Text('refresh to get latest news')
        ):Expanded(
         child: ListView.builder(itemBuilder: (ctx,index){
           final NewsModel data = newsProvider.articles[index];
           return Padding(
             padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
             child: InkWell(
               onTap: (){
                 if(isExpanded){
                   setState(() {
                     isExpanded=false;
                   });
                 }
                 else{
                   setState(() {
                     isExpanded=true;
                   });
                 }
               },
               child: Container(
                 height:height*0.08,
                 width: width*80,
                 color: Colors.grey[50],
                 child: Center(
                   child: Text(data.title!,style: TextStyle(
                     fontSize: 18
                   ),),
                 ),
               ),
             ),
           );

         },itemCount:newsProvider.articles.length,),
       )
      ],
    );
  }
}
