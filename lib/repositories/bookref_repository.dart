import 'dart:async';
import 'package:bookref/services/connection_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gql/language.dart';
import 'package:graphql/client.dart';

class BookrefRepository {
  final storage = new FlutterSecureStorage();
  final String token = "";
  BookrefProvider _bookrefProvider;
  ConnectionService _connectionService;

  BookrefRepository() {
    _bookrefProvider = BookrefProvider();
    _connectionService = ConnectionService();
  }

  Future<QueryResult> getDashboardCurrents() async {
    final _client = await _connectionService.client();
    final WatchQueryOptions _options = WatchQueryOptions(
      //cacheRereadPolicy: CacheRereadPolicy.ignore,
      document: parseString(_bookrefProvider.readDashboardCurrents),
      pollInterval: Duration(seconds: 4),
      fetchResults: true,
    );

    return await _client.query(_options);
  }

  Future<QueryResult> getDashboardWishlist() async {
    final _client = await _connectionService.client();
    final WatchQueryOptions _options = WatchQueryOptions(
      document: parseString(_bookrefProvider.readDashboardWishlist),
      pollInterval: Duration(seconds: 4),
      fetchResults: true,
    );

    return await _client.query(_options);
  }

  Future<QueryResult> getDashboardLibary() async {
    final _client = await _connectionService.client();
    final WatchQueryOptions _options = WatchQueryOptions(
      document: parseString(_bookrefProvider.readDashboardLibrary),
      pollInterval: Duration(seconds: 4),
      fetchResults: true,
    );

    return await _client.query(_options);
  }

  Future<QueryResult> registerUser(
      String email, String username, String password) async {
    final _client = await _connectionService.client();
    final MutationOptions _options = MutationOptions(
      document: parseString(_bookrefProvider.registerUser),
      variables: {
        'input': {
          'email': '$email',
          'username': '$username',
          'password': '$password'
        }
      },
    );

    return await _client.mutate(_options);
  }

  Future<QueryResult> loginUser(String username, String password) async {
    final _client = await _connectionService.client();
    final MutationOptions _options = MutationOptions(
      document: parseString(_bookrefProvider.loginUser),
      variables: {
        'input': {'username': '$username', 'password': '$password'}
      },
    );

    return await _client.mutate(_options);
  }

  Future<QueryResult> addBook(
      String identifier, String title, String subtitle) async {
    final _client = await _connectionService.client();
    final MutationOptions _options = MutationOptions(
      document: parseString(_bookrefProvider.addBook),
      variables: {
        'input': {
          'identifier': '$identifier',
          'title': '$title',
          'subtitle': '$subtitle'
        }
      },
    );

    return await _client.mutate(_options);
  }

  Future<QueryResult> moveBookInLibrary(String bookId, String status) async {
    final _client = await _connectionService.client();
    final MutationOptions _options = MutationOptions(
      document: parseString(_bookrefProvider.moveBookInLibrary),
      variables: {
        'input': {'bookId': '$bookId', 'status': '$status'}
      },
    );

    return await _client.mutate(_options);
  }

  Future<QueryResult> addNewAuthor(String bookId, String authorName) async {
    final _client = await _connectionService.client();
    final MutationOptions _options = MutationOptions(
      document: parseString(_bookrefProvider.addNewAuthor),
      variables: {
        'input': {'bookId': '$bookId', 'name': '$authorName'}
      },
    );

    return await _client.mutate(_options);
  }

  Future<QueryResult> addAuthor(String bookId, String authorId) async {
    final _client = await _connectionService.client();
    final MutationOptions _options = MutationOptions(
      document: parseString(_bookrefProvider.addAuthor),
      variables: {
        'input': {'bookId': '$bookId', 'authorId': '$authorId'}
      },
    );

    return await _client.mutate(_options);
  }

  Future<QueryResult> checkAuthorName(String authorName) async {
    final _client = await _connectionService.client();
    final WatchQueryOptions _options = WatchQueryOptions(
      document: parseString(_bookrefProvider.checkAuthorName),
      variables: {'input': authorName},
      pollInterval: Duration(seconds: 4),
      fetchResults: true,
    );

    return await _client.query(_options);
  }

  Future<QueryResult> checkPersonName(String personName) async {
    final _client = await _connectionService.client();
    final WatchQueryOptions _options = WatchQueryOptions(
      document: parseString(_bookrefProvider.checkPeopleName),
      variables: {'input': personName},
      pollInterval: Duration(seconds: 4),
      fetchResults: true,
    );

    return await _client.query(_options);
  }

  Future<QueryResult> getBookByTitle(String title) async {
    final _client = await _connectionService.client();
    final WatchQueryOptions _options = WatchQueryOptions(
      document: parseString(_bookrefProvider.getBookByTitle),
      variables: {'input': title},
      pollInterval: Duration(seconds: 4),
      fetchResults: true,
    );

    return await _client.query(_options);
  }

