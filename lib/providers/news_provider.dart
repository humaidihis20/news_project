import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/news_model.dart';

class NewsProvider with ChangeNotifier {
  // final List<NewsModel> _newsList = <NewsModel>[];
  List<NewsModel> _newsList = [];
  String _selectedCountry = 'us';
  String _selectedCategory = 'general';
  String _selectedChannel = '';

  List<NewsModel> get newsList => [..._newsList];

  String get selectedCountry => _selectedCountry;
  String get selectedCategory => _selectedCategory;
  String get selectedChannel => _selectedChannel;

  void updateFilters({String? country, String? category, String? channel}) {
    if (country != null) {
      _selectedCountry = country;
      // print(_selectedCountry);
    } else if (category != null){
      _selectedCategory = category;
    } else if (channel != null) {
      _selectedChannel = channel;
    } 
    notifyListeners();
  }

  Future<void> fetchNews() async {
    const apiKey = 'fb53fdeb53e647be9f6a8900cf910e61';
    String url =
        'https://newsapi.org/v2/top-headlines?apiKey=$apiKey';

    if (_selectedChannel.isNotEmpty) {
      url += '&sources=$_selectedChannel';
    } else {
      url += '&country=$_selectedCountry&category=$_selectedCategory';
    }

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
      // print(data);
        // List<NewsModel> loadedNews = [];
        // final List<dynamic> articles = data['articles'];  
        // print(articles);
        // List<NewsModel> loadedDatas = [];

        // for (var json in articles) {
        //   final currentData = NewsModel(
        //     source: json['source']['name'] ?? '',
        //     author: json['author'] ?? '',
        //     title: json['title'] ?? '',
        //     description: json['description'] ?? '',
        //     url: json['url'] ?? '',
        //     urlToImage: json['urlToImage'] ?? '',
        //     publishedAt: json['publishedAt'] ?? '',
        //     content: json['content'] ?? '',
        //   );
        //     // print(json);
        //   _newsList.add(currentData);
        //   // print(_newsList);
        // }
      
        final List<NewsModel> loadedNews = []; 
        for (var article in data['articles']) {
          loadedNews.add(NewsModel.fromJson(article));
        }
        _newsList = loadedNews;
  
        notifyListeners();
      } else {
        throw Exception('Failed to load news');
      }
    } catch (error) {
      throw error;
    }
  }
}
