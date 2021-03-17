import 'package:bloc/bloc.dart';
import 'package:bookref/Models/dashboardBooks.dart';
import 'package:bookref/blocs/dashboard/dashboard_event.dart';
import 'package:bookref/blocs/dashboard/dashboard_state.dart';
import 'package:flutter/cupertino.dart';
import '../../services/services.dart';

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
      DashboardBooks dashboardBooks = await dataService.getDashboardBooks();
      if (dashboardBooks != null) {
        yield DashboardItemsFinished(dashboardBooks: dashboardBooks);
      } else {
        yield DashboardItemsFailure(
            message: 'Something very weird just happened');
      }
    } catch (err) {
      yield DashboardItemsFailure(
          message: err.message ?? 'An unknown error occured');
    }
  }
}
