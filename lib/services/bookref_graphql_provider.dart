String readDashboardCurrents = r'''
query {
  books(where: {status: {eq: ACTIVE}}) {
    id
    status
    bookId
    book {
      title
      categories {
        name
      }
      authors {
        name
      }
      created
      isbn
      language
    }
    currentPage
    format
    personalLibraryId
    startDate
    status
  }
}
''';

String readDashboardWishlist = r'''
query {
  books(where: {status: {eq: WISH}}) {
    id
    status
    bookId
    book {
      title
      categories {
        name
      }
      authors {
        name
      }
      created
      isbn
      language
    }
    currentPage
    format
    personalLibraryId
    startDate
    status
  }
}
''';

String readDashboardLibrary = r'''
query {
  books(where: {status: {eq: DONE}}) {
    id
    status
    bookId
    book {
      title
      categories {
        name
      }
      authors {
        name
      }
      created
      isbn
      language
    }
    currentPage
    format
    personalLibraryId
    startDate
    status
  }
}
''';

String registerUser = r'''
mutation newUser {
    newUser(input: {  email: "{{email}}", username: "{{username}}", password: "{{password}}") {
        errors {
          message
        }
    }
}
''';
