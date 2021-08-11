import 'package:bookref/models/book.dart';
import 'package:bookref/models/dashboardBooks.dart';
import 'package:bookref/models/recommendedBook.dart';
import 'package:bookref/models/recommendedPerson.dart';
import 'package:bookref/models/detailsBook.dart';
import 'package:bookref/models/bookResult.dart';
import 'package:bookref/repositories/repositories.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'dart:async';
import 'package:graphql/client.dart';
import 'package:hive/hive.dart';

class DataService {
  BookrefRepository _bookrefRepository;
  UserRepository _userRepository;

  DataService() {
    _bookrefRepository = BookrefRepository();
    _userRepository = UserRepository();
  }

//   Future<String> get _localPath async {
//   final directory = await getApplicationDocumentsDirectory();

//   return directory.path;
// }

  Future<DashboardBooks> getDashboardBooks() async {
    final currents = await _bookrefRepository.getDashboardCurrents();
    final wishlist = await _bookrefRepository.getDashboardWishlist();
    final libraries = await _bookrefRepository.getDashboardLibary();

    var box = await Hive.openBox("data");

    box.put(
        'currents',
        DashboardBooks(
            convertBookQueryToList(currents),
            convertBookQueryToList(wishlist),
            convertBookQueryToList(libraries)));

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

  Future<BookResult> addBookByIsbn(String isbn) async {
    final result = await _bookrefRepository.addBookByIsbn(isbn);

    print("Result: " + result.data.toString());
    return BookResult(result.data['addBookByIsbn']);
  }

  Future<void> moveBookInLibrary(String bookId, String statusdata) async {
    await _bookrefRepository.moveBookInLibrary(bookId, statusdata);
  }

  Future<void> removeBook(String personalBookId) async {
    await _bookrefRepository.removeBook(personalBookId);
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

  FutureOr<Iterable<DetailsBook>> getBooksByName(String bookName) async {
    final books = await _bookrefRepository.getBooksByName(bookName);

    var nn = books.data.toString();

    var res = await convertBookSerToList(books);

    return res;
  }

  Future<dynamic> findBookByIsbn(String isbn) async {
    final books = await _bookrefRepository.findBookByIsbn(isbn);

    return books.data['allBooks']['nodes'][0]['id'];
  }

  Future<List<RecommendedPerson>> getPeopleRecommendationsForBook(
      String bookId) async {
    final personrec =
        await _bookrefRepository.getPeopleRecommendationsForBook(bookId);

    print(personrec.data.toString());

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
          bookId, await person.data['addPerson']['data']['id'], notes);
    } else {
      final result = await _bookrefRepository.addPersonRecommendation(
          bookId, await extractPersonsId(person), notes);
    }
  }

  Future addBookRecommendation(
      String bookId,
      String recBookId,
      String identifier,
      String title,
      String subtitle,
      String author,
      String notes) async {
    if (recBookId != null) {
      final result =
          _bookrefRepository.addBookRecommendation(bookId, recBookId, notes);
    } else {
      QueryResult book = await _bookrefRepository.getBookByTitle(title);

      if (await extractExternalBookId(book) == null) {
        final addBookResult = await addBook(identifier, title, subtitle);

        final authorResult = await checkAuthorName(author);

        if (authorResult != null) {
          // Setze Referenz zu bestehendem Autor
          await addAuthor(addBookResult.getBookDataId(), authorResult['id']);
        } else {
          // Erstelle neuen Autor mit Referenz
          await addNewAuthor(addBookResult.getBookDataId(), authorResult);
        }

        final result = _bookrefRepository.addBookRecommendation(
            bookId, addBookResult.getBookDataId(), notes);
      } else {
        final result = _bookrefRepository.addBookRecommendation(
            bookId, await extractExternalBookId(book), notes);
      }
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

  Future<List<DetailsBook>> convertBookSerToList(
      QueryResult queryResult) async {
    try {
      var listBooks = List<DetailsBook>();

      for (var i = 0; i < queryResult.data['allBooks']['nodes'].length; i++) {
        listBooks.add(DetailsBook(queryResult.data['allBooks']['nodes'][i]));
      }

      print(listBooks);

      return listBooks;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
