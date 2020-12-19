const String getCurrentDahsbaordBooks = r'''
  query {
    books (where: { status: { eq: ACTIVE } } ) {
          book {
            title
            bookAuthors {
              author {
                name
              }
            }
            isbn
          }
        }
  }
''';

const String getWishlistDahsbaordBooks = r'''
  query {
    books (where: { status: { eq: WISH } } ) {
          book {
            title
            bookAuthors {
              author {
                name
              }
            }
            isbn
          }
        }
  }
''';

const String getReadDahsbaordBooks = r'''
  query {
     books (where: { status: { eq: DONE } } ) {
          book {
            title
            bookAuthors {
              author {
                name
              }
            }
            isbn
          }
        }
  }
''';
