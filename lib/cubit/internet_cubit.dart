import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum InternetConnectionState { Initial, Lost, Gained }

class InternetCubit extends Cubit<InternetConnectionState> {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription? _connectivitySubscription;

  InternetCubit() : super(InternetConnectionState.Initial) {
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        emit(InternetConnectionState.Gained);
      } else {
        emit(InternetConnectionState.Lost);
      }
    });
  }

  @override
  Future<void> close() {
    _connectivitySubscription?.cancel();
    return super.close();
  }
}
