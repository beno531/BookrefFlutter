String readDashboardCurrents = r'''
query {
    books(where: { status: { eq: ACTIVE } }) {
        id
        status
        bookId
        book {
            title
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
