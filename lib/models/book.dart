import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

@HiveType(typeId: 2)
class Book {
  Book(this.book);

  @HiveField(0)
  final dynamic book;

  getBook() => this.book["book"];

  getId() => this.book["id"];

  getStatus() => this.book["status"];

  getBookId() => this.book["bookId"];

  getBookTitle() => this.book["book"]["title"];

  getBookThumbnail() => this.book["book"]["thumbnail"];

  getBookLang() => this.book["book"]["language"];

  getBookPageCount() => this.book["book"]["pageCount"];

  getBookTextSnippet() => this.book["book"]["textSnippet"];

  getBookPublishedDate() {
    var date = DateTime.parse(this.book["book"]["publishedDate"]);
    var formatter = new DateFormat('dd.MM.yyyy');
    return formatter.format(date);
  }

  getBookCreated() => this.book["book"]["created"];

  getBookCurrentPage() => this.book["currentPage"];

  getBookIsbn() => this.book["book"]["isbn"];

  getBookSubtitle() => this.book["book"]["subtitle"];

  getAuthor() {
    var authors = this.book["book"]["authors"];

    return authors[0]["name"];
  }
}
