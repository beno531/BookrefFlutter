class BookResult {
  BookResult(this.bookResult);

  final dynamic bookResult;

  getBookData() => this.bookResult["data"];

  getBookDataId() => this.bookResult["data"]["id"];

  getBookErrors() => this.bookResult["data"];
}