  Future<QueryResult> addPerson(String personName) async {
    final _client = await _connectionService.client();
    final WatchQueryOptions _options = WatchQueryOptions(
      document: parseString(_bookrefProvider.addPerson),
      variables: {
        'input': {'name': '$personName'}
      },
      pollInterval: Duration(seconds: 4),
      fetchResults: true,
    );

    return await _client.query(_options);
  }

  Future<QueryResult> addPersonRecommendation(
      String bookId, String personId, String note) async {
    final _client = await _connectionService.client();
    final WatchQueryOptions _options = WatchQueryOptions(
      document: parseString(_bookrefProvider.addPersonRecommendation),
      variables: {
        'input': {
          'sourceBookId': '$bookId',
          'targetPersonId': '$personId',
          'note': '$note'
        }
      },
      pollInterval: Duration(seconds: 4),
      fetchResults: true,
    );

    return await _client.query(_options);
  }

  Future<QueryResult> addBookRecommendation(
      String sourceBookId, String targetBookId, String note) async {
    final _client = await _connectionService.client();
    final WatchQueryOptions _options = WatchQueryOptions(
      document: parseString(_bookrefProvider.addBookRecommendation),
      variables: {
        'input': {
          'sourceBookId': '$sourceBookId',
          'targetBookId': '$targetBookId',
          'note': '$note'
        }
      },
      pollInterval: Duration(seconds: 4),
      fetchResults: true,
    );

    return await _client.query(_options);
  }

  Future<QueryResult> getPeopleRecommendationsForBook(String bookId) async {
    final _client = await _connectionService.client();
    final WatchQueryOptions _options = WatchQueryOptions(
      document: parseString(_bookrefProvider.getPeopleRecommendationsForBook),
      variables: {'input': bookId},
      pollInterval: Duration(seconds: 4),
      fetchResults: true,
    );

    return await _client.query(_options);
  }

  Future<QueryResult> getBookRecommendationsForBook(String bookId) async {
    final _client = await _connectionService.client();
    final WatchQueryOptions _options = WatchQueryOptions(
      document: parseString(_bookrefProvider.getBookRecommendationsForBook),
      variables: {'input': bookId},
      pollInterval: Duration(seconds: 4),
      fetchResults: true,
    );

    return await _client.query(_options);
  }

  Future<QueryResult> changeBookStatus(
      String personalBookId, String newStatus) async {
    final _client = await _connectionService.client();
    final MutationOptions _options = MutationOptions(
      document: parseString(_bookrefProvider.changeBookStatus),
      variables: {
        'input': {
          'personalBookId': '$personalBookId',
          'newStatus': '$newStatus'
        }
      },
    );

    return await _client.mutate(_options);
  }

  Future<QueryResult> getFullBookById(String bookId) async {
    final _client = await _connectionService.client();
    final WatchQueryOptions _options = WatchQueryOptions(
      document: parseString(_bookrefProvider.getFullBookById),
      variables: {'input': bookId},
      pollInterval: Duration(seconds: 4),
      fetchResults: true,
    );

    return await _client.query(_options);
  }

  Future<QueryResult> getBooksByName(String bookName) async {
    final _client = await _connectionService.client();
    final WatchQueryOptions _options = WatchQueryOptions(
      document: parseString(_bookrefProvider.getBooksByName),
      variables: {'input': bookName},
      pollInterval: Duration(seconds: 4),
      fetchResults: true,
    );

    return await _client.query(_options);
  }
}

class BookrefProvider {
  String readDashboardCurrents = r'''
query {
    books(where: { status: { eq: ACTIVE } }) {
        id
        bookId
        status
        book {
            title
            authors{
              name
            }
        }
    }
}
''';

  String readDashboardWishlist = r'''
query {
    books(where: { status: { eq: WISH } }) {
        id
        bookId
        status
        book {
            title
            authors{
              name
            }
        }
    }
}
''';

  String readDashboardLibrary = r'''
query {
    books(where: { status: { eq: DONE } }) {
        id
        bookId
        status
        book {
            title
            authors{
              name
            }
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

  String changeBookStatus = r'''
mutation changeBookStatus ($input: MoveBookStatusInput!){
    changeBookStatus(input: $input) {
      data{
        id
      },
      errors {
        message
      }
    }
}
''';

  String getFullBookById = r'''
query ($input: ID!){
    bookById(id: $input) {
    id
    title
    subtitle
    authors{
      name
    }
  }
}
''';

  String getBooksByName = r'''
query($input: String!){
  allBooks(where: {title: {contains: $input}}){
    nodes{
      id
      title
      authors{
        name
      }
    }
  }
}
''';
}
