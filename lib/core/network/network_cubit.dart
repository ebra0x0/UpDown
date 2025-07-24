import 'dart:async';
import 'package:UpDown/core/network/network_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum NetworkStatus { connected, disconnected }

class NetworkCubit extends Cubit<NetworkStatus> {
  late StreamSubscription _subscription;
  final NetworkManager _networkManager;
  NetworkCubit(this._networkManager) : super(NetworkStatus.connected) {
    networkMonitor();
  }

  void networkMonitor() {
    _subscription = _networkManager.connectionStream.listen((status) {
      final newState =
          status ? NetworkStatus.connected : NetworkStatus.disconnected;
      if (state != newState) emit(newState);
    });
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
