import 'package:bookref/models/book.dart';
import 'package:hive/hive.dart';

part 'dashboardBooks.g.dart';

@HiveType(typeId: 1)
class DashboardBooks {
  DashboardBooks(this.currents, this.wishlist, this.library);
  @HiveField(0)
  final List<Book> currents;
  @HiveField(1)
  final List<Book> wishlist;
  @HiveField(2)
  final List<Book> library;
}
