class Books {
  Books(this.books);

  final dynamic books;

  getUserId() => this.books["userId"];

  getBook() => this.books["book"];

  getBookTitle() => this.books["book"]["title"];

  getBookLang() => this.books["book"]["language"];

  getBookCreated() => this.books["book"]["created"];

  getBookCurrentPage() => this.books["currentPage"];

  getBookIsbn() => this.books["book"]["isbn"];

  getAuthor() {
    var authors = this.books["book"]["bookAuthors"];

    return authors[0]["author"]["name"];
  }
}

/*
class Books {
  const Books({
    this.userId,
    this.currentPage,
    this.status,
    this.book,
    this.created,
    this.isbn,
    this.bookCategories,
    this.isLoading: false,
  });

  final String userId;
  final String currentPage;
  final String status;
  final Book book;
  final String created;
  final String isbn;
  final BookCategories bookCategories;
  final bool isLoading;
}

class Book {
  const Book({
    this.language,
    this.title,
    this.bookAuthors,
    this.created,
    this.isbn,
    this.bookCategories,
  });

  final String language;
  final String title;
  final BookAuthors bookAuthors;
  final String created;
  final String isbn;
  final BookCategories bookCategories;
}

class BookAuthors {
  const BookAuthors({this.author});

  final Author author;
}

class Author {
  const Author({
    this.name,
  });

  final String name;
}

class BookCategories {
  const BookCategories({
    this.category,
  });

  final Category category;
}

class Category {
  const Category({
    this.name,
  });

  final String name;
}
*/
