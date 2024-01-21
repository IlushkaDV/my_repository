import 'dart:convert';
import 'package:http/http.dart' as http;
import 'news_model.dart';

class NewsService {
  final String apiKey = 'b5e41fddb74847a2b88b24f229c75462';

  Future<List<News>> getNews() async {
    try {
      final response = await http.get(
        Uri.parse('https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey'),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        List<News> newsList = [];

        for (var item in jsonData['articles']) {
          News news = News.fromJson(item);
          newsList.add(news);
        }

        return newsList;
      } else {
        throw Exception('Failed to load news');
      }
    } catch (error) {
      print('Error during HTTP request: $error');
      throw Exception('Failed to load news');
    }
  }
}
