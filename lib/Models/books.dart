class Books {
  Books(this.books);

  final dynamic books;

  getUserId() => this.books["userId"];

  getBook() => this.books["book"];

  getBookTitle() => this.books["book"]["title"];

  getAuthor() {
    var authors = this.books["book"]["bookAuthors"];

    return authors[0]["author"]["name"];
  }
}
