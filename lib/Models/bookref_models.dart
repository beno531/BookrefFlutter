/*
class Book {
  List<Data> data;

  Book(data) {
    this.data = data;
  }

  Book.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String isbn;
  String title;
  String link;
  String auflage;
  String created;
  int language;
  Creator creator;
  List<BookCategories> bookCategories;
  List<BookAuthors> bookAuthors;
  int id;
  String ownedBy;

  Data(
      {this.isbn,
      this.title,
      this.link,
      this.auflage,
      this.created,
      this.language,
      this.creator,
      this.bookCategories,
      this.bookAuthors,
      this.id,
      this.ownedBy});

  Data.fromJson(Map<String, dynamic> json) {
    isbn = json['isbn'];
    title = json['title'];
    link = json['link'];
    auflage = json['auflage'];
    created = json['created'];
    language = json['language'];
    creator =
        json['creator'] != null ? new Creator.fromJson(json['creator']) : null;
    if (json['bookCategories'] != null) {
      bookCategories = new List<BookCategories>();
      json['bookCategories'].forEach((v) {
        bookCategories.add(new BookCategories.fromJson(v));
      });
    }
    if (json['bookAuthors'] != null) {
      bookAuthors = new List<BookAuthors>();
      json['bookAuthors'].forEach((v) {
        bookAuthors.add(new BookAuthors.fromJson(v));
      });
    }
    id = json['id'];
    ownedBy = json['ownedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isbn'] = this.isbn;
    data['title'] = this.title;
    data['link'] = this.link;
    data['auflage'] = this.auflage;
    data['created'] = this.created;
    data['language'] = this.language;
    if (this.creator != null) {
      data['creator'] = this.creator.toJson();
    }
    if (this.bookCategories != null) {
      data['bookCategories'] =
          this.bookCategories.map((v) => v.toJson()).toList();
    }
    if (this.bookAuthors != null) {
      data['bookAuthors'] = this.bookAuthors.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    data['ownedBy'] = this.ownedBy;
    return data;
  }
}

class Creator {
  String username;
  String password;
  String eMail;
  List<MyRecommendations> myRecommendations;
  List<MyBooks> myBooks;
  int id;
  String ownedBy;

  Creator(
      {this.username,
      this.password,
      this.eMail,
      this.myRecommendations,
      this.myBooks,
      this.id,
      this.ownedBy});

  Creator.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    eMail = json['eMail'];
    if (json['myRecommendations'] != null) {
      myRecommendations = new List<MyRecommendations>();
      json['myRecommendations'].forEach((v) {
        myRecommendations.add(new MyRecommendations.fromJson(v));
      });
    }
    if (json['myBooks'] != null) {
      myBooks = new List<MyBooks>();
      json['myBooks'].forEach((v) {
        myBooks.add(new MyBooks.fromJson(v));
      });
    }
    id = json['id'];
    ownedBy = json['ownedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    data['eMail'] = this.eMail;
    if (this.myRecommendations != null) {
      data['myRecommendations'] =
          this.myRecommendations.map((v) => v.toJson()).toList();
    }
    if (this.myBooks != null) {
      data['myBooks'] = this.myBooks.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    data['ownedBy'] = this.ownedBy;
    return data;
  }
}

class MyRecommendations {
  int type;
  Note note;
  int sourceBookId;
  int recommendedBookId;
  RecommendedPerson recommendedPerson;
  int recommendedPersonId;
  int id;
  String ownedBy;

  MyRecommendations(
      {this.type,
      this.note,
      this.sourceBookId,
      this.recommendedBookId,
      this.recommendedPerson,
      this.recommendedPersonId,
      this.id,
      this.ownedBy});

  MyRecommendations.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    note = json['note'] != null ? new Note.fromJson(json['note']) : null;
    sourceBookId = json['sourceBookId'];
    recommendedBookId = json['recommendedBookId'];
    recommendedPerson = json['recommendedPerson'] != null
        ? new RecommendedPerson.fromJson(json['recommendedPerson'])
        : null;
    recommendedPersonId = json['recommendedPersonId'];
    id = json['id'];
    ownedBy = json['ownedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.note != null) {
      data['note'] = this.note.toJson();
    }
    data['sourceBookId'] = this.sourceBookId;
    data['recommendedBookId'] = this.recommendedBookId;
    if (this.recommendedPerson != null) {
      data['recommendedPerson'] = this.recommendedPerson.toJson();
    }
    data['recommendedPersonId'] = this.recommendedPersonId;
    data['id'] = this.id;
    data['ownedBy'] = this.ownedBy;
    return data;
  }
}

class Note {
  String content;
  int shareType;
  int id;
  String ownedBy;

  Note({this.content, this.shareType, this.id, this.ownedBy});

  Note.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    shareType = json['shareType'];
    id = json['id'];
    ownedBy = json['ownedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['shareType'] = this.shareType;
    data['id'] = this.id;
    data['ownedBy'] = this.ownedBy;
    return data;
  }
}

class RecommendedPerson {
  int id;
  String name;

  RecommendedPerson({this.id, this.name});

  RecommendedPerson.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class MyBooks {
  int userBooksId;
  String startDate;
  int currentPage;
  bool wishlist;
  int status;
  int type;
  int userId;
  int bookId;
  RecommendedPerson speaker;

  MyBooks(
      {this.userBooksId,
      this.startDate,
      this.currentPage,
      this.wishlist,
      this.status,
      this.type,
      this.userId,
      this.bookId,
      this.speaker});

  MyBooks.fromJson(Map<String, dynamic> json) {
    userBooksId = json['userBooksId'];
    startDate = json['startDate'];
    currentPage = json['currentPage'];
    wishlist = json['wishlist'];
    status = json['status'];
    type = json['type'];
    userId = json['userId'];
    bookId = json['bookId'];
    speaker = json['speaker'] != null
        ? new RecommendedPerson.fromJson(json['speaker'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userBooksId'] = this.userBooksId;
    data['startDate'] = this.startDate;
    data['currentPage'] = this.currentPage;
    data['wishlist'] = this.wishlist;
    data['status'] = this.status;
    data['type'] = this.type;
    data['userId'] = this.userId;
    data['bookId'] = this.bookId;
    if (this.speaker != null) {
      data['speaker'] = this.speaker.toJson();
    }
    return data;
  }
}

class BookCategories {
  int bookId;
  RecommendedPerson category;
  int categoryId;
  bool isPrimary;

  BookCategories({this.bookId, this.category, this.categoryId, this.isPrimary});

  BookCategories.fromJson(Map<String, dynamic> json) {
    bookId = json['bookId'];
    category = json['category'] != null
        ? new RecommendedPerson.fromJson(json['category'])
        : null;
    categoryId = json['categoryId'];
    isPrimary = json['isPrimary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bookId'] = this.bookId;
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    data['categoryId'] = this.categoryId;
    data['isPrimary'] = this.isPrimary;
    return data;
  }
}

class BookAuthors {
  int bookId;
  RecommendedPerson author;
  int authorId;

  BookAuthors({this.bookId, this.author, this.authorId});

  BookAuthors.fromJson(Map<String, dynamic> json) {
    bookId = json['bookId'];
    author = json['author'] != null
        ? new RecommendedPerson.fromJson(json['author'])
        : null;
    authorId = json['authorId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bookId'] = this.bookId;
    if (this.author != null) {
      data['author'] = this.author.toJson();
    }
    data['authorId'] = this.authorId;
    return data;
  }
}
*/
