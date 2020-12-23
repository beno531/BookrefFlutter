import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookref/Bloc/wishlist_bloc/wishlist_bloc.dart';
import 'package:bookref/Bloc/wishlist_bloc/wishlist_events.dart';
import 'package:bookref/Pages/Wishlist/displayWishlistBooks.dart';

class WishlistPage extends StatefulWidget {
  @override
  _WishlistPage createState() => _WishlistPage();
}

class _WishlistPage extends State<WishlistPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MyWishlistBloc>(context).add(LoadMyWishlistBooks());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Color.fromRGBO(36, 36, 36, 1.0)),
      child: new DisplayWishlistBooks(
        bloc: BlocProvider.of<MyWishlistBloc>(context),
      ),
    );
  }
}
