import 'package:auto_route/auto_route.dart';

import 'package:bookref/pages/pages.dart';
import 'package:bookref/pages/private/dashboardLayoutPage.dart';
import 'package:bookref/pages/private/library_page.dart';
import 'package:bookref/pages/private/addBook_page.dart';
import 'package:bookref/pages/private/addRecommendation_page.dart';
import 'package:bookref/pages/private/currents_page.dart';
import 'package:bookref/pages/private/details_page.dart';
import 'package:bookref/pages/private/wishlist_page.dart';
import 'package:bookref/pages/public/register_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      path: '/dashboard',
      page: DashboardLayoutPage,
      initial: true,
      children: [
        AutoRoute(
          path: 'currents',
          page: CurrentsPage,
        ),
        AutoRoute(path: 'wishlist', page: WishlistPage),
        AutoRoute(path: 'library', page: LibraryPage),
      ],
    ),
    AutoRoute(path: '/add-book', page: AddBookPage),
    AutoRoute(path: '/add-recommendation', page: AddRecommendationPage),
    AutoRoute(path: '/book-details', page: BookDetailsPage),
    AutoRoute(path: '/login', page: LoginPage, initial: true),
    AutoRoute(path: '/register', page: RegisterPage),
  ],
)
class $AppRouter {}
