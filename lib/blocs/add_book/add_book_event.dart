import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class AddBookEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddBookButtonPressed extends AddBookEvent {
  final String status;
  final String id;
  final String identifier;
  final String title;
  final String subtitle;
  final String author;

  AddBookButtonPressed(
      {this.status,
      this.id,
      this.identifier,
      this.title,
      this.subtitle,
      this.author});
}
