import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class DashboardEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadDashboardItems extends DashboardEvent {}

class MoveDashboardBook extends DashboardEvent {
  String personalBookId;
  String newStatus;
  MoveDashboardBook({@required this.personalBookId, @required this.newStatus})
      : assert(newStatus.isEmpty == false),
        assert(personalBookId.isEmpty == false);
}
