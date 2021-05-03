import 'package:bloc/bloc.dart';
import 'package:bookref/Models/dashboardBooks.dart';
import 'package:bookref/blocs/dashboard/dashboard_event.dart';
import 'package:bookref/blocs/dashboard/dashboard_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import '../../services/services.dart';
import 'package:connectivity/connectivity.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DataService dataService;

  DashboardBloc({@required this.dataService}) : super(DashboardItemsLoading());

  @override
  Stream<DashboardState> mapEventToState(DashboardEvent event) async* {
    if (event is LoadDashboardItems) {
      yield* _mapLoadDashboardItemsToState(event);
    }
  }

  Stream<DashboardState> _mapLoadDashboardItemsToState(
      LoadDashboardItems event) async* {
    yield DashboardItemsLoading();
    print("Load Dashboard Items");
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        DashboardBooks dashboardBooks = await dataService.getDashboardBooks();
        if (dashboardBooks != null) {
          yield DashboardItemsFinished(dashboardBooks: dashboardBooks);
        } else {
          yield DashboardItemsFailure(
              message: 'Something very weird just happened');
        }
      } else {
        var box = await Hive.openBox('data');
        var test = box.get('currents');
        print(test);
        yield DashboardItemsFinished(dashboardBooks: test);
      }
    } catch (err) {
      yield DashboardItemsFailure(message: err ?? 'An unknown error occured');
    }
  }
}
