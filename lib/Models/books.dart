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
