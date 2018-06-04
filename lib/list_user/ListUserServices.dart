import 'dart:async';
import 'package:http/http.dart' as http;

class ListUserServices {
  Future<http.Response> loadData(String username) {
    String url = 'https://api.github.com/search/users?q=$username';
    return http.get(url);
  }
}

class User {
  String login;
  int id;
  String avatarUrl;
  double score;

  User({this.login, this.id, this.avatarUrl, this.score});

  factory User.fromJson(Map<String, dynamic> json) {
    return new User(login: json['login'], id: json['id'], avatarUrl: json['avatar_url'], score: json['score']);
  }
}
