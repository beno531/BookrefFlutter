import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MyDahsboardEvent extends Equatable {
  MyDahsboardEvent([List props = const []]) : super(props);
}

class LoadMyDashboardBooks extends MyDahsboardEvent {
  @override
  String toString() => 'LoadMyDashboardCurrents';
}
