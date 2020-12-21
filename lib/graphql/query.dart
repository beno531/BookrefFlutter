const String getCurrentDahsbaordBooks = r'''
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

const String getWishlistDahsbaordBooks = r'''
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

const String getDoneDahsbaordBooks = r'''
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
