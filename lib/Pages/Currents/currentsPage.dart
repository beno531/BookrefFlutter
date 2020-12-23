import 'package:bookref/Bloc/currents_bloc/currents_bloc.dart';
import 'package:bookref/Bloc/currents_bloc/currents_events.dart';
import 'package:bookref/Pages/Currents/displayDasboardBooks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrentsPage extends StatefulWidget {
  @override
  _CurrentsPage createState() => _CurrentsPage();
}

class _CurrentsPage extends State<CurrentsPage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MyCurrentsBloc>(context).add(LoadMyCurrentBooks());
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_selectedIndex) {
      case 0:
        break;
      case 1:
        break;
      case 2:
        break;
      case 3:
        break;
      default:
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Bookref. --- Dashboard"),
        backgroundColor: Colors.black,
      ),
      body: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(36, 36, 36, 1.0)),
        child: new DisplayCurrentsBooks(
          bloc: BlocProvider.of<MyCurrentsBloc>(context),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_library),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_objects),
            label: 'School',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'School',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
