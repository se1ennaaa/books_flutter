import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:books_flutter/book_event.dart';
import 'package:books_flutter/model.dart';

abstract class BookEvent {}
class FetchBooks extends BookEvent {}

abstract class BookState {}
class BookLoading extends BookState {}
class BookLoaded extends BookState {
  final List<Model> books;
  BookLoaded(this.books);
}
class BookError extends BookState {}

class BookBloc extends Bloc<BookEvent, BookState> {
  final Dio _dio = Dio();
  final String baseUrl = 'https://potterapi-fedeperin.vercel.app';

  BookBloc() : super(BookLoading()) {
    on<FetchBooks>((event, emit) async {
      try {
        final response = await _dio.get('$baseUrl/en/characters');
        if (response.statusCode == 200) {
          List<Model> books = (response.data as List)
              .map((json) => Model.fromJson(json))
              .toList();
          emit(BookLoaded(books));
        } else {
          emit(BookError());
        }
      } catch (e) {
        emit(BookError());
      }
    });
  }
}
