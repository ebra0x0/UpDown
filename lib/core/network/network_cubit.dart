import 'package:UpDown/core/network/network_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum NetworkStatus { connected, disconnected }

class NetworkCubit extends Cubit<NetworkStatus> {
  NetworkCubit() : super(NetworkStatus.connected) {
    networkMonitor();
  }

  void networkMonitor() {
    NetworkManager.connectionStream.listen((status) {
      if (status) {
        emit(NetworkStatus.connected);
      } else {
        emit(NetworkStatus.disconnected);
      }
    });
  }
}
