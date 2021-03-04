class TestBook {
  TestBook(this.book);

  final dynamic book;


  getId() => this.book["id"];

  getBookTitle() => this.book["title"];

  getBookLang() => this.book["language"];

  getBookCreated() => this.book["created"];

  getBookCurrentPage() => this.book["currentPage"];

  getBookIsbn() => this.book["isbn"];

  getBookSubtitle() => this.book["subtitle"];

  getAuthor() {
    var authors = this.book["authors"];

    return authors[0]["name"];
  }
}