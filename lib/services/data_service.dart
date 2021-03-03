import 'package:flutter_bloc_authentication/models/book.dart';
import 'package:flutter_bloc_authentication/models/bookResult.dart';
import 'package:flutter_bloc_authentication/models/dashboardBooks.dart';
import 'package:flutter_bloc_authentication/repositories/bookref_repository.dart';
import 'package:flutter_bloc_authentication/repositories/user_repository.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'dart:async';
import 'package:graphql/client.dart';

class DataService {
  BookrefRepository _bookrefRepository;
  UserRepository _userRepository;

  DataService() {
    _bookrefRepository = BookrefRepository();
    _userRepository = UserRepository();
  }

  Future<DashboardBooks> getDashboardBooks() async {
    final currents = await _bookrefRepository.getDashboardCurrents();
    final wishlist = await _bookrefRepository.getDashboardWishlist();
    final libraries = await _bookrefRepository.getDashboardLibary();

    return DashboardBooks(convertQueryToList(currents),
        convertQueryToList(wishlist), convertQueryToList(libraries));
  }

  Future<List<Book>> getCurrentBooks() async {
    final currents = await _bookrefRepository.getDashboardCurrents();

    return convertQueryToList(currents);
  }

  Future<List<Book>> getWishlistBooks() async {
    final wishlist = await _bookrefRepository.getDashboardWishlist();

    return convertQueryToList(wishlist);
  }

  Future<List<Book>> getLibraryBooks() async {
    final library = await _bookrefRepository.getDashboardLibary();

    return convertQueryToList(library);
  }

  Future<BookResult> addBook(
      String identifier, String title, String subtitle) async {
    final result =
        await _bookrefRepository.addBook(identifier, title, subtitle);

    return BookResult(result.data['addBook']);
  }

  Future<void> moveBookInLibrary(String bookId, String statusdata) async {
    await _bookrefRepository.moveBookInLibrary(bookId, statusdata);
  }

  Future<dynamic> checkAuthorName(String author) async {
    final result = await _bookrefRepository.checkAuthorName(author);

    return extractAuthorsName(result);
  }

  Future<void> addAuthor(String bookId, String authorId) async {
    await _bookrefRepository.addAuthor(bookId, authorId);
  }

  Future<void> addNewAuthor(String bookId, String authorName) async {
    await _bookrefRepository.addNewAuthor(bookId, authorName);
  }

  Future<dynamic> changeBookStatus(
      String personalBookId, String newStatus) async {
    return await _bookrefRepository.changeBookStatus(personalBookId, newStatus);
  }

  Future<Book> getFullBookById(String bookId) async {
    final book = await _bookrefRepository.getFullBookById(bookId);

    return Book(book.data['bookById']);
  }

  Future<dynamic> getPeopleRecommendationsForBook(String bookId) async {
    final rec =
        await _bookrefRepository.getPeopleRecommendationsForBook(bookId);

    return rec.data['peopleRecommendationsForBook'];
  }

  Future<dynamic> getBookRecommendationsForBook(String bookId) async {
    final rec = await _bookrefRepository.getBookRecommendationsForBook(bookId);

    return rec.data['bookRecommendationsForBook'];
  }

  List<Book> convertQueryToList(QueryResult queryResult) {
    var listBooks = List<Book>();

    for (var i = 0; i < queryResult.data["books"].length; i++) {
      listBooks.add(
        Book(queryResult.data["books"][i]),
      );
    }

    return listBooks;
  }

  extractAuthorsName(QueryResult queryResult) async {
    try {
      return queryResult.data['authors'][0];
    } catch (e) {
      return null;
    }
  }
}
