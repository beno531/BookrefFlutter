import 'package:bookref/Bloc/login_bloc/login_events.dart';
import 'package:bookref/Bloc/login_bloc/login_states.dart';
import 'package:bookref/services/bookref_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MyLoginBloc extends Bloc<MyLoginEvent, MyLoginState> {
  final BookrefRepository bookrefRepository;
  final GlobalKey<NavigatorState> navigatorKey;

  MyLoginBloc({@required this.bookrefRepository, this.navigatorKey})
      : super(null);

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

        var token = _convertDataResponse(result);
        if (token != null) {
          final storage = new FlutterSecureStorage();

          await storage.write(key: "token", value: token);
        }

        //navigatorKey.currentState.pushNamed("/dahsboard");

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
    try {
      return queryResult.data['singIn']['errors']['messages'];
    } catch (e) {
      return "";
    }
  }
}
