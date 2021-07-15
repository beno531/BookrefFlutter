class RecommendedBook {
  RecommendedBook(this.recommendedBook);

  final dynamic recommendedBook;

  getTitle() => this.recommendedBook['recommendedBook']['title'];
  getNote() => this.recommendedBook['note']['content'];
}
