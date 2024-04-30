import 'dart:convert';
import 'package:http/http.dart' as http;

String fetchBooksURL =
    'https://raw.githubusercontent.com/Richa0305/mock-json/main/book.json';

Future<List<BooksListModel>> fetchBooks(http.Client client) async {
  final response = await client.get(Uri.parse(fetchBooksURL)); // Call API

  if (response.statusCode == 200) {
    return List<BooksListModel>.from(
        json.decode(response.body).map((x) => BooksListModel.fromJson(x)));
  } else {
    throw Exception('Failed to load album');
  }
}

class BooksListModel {
  BooksListModel({
    required this.name,
    required this.author,
     this.decription,
     this.amazon,
  });

  String name;
  String author;
  String? decription;
  String? amazon;

  factory BooksListModel.fromJson(Map<String, dynamic> json) => BooksListModel(
        name: json["name"],
        author: json["auther"],
        decription: json["decription"],
        amazon: json["amazon"],
      );
}
