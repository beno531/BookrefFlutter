const String readDashboardCurrents = r'''
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

const String readDashboardWishlist = r'''
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

const String readDashboardLibary = r'''
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
