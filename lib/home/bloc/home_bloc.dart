import 'dart:async';
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
    on<UICreatedEvent>(listenConnectivityService);
    //on<LoadApiEvent>(onLoadApiEvent);
    //on<NoInternetEvent>(onNoInternetEvent);
  }

  FutureOr<void> onNoInternet( emit) {
    emit(HomeNoInternetState());
  }

  void listenConnectivityService(event, emit) {
    _connectivityService.connectivityStream.stream.listen((event) async {
      if (event == ConnectivityResult.none) {
        print('No Internet');
        onNoInternet(emit);
      } else {
        print('Yes Internet');
        await onLoadApi(emit);
      }
    });
  }

  FutureOr<void> onLoadApi(emit) async {
    emit(HomeLoadingState());
    final activity = await _boredService.getBoredModel();
    emit(HomeLoadedState(
        activity.activity, activity.type, activity.participants));
  }
}
