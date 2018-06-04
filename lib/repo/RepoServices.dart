import 'dart:async';
import 'package:http/http.dart' as http;

class RepoServices {
  Future<http.Response> loadData(String username) {
    final String url = 'https://api.github.com/users/${username}/repos';
    return http.get(url);
  }
}

class Repository {
  int id;
  String name;
  String description;
  int size;
  String language;

  Repository({this.id, this.name, this.description, this.size, this.language});

  factory Repository.fromJson(Map<String, dynamic> json) {
    return new Repository(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        size: json['size'],
        language: json['language']);
  }
}
