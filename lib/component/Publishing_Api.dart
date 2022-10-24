import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:maktabati2/Models/M_View_Book.dart';
import 'package:maktabati2/const/linkapi.dart';


import '../Models/M_Sarch_Book.dart';
import '../Models/M_Sarch_Publishing.dart';



class Publishing_Api {
  static Future<List<Publishing>> getBooks(String query) async {
    final url = Uri.parse(linkView_publishe);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List books = json.decode(response.body);

      return books.map((json) => Publishing.fromJson(json)).where((book) {
        final titleLower = book.name.toLowerCase();
        final authorLower = book.owner.toLowerCase();
        final searchLower = query.toLowerCase();
        return titleLower.contains(searchLower) ||
            authorLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}
