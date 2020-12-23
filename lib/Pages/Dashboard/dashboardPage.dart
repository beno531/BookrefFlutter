import 'package:bookref/Bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:bookref/Bloc/dashboard_bloc/dashboard_current_events.dart';
import 'package:bookref/Pages/Dashboard/displayDasboardBooks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPage createState() => _DashboardPage();
}

class _DashboardPage extends State<DashboardPage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MyDashboardBloc>(context).add(LoadMyDashboardBooks());
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
        child: new DisplayDashboardBooks(
          bloc: BlocProvider.of<MyDashboardBloc>(context),
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
