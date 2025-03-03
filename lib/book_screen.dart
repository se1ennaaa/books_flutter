import 'package:books_flutter/book_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class BookScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookBloc()..add(FetchBooks()),
      child: Scaffold(
        appBar: AppBar(title: Text('Книги Гарри Поттера')),
        body: BlocBuilder<BookBloc, BookState>(
          builder: (context, state) {
            if (state is BookLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is BookLoaded) {
              return ListView.builder(
                itemCount: state.books.length,
                itemBuilder: (context, index) {
                  final book = state.books[index];
                  return Card(
                    child: ListTile(
                      leading: Image.network(book.image,
                          width: 50, height: 80, fit: BoxFit.cover),
                      title: Text(book.nickname),
                      subtitle: Text(
                          'Дата выпуска: ${book.birthdate}\nСтраниц: ${book.hogwartsHouse}'),
                      onTap: () => showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(book.nickname),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.network(
                                book.image,
                                height: 150,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text('Дата выпуска: ${book.birthdate}'),
                              Text('Домм: ${book.hogwartsHouse}')
                            ],
                          ),
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
              );
            } else {
              return Center(child: Text('Ошибка загрузки данных'));
            }
          },
        ),
      ),
    );
  }
}
