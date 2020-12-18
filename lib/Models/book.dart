class Book {
  Book(this.language, this.title, this.created, this.isbn);

  final String language;
  final String title;
  //final String bookAuthors;
  final String created;
  final String isbn;
  //final String bookCategories;

  getLanguage() => this.language;

  getTitle() => this.title;

  getCreated() => this.created;

  getIsbn() => this.isbn;
}
