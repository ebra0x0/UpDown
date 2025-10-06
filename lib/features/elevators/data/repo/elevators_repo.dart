import 'package:UpDown/core/network/api/api_failure.dart';
import 'package:UpDown/core/network/network_manager.dart';
import 'package:UpDown/features/elevators/data/models/elevator_model.dart';
import 'package:UpDown/features/elevators/data/sources/local.dart';
import 'package:UpDown/features/elevators/data/sources/remote.dart';
import 'package:either_dart/either.dart';
import 'package:rxdart/rxdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ElevatorsRepo {
  final ElevatorsLocalDataSource _local;
  final ElevatorsRemoteDataSource _remote;
  final NetworkManager _netManager;
  bool get isConnected => _netManager.isConnected;

  final Map<String, Stream<Either<Failure, List<ElevatorModel>>>> _streamCache =
      {};

  ElevatorsRepo(this._local, this._remote, this._netManager);

  Stream<Either<Failure, List<ElevatorModel>>> streamAllElevators() {
    const key = 'all';
    if (_streamCache.containsKey(key)) return _streamCache[key]!;

    final stream = _buildAllElevatorsStream().shareReplay(maxSize: 1);
    _streamCache[key] = stream;
    return stream;
  }

  Stream<Either<Failure, List<ElevatorModel>>>
      _buildAllElevatorsStream() async* {
    try {
      final local = await _local.getAll();
      if (local.isNotEmpty) yield Right(local);

      yield* Rx.merge([
        if (isConnected) _handleAllElevatorsStream(true, local),
        _netManager.connectionStream
            .distinct()
            .where((connected) => connected)
            .asyncExpand((_) => _handleAllElevatorsStream(true, local))
      ]);
    } on Failure catch (e) {
      yield Left(e);
    } catch (_) {
      yield Left(CustomFailure("تعذر تحميل المصاعد."));
    }
  }

  Stream<Either<Failure, List<ElevatorModel>>> _handleAllElevatorsStream(
      bool isConnected, List<ElevatorModel> local) async* {
    if (!isConnected) return;

    final remoteStream = _remote.streamAllElevators().handleError((error) {
      if (error is RealtimeSubscribeException) {
        Future.delayed(Duration(seconds: 5), () {
          _remote.streamAllElevators();
        });
      }
    });

    yield* remoteStream.asyncMap((remoteRes) async {
      try {
        if (remoteRes.isEmpty) {
          await _local.clear();
          return const Right([]);
        }

        if (remoteRes != local) {
          await _local.saveAll(remoteRes);
        }

        return Right(remoteRes);
      } catch (e) {
        return Right(remoteRes);
      }
    });
  }
}
