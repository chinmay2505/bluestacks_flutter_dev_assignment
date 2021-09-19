import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    print('AppBlocObserver::: onEvent : $event');
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print('AppBlocObserver::: onTransition : $transition');
    super.onTransition(bloc, transition);
  }

  @override
  void onChange(BlocBase blocBase, Change change) {
    print('AppBlocObserver::: blocBase :: onChange : $change');
    super.onChange(blocBase, change);
  }

  @override
  void onError(BlocBase blocBase, Object error, StackTrace stackTrace) {
    print('AppBlocObserver::: onError : $error $stackTrace');
    super.onError(blocBase, error, stackTrace);
  }
}
