import 'package:bloc/bloc.dart';
import 'package:bookref/blocs/navigation/navigation_event.dart';
import 'package:bookref/blocs/navigation/navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationReset());

  @override
  Stream<NavigationState> mapEventToState(NavigationEvent event) async* {
    if (event is ChangeNavigationOnMain) {
      yield* _mapChangeNavigationOnMainToState(event);
    }

    if (event is ChangeNavigationOnSub) {
      yield* _mapChangeNavigationOnSubToState(event);
    }
  }

  Stream<NavigationState> _mapChangeNavigationOnMainToState(
      ChangeNavigationOnMain event) async* {
    yield NavigationReset();
    yield NavigationOnMain(route: event.route);
  }

  Stream<NavigationState> _mapChangeNavigationOnSubToState(
      ChangeNavigationOnSub event) async* {
    yield NavigationReset();
    yield NavigationOnSub();
  }
}
