import 'package:bookref/Models/book.dart';

class DashboardBooks {
  DashboardBooks(this.currents, this.wishlist, this.library);
  final List<Book> currents;
  final List<Book> wishlist;
  final List<Book> library;
}
