import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:my_super_cat_app/models/cat.dart';

class CatsService {
  final String baseUrl = 'https://api.thecatapi.com/v1/breeds/';
  final String randomCatImgUrl = 'https://api.thecatapi.com/v1/images/search';

  Future<List<Cat>> getCats() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(response.body) as List;
      return jsonResponse.map((cat) => Cat.fromJson(cat)).toList();
    }
    return [];
  }

  Future<String> getRandomCatImg() async {
    final response = await http.get(Uri.parse(randomCatImgUrl));

    if (response.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(response.body);
      return jsonResponse[0]['url'];
    }
    return '';
  }
}
