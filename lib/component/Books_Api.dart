import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:maktabati2/Models/M_View_Book.dart';
import 'package:maktabati2/const/linkapi.dart';


import '../Models/M_Sarch_Book.dart';



class BooksApi {
  static Future<List<Book>> getBooks(String query) async {
    final url = Uri.parse(linkView_book);
    final response = await http.get(url);

    if (response.statusCode == 200) {
       List books = json.decode(response.body);

      return books.map((json) => Book.fromJson(json)).where((book) {
        final titleLower = book.title.toLowerCase();
        final authorLower = book.author.toLowerCase();
        final searchLower = query.toLowerCase();
        return titleLower.contains(searchLower) ||
            authorLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}
