class QueryMutation {
  String addPerson(String id, String name, String lastName, int age) {
    return """
      mutation{
          addPerson(id: "$id", name: "$name", lastName: "$lastName", age: $age){
            id
            name
            lastName
            age
          }
      }
    """;
  }

  String getAll() {
    return """
      {
        persons{
          id
          name
          lastName
          age
        }
      }
    """;
  }

  String deletePerson(id) {
    return """
      mutation{
        deletePerson(id: "$id"){
          id
        }
      }
    """;
  }

  String editPerson(String id, String name, String lastName, int age) {
    return """
      mutation{
          editPerson(id: "$id", name: "$name", lastName: "$lastName", age: $age){
            name
            lastName
          }
      }
     """;
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////
  ///
  ///       GraphQL Query - BOOKREF
  ///
  //////////////////////////////////////////////////////////////////////////////////////////////////

  String getCurrentDahsbaordBooks() {
    return """
      {
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
    """;
  }

  String getWishlistDahsbaordBooks() {
    return """
      {
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
    """;
  }

  String getReadDahsbaordBooks() {
    return """
      {
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
    """;
  }
}
