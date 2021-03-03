import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc_authentication/blocs/dashboard/dashboard_event.dart';
import 'package:flutter_bloc_authentication/blocs/dashboard/dashboard_state.dart';
import 'package:flutter_bloc_authentication/models/dashboardBooks.dart';
import 'package:flutter_bloc_authentication/repositories/bookref_repository.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../services/services.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DataService dataService;

  DashboardBloc({@required this.dataService}) : super(DashboardItemsLoading());

  @override
  Stream<DashboardState> mapEventToState(DashboardEvent event) async* {
    if (event is LoadDashboardItems) {
      yield* _mapLoadDashboardItemsToState(event);
    }

    if (event is MoveDashboardBook) {
      yield* _mapMoveDashboardBookToState(
          event.personalBookId, event.newStatus);
    }
  }

  Stream<DashboardState> _mapLoadDashboardItemsToState(
      LoadDashboardItems event) async* {
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

  Stream<DashboardState> _mapMoveDashboardBookToState(
      String personalBooKId, String newStatus) async* {
    try {
      var result =
          await dataService.changeBookStatus(personalBooKId, newStatus);
      mapEventToState(LoadDashboardItems());
      print(result.data.toString());
    } catch (err) {
      yield DashboardItemsFailure(
          message: err.message ?? 'An unknown error occured');
    }
  }
}
