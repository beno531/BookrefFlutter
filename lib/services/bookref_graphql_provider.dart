const String readDashboardCurrents = r'''
query {
    books (where: { status: { eq: ACTIVE } } ) {
         userId
    currentPage
    status
    book {
      id
      language
      title
      bookAuthors {
        author {
          name
        }
      }
      created
      isbn
      bookCategories {
        category {
          name
        }
      }
    }
        }
  }
''';

const String readDashboardWishlist = r'''
query {
    books (where: { status: { eq: WISH } } ) {
         userId
    currentPage
    status
    book {
      id
      language
      title
      bookAuthors {
        author {
          name
        }
      }
      created
      isbn
      bookCategories {
        category {
          name
        }
      }
    }
        }
  }
''';

const String readDashboardLibary = r'''
query {
    books (where: { status: { eq: DONE } } ) {
         userId
    currentPage
    status
    book {
      id
      language
      title
      bookAuthors {
        author {
          name
        }
      }
      created
      isbn
      bookCategories {
        category {
          name
        }
      }
    }
        }
  }
''';
