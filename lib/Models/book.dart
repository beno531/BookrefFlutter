class Book {
  Book(this.book);

  final dynamic book;

  getBook() => this.book["book"];

  getId() => this.book["id"];

  getStatus() => this.book["status"];

  getBookId() => this.book["bookId"];

  getBookTitle() => this.book["book"]["title"];

  getBookLang() => this.book["book"]["language"];

  getBookCreated() => this.book["book"]["created"];

  getBookCurrentPage() => this.book["currentPage"];

  getBookIsbn() => this.book["book"]["isbn"];

  getBookSubtitle() => this.book["book"]["subtitle"];

  getAuthor() {
    var authors = this.book["book"]["authors"];

    return authors[0]["name"];
  }
}
