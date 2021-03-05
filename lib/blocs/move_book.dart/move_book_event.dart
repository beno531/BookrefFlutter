import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class MoveBookEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class MoveBook extends MoveBookEvent {
  String personalBookId;
  String newStatus;
  MoveBook({@required this.personalBookId, @required this.newStatus})
      : assert(newStatus.isEmpty == false),
        assert(personalBookId.isEmpty == false);
}
