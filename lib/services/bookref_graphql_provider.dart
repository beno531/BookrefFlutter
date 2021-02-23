String readDashboardCurrents = r'''
query {
    books(where: { status: { eq: ACTIVE } }) {
        id
        status
        bookId
        book {
            title
            subtitle
        }
    }
}
''';

String readDashboardWishlist = r'''
query {
    books(where: { status: { eq: WISH } }) {
        id
        status
        bookId
        book {
            title
            subtitle
        }
    }
}
''';

String readDashboardLibrary = r'''
query {
    books(where: { status: { eq: DONE } }) {
        id
        status
        bookId
        book {
            title
            subtitle
        }
    }
}
''';

String registerUser = r'''
mutation registerUser ($input: NewUserInput!){
    newUser(input: $input) {
      errors {
        message
      }
    }
}
''';

String loginUser = r'''
mutation login ($input: SingInInput!){
    singIn(input: $input) {
      data,
      errors {
        message
      }
    }
}
''';

String addBook = r'''
mutation addBook ($input: AddBookInput!){
    addBook(input: $input) {
      data{
        id
      },
      errors {
        message
      }
    }
}
''';

String moveBookInLibrary = r'''
mutation moveBookInLibrary ($input: MoveBookToLibraryInput!){
    moveBookInLibrary(input: $input) {
      data{
        id
      },
      errors {
        message
      }
    }
}
''';

String addNewAuthor = r'''
mutation addNewAuthor ($input: AddNewAuthorInput!){
    addNewAuthor(input: $input) {
      data{
        id
      },
      errors {
        message
      }
    }
}
''';

String addAuthor = r'''
mutation addAuthor ($input: AddExistingAuthorInput!){
    addAuthor(input: $input) {
      data{
        id
      },
      errors {
        message
      }
    }
}
''';

String checkAuthorName = r'''
query ($input: String!){
    authors(where: { name: { contains: $input } }) {
        id
        name
    }
}
''';

String checkPeopleName = r'''
query ($input: String!){
    people(where: { name: { startsWith: $input } }) {
        id
        name
    }
}
''';

String addPerson = r'''
mutation addPerson ($input: AddPersonInput!){
    addPerson(input: $input) {
      data{
        id
      },
      errors {
        message
      }
    }
}
''';

String addPersonRecommendation = r'''
mutation addPersonRecommendation ($input: AddPersonRecommendationInput!){
    addPersonRecommendation(input: $input) {
      data{
        id
      },
      errors {
        message
      }
    }
}
''';

String addBookRecommendation = r'''
mutation addBookRecommendation ($input: AddBookRecommendationInput!){
    addBookRecommendation(input: $input) {
      data{
        id
      },
      errors {
        message
      }
    }
}
''';

String getBookByTitle = r'''
query ($input: String!){
  allBooks(where: { title: {eq: $input} } ) {
        edges {
          node {
            id
          }
        }
    }
}
''';

String getPeopleRecommendationsForBook = r'''
query ($input: ID!){
    peopleRecommendationsForBook(id: $input) {
        recommendedPerson{
          name
        }
        note {
          content
        }
    }
}
''';

String getBookRecommendationsForBook = r'''
query ($input: ID!){
    bookRecommendationsForBook(id: $input) {
        recommendedBook{
          title
        }
        note {
          content
        }
    }
}
''';
