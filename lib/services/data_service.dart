import 'package:bookref/Models/book.dart';
import 'package:bookref/Models/bookResult.dart';
import 'package:bookref/Models/dashboardBooks.dart';
import 'package:bookref/Models/recommendedBook.dart';
import 'package:bookref/Models/recommendedPerson.dart';
import 'package:bookref/Models/testbook.dart';
import 'package:bookref/repositories/repositories.dart';
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

    return DashboardBooks(convertBookQueryToList(currents),
        convertBookQueryToList(wishlist), convertBookQueryToList(libraries));
  }

  Future<List<Book>> getCurrentBooks() async {
    final currents = await _bookrefRepository.getDashboardCurrents();

    return convertBookQueryToList(currents);
  }

  Future<List<Book>> getWishlistBooks() async {
    final wishlist = await _bookrefRepository.getDashboardWishlist();

    return convertBookQueryToList(wishlist);
  }

  Future<List<Book>> getLibraryBooks() async {
    final library = await _bookrefRepository.getDashboardLibary();

    return convertBookQueryToList(library);
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

  Future<DetailsBook> getFullBookById(String bookId) async {
    final book = await _bookrefRepository.getFullBookById(bookId);

    return DetailsBook(book.data['bookById']);
  }

  Future<List<RecommendedPerson>> getPeopleRecommendationsForBook(
      String bookId) async {
    final personrec =
        await _bookrefRepository.getPeopleRecommendationsForBook(bookId);

    return convertRecommendedPersonQueryToList(personrec);
  }

  Future<List<RecommendedBook>> getBookRecommendationsForBook(
      String bookId) async {
    final bookrec =
        await _bookrefRepository.getBookRecommendationsForBook(bookId);

    print(bookrec.data.toString());

    return convertRecommendedBookQueryToList(bookrec);
  }

  Future addPersonRecommendation(
      String bookId, String personName, String notes) async {
    QueryResult person = await _bookrefRepository.checkPersonName(personName);

    if (await extractPersonsId(person) == null) {
      person = await _bookrefRepository.addPerson(personName);

      final result = await _bookrefRepository.addPersonRecommendation(
          bookId, await person.data['addPerson']['data']['id'], personName);
    } else {
      final result = await _bookrefRepository.addPersonRecommendation(
          bookId, await extractPersonsId(person), personName);
    }
  }

  Future addBookRecommendation(
      String bookId, String identifier, String title, String notes) async {
    QueryResult book = await _bookrefRepository.getBookByTitle(title);

    if (await extractExternalBookId(book) == null) {
      book = await _bookrefRepository.addBook(identifier, title, "Placeholder");

      final result = _bookrefRepository.addBookRecommendation(
          bookId, book.data['addBook']['data']['id'], notes);
    } else {
      final result = _bookrefRepository.addBookRecommendation(
          bookId, await extractExternalBookId(book), notes);
    }
  }

  List<Book> convertBookQueryToList(QueryResult queryResult) {
    var listBooks = List<Book>();

    for (var i = 0; i < queryResult.data["books"].length; i++) {
      listBooks.add(
        Book(queryResult.data["books"][i]),
      );
    }

    return listBooks;
  }

  List<RecommendedBook> convertRecommendedBookQueryToList(
      QueryResult queryResult) {
    var listBooks = List<RecommendedBook>();

    for (var i = 0;
        i < queryResult.data["bookRecommendationsForBook"].length;
        i++) {
      listBooks.add(
        RecommendedBook(queryResult.data["bookRecommendationsForBook"][i]),
      );
    }

    return listBooks;
  }

  List<RecommendedPerson> convertRecommendedPersonQueryToList(
      QueryResult queryResult) {
    var listBooks = List<RecommendedPerson>();

    for (var i = 0;
        i < queryResult.data["peopleRecommendationsForBook"].length;
        i++) {
      listBooks.add(
        RecommendedPerson(queryResult.data["peopleRecommendationsForBook"][i]),
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

  extractPersonsId(QueryResult queryResult) async {
    try {
      return queryResult.data['people'][0]['id'];
    } catch (e) {
      return null;
    }
  }

  extractExternalBookId(QueryResult queryResult) async {
    try {
      return queryResult.data['allBooks']['edges'][0]['node']['id'];
    } catch (e) {
      return null;
    }
  }
}
