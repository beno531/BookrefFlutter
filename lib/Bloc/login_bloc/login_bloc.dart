import 'package:bookref/Bloc/login_bloc/login_events.dart';
import 'package:bookref/Bloc/login_bloc/login_states.dart';
import 'package:bookref/services/bookref_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MyLoginBloc extends Bloc<MyLoginEvent, MyLoginState> {
  final BookrefRepository bookrefRepository;

  MyLoginBloc({@required this.bookrefRepository}) : super(null);

  @override
  Stream<MyLoginState> mapEventToState(
    MyLoginEvent event,
  ) async* {
    try {
      if (event is RegisterEvent) {
        final result = await bookrefRepository.registerUser(
            event.email, event.username, event.password);

        yield RegisterFinishedState(error: _convertErrorResponse(result));
      } else if (event is LoginEvent) {
        final result =
            await bookrefRepository.loginUser(event.username, event.password);

        yield LoginFinishedState(
            data: _convertDataResponse(result),
            error: _convertErrorResponse(result));
      }
    } catch (_, stackTrace) {
      print('$_ $stackTrace');
      yield state;
    }
  }

  String _convertDataResponse(QueryResult queryResult) {
    return queryResult.data['singIn']['data'];
  }

  String _convertErrorResponse(QueryResult queryResult) {
    print("Helllllooooooo");
    print(queryResult.data);

    return queryResult.data['singIn']['errors']['messages'];
  }
}
