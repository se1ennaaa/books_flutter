

import 'package:books_flutter/model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class BookScreen extends StatefulWidget {
  @override
  _BookScreen createState() => _BookScreen();
}

class _BookScreen extends State<BookScreen> {
  final Dio _dio = Dio();
  final String baseUrl = 'https://potterapi-fedeperin.vercel.app';
  
  List<Model> books = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  Future<void> fetchBooks() async {
    try {
      final response = await _dio.get('$baseUrl/en/books');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        setState(() {
          books = data.map((json) => Model.fromJson(json)).toList();
          isLoading = false;
        });
      }
    } catch (e) {
      print('Ошибка при получении данных: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Книги Гарри Поттера')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                return Card(
                  child: ListTile(
                    leading: Image.network(book.cover, width: 50, height: 80, fit: BoxFit.cover),
                    title: Text(book.title),
                    subtitle: Text('Дата выпуска: ${book.releaseDate}\nСтраниц: ${book.pages}'),
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(book.title),
                        content: Text(book.description),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('Закрыть'),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}