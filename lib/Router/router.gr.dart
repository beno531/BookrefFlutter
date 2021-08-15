// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import '../models/book.dart' as _i10;
import '../pages/private/library_page.dart' as _i9;
import '../pages/private/addBook_page.dart' as _i4;
import '../pages/private/addRecommendation_page.dart' as _i5;
import '../pages/private/currents_page.dart' as _i7;
import '../pages/private/dashboardLayoutPage.dart' as _i3;
import '../pages/private/details_page.dart' as _i6;
import '../pages/private/wishlist_page.dart' as _i8;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i2.GlobalKey<_i2.NavigatorState> navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    DashboardLayoutRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<DashboardLayoutRouteArgs>(
              orElse: () => const DashboardLayoutRouteArgs());
          return _i3.DashboardLayoutPage(key: args.key);
        }),
    AddBookRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i4.AddBookPage();
        }),
    AddRecommendationRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<AddRecommendationRouteArgs>();
          return _i5.AddRecommendationPage(args.bookId);
        }),
    BookDetailsRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<BookDetailsRouteArgs>(
              orElse: () => const BookDetailsRouteArgs());
          return _i6.BookDetailsPage(key: args.key, book: args.book);
        }),
    CurrentsRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i7.CurrentsPage();
        }),
    WishlistRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i8.WishlistPage();
        }),
    LibraryRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i9.LibraryPage();
        })
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig('/#redirect',
            path: '/', redirectTo: '/dashboard', fullMatch: true),
        _i1.RouteConfig(DashboardLayoutRoute.name,
            path: '/dashboard',
            children: [
              _i1.RouteConfig('#redirect',
                  path: '', redirectTo: 'currents', fullMatch: true),
              _i1.RouteConfig(CurrentsRoute.name, path: 'currents'),
              _i1.RouteConfig(WishlistRoute.name, path: 'wishlist'),
              _i1.RouteConfig(LibraryRoute.name, path: 'library')
            ]),
        _i1.RouteConfig(AddBookRoute.name, path: '/add-book'),
        _i1.RouteConfig(AddRecommendationRoute.name,
            path: '/add-recommendation'),
        _i1.RouteConfig(BookDetailsRoute.name, path: '/book-details')
      ];
}

class DashboardLayoutRoute extends _i1.PageRouteInfo<DashboardLayoutRouteArgs> {
  DashboardLayoutRoute({_i2.Key key, List<_i1.PageRouteInfo> children})
      : super(name,
            path: '/dashboard',
            args: DashboardLayoutRouteArgs(key: key),
            initialChildren: children);

  static const String name = 'DashboardLayoutRoute';
}

class DashboardLayoutRouteArgs {
  const DashboardLayoutRouteArgs({this.key});

  final _i2.Key key;
}

class AddBookRoute extends _i1.PageRouteInfo {
  const AddBookRoute() : super(name, path: '/add-book');

  static const String name = 'AddBookRoute';
}

class AddRecommendationRoute
    extends _i1.PageRouteInfo<AddRecommendationRouteArgs> {
  AddRecommendationRoute({String bookId})
      : super(name,
            path: '/add-recommendation',
            args: AddRecommendationRouteArgs(bookId: bookId));

  static const String name = 'AddRecommendationRoute';
}

class AddRecommendationRouteArgs {
  const AddRecommendationRouteArgs({this.bookId});

  final String bookId;
}

class BookDetailsRoute extends _i1.PageRouteInfo<BookDetailsRouteArgs> {
  BookDetailsRoute({_i2.Key key, _i10.Book book})
      : super(name,
            path: '/book-details',
            args: BookDetailsRouteArgs(key: key, book: book));

  static const String name = 'BookDetailsRoute';
}

class BookDetailsRouteArgs {
  const BookDetailsRouteArgs({this.key, this.book});

  final _i2.Key key;

  final _i10.Book book;
}

class CurrentsRoute extends _i1.PageRouteInfo {
  const CurrentsRoute() : super(name, path: 'currents');

  static const String name = 'CurrentsRoute';
}

class WishlistRoute extends _i1.PageRouteInfo {
  const WishlistRoute() : super(name, path: 'wishlist');

  static const String name = 'WishlistRoute';
}

class LibraryRoute extends _i1.PageRouteInfo {
  const LibraryRoute() : super(name, path: 'library');

  static const String name = 'LibraryRoute';
}
