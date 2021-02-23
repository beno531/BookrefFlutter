class RecommendedPerson {
  RecommendedPerson(this.recommendedPerson);

  final dynamic recommendedPerson;

  getName() => this.recommendedPerson["recommendedPerson"]['name'];
}
