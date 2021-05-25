import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class RemoveBookEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RemoveBook extends RemoveBookEvent {
  String personalBookId;
  RemoveBook({@required this.personalBookId})
      : assert(personalBookId.isEmpty == false);
}
