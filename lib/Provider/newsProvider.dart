import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../Api.dart';
import '../Model/NewsModel.dart';

class NewsProvider extends ChangeNotifier {
  List<NewsModel> _articles = [];

  List<NewsModel> get articles => _articles;


  Future<void> fetchNews( String city) async {


    DateTime yesterday = DateTime.now().subtract(Duration(days: 15));
    String formatted = DateFormat('yyyy-MM-dd').format(yesterday);

    final url = Uri.parse(
      'https://newsapi.org/v2/everything?q=$city&from=$formatted&sortBy=publishedAt&apiKey=$newsAPI',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      List articlesJson = data['articles'];
      _articles = articlesJson.map((json) => NewsModel.fromJson(json)).toList();
      notifyListeners();
    } else {
      print('Failed to fetch news: ${response.statusCode}');
    }
  }
}
