import 'package:bookref/models/dashboardBooks.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class DashboardState extends Equatable {
  @override
  List<Object> get props => [];
}

class DashboardItemsLoading extends DashboardState {}

class ReloadDashboardItems extends DashboardState {}

class DashboardItemsFinished extends DashboardState {
  final DashboardBooks dashboardBooks;
  DashboardItemsFinished({@required this.dashboardBooks});
}

class DashboardItemsFailure extends DashboardState {
  final String message;
  DashboardItemsFailure({@required this.message});
}
