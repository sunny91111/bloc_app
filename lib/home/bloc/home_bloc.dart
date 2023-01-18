import 'package:bloc_app/home/bloc/home_event.dart';
import 'package:bloc_app/home/bloc/home_state.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/boredService.dart';
import '../../services/connectivityService.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final BoredService _boredService;
  final ConnectivityService _connectivityService;

  HomeBloc(this._boredService, this._connectivityService)
      : super(HomeLoadingState()) {
    _connectivityService.connectivityStream.stream.listen((event) {
      if (event == ConnectivityResult.none) {
        print('No Internet');
        add(NoInternetEvent());
      } else {
        print('Yes Internet');
        add(LoadApiEvent());
      }
    });

    on<LoadApiEvent>((event, emit) async {
      emit(HomeLoadingState());
      final activity = await _boredService.getBoredActivity();
      emit(HomeLoadedState(
          activity.activity, activity.type, activity.participants));
    });

    on<NoInternetEvent>((event, emit) {
      emit(HomeNoInternetState());
    });
  }
}
