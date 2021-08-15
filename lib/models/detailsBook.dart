import 'package:intl/intl.dart';

class DetailsBook {
  DetailsBook(this.book);

  final dynamic book;

  getId() => this.book["id"];

  getBookTitle() => this.book["title"];

  getBookLang() => this.book["language"];

  getBookCreated() => this.book["created"];

  getBookCurrentPage() => this.book["currentPage"];

  getBookIsbn() => this.book["isbn"];

  getBookSubtitle() => this.book["subtitle"];

  getBookThumbnail() => this.book["thumbnail"];

  getBookPageCount() => this.book["pageCount"];

  getBookTextSnippet() => this.book["textSnippet"];

  getBookPublishedDate() {
    var date = DateTime.parse(this.book["publishedDate"]);
    var formatter = new DateFormat('dd.MM.yyyy');
    return formatter.format(date);
  }

  getAuthor() {
    var authors = this.book["authors"];
    String output = "";

    if (authors.length != 0) {
      for (var i = 0; i < authors.length; i++) {
        if (i == authors.length - 1) {
          output += authors[i]['name'];
        } else {
          output += authors[i]['name'] + ", ";
        }
      }
      return output;
    }

    return "none";
  }
}
