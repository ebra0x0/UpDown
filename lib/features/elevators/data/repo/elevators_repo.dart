import 'dart:developer';

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

  ElevatorsRepo(this._local, this._remote, this._netManager);

  Stream<Either<Failure, ElevatorModel?>> streamElevatorDetails(
      String elevatorId) async* {
    try {
      final local = await _local.get(elevatorId);
      if (local != null) {
        yield Right(local);
      }

      yield* Rx.merge([
        if (isConnected) _handleElevatorStream(true, local, elevatorId),
        _netManager.connectionStream
            .distinct()
            .where((connected) => connected)
            .asyncExpand((_) => _handleElevatorStream(true, local, elevatorId))
      ]);
    } on Failure catch (e) {
      yield Left(e);
    } catch (e) {
      yield Left(CustomFailure("تعذر تحميل بيانات المصعد."));
    }
  }

  Stream<Either<Failure, ElevatorModel?>> _handleElevatorStream(
      bool isConnected, ElevatorModel? local, String elevatorId) async* {
    if (!isConnected) return;

    final remoteStream =
        _remote.fetchElevatorDetails(elevatorId).handleError((error) {
      if (error is RealtimeSubscribeException) {
        Future.delayed(Duration(seconds: 5), () {
          _remote.fetchElevatorDetails(elevatorId);
        });
      }
    });

    yield* remoteStream.asyncMap((remoteRes) async {
      try {
        if (remoteRes == null) {
          await _local.clear();
          return const Right(null);
        }

        if (remoteRes != local) {
          await _local.save(remoteRes);
        }

        return Right(remoteRes);
      } catch (e) {
        return Right(remoteRes);
      }
    });
  }

  Stream<Either<Failure, List<ElevatorModel>>> streamBuildingElevators(
      String buildingId) async* {
    try {
      final local = await _local.getByBuilding(buildingId);

      if (local.isNotEmpty) {
        yield Right(local);
      }

      yield* Rx.merge([
        if (isConnected)
          _handleBuildingElevatorsStream(true, local, buildingId),
        _netManager.connectionStream
            .distinct()
            .where((connected) => connected)
            .asyncExpand(
                (_) => _handleBuildingElevatorsStream(true, local, buildingId))
      ]);
    } on Failure catch (e) {
      yield Left(e);
    } catch (e) {
      yield Left(CustomFailure("تعذر تحميل مصاعد المبنى."));
    }
  }

  Stream<Either<Failure, List<ElevatorModel>>> _handleBuildingElevatorsStream(
      bool isConnected, List<ElevatorModel> local, String buildingId) async* {
    if (!isConnected) return;

    final remoteStream =
        _remote.fetchBuildingElevators(buildingId).handleError((error) {
      log(error.toString());
      if (error is RealtimeSubscribeException) {
        Future.delayed(Duration(seconds: 5), () {
          _remote.fetchBuildingElevators(buildingId);
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

  Stream<Either<Failure, List<ElevatorModel>>> streamBuildingsElevators(
      List<String> buildingIds) async* {
    try {
      final localRes = await Future.wait(
        buildingIds.map((id) => _local.getByBuilding(id)),
      );
      final local = localRes.expand((e) => e).toList();

      if (local.isNotEmpty) {
        yield Right(local);
      }

      yield* Rx.merge([
        if (isConnected)
          _handleBuildingsElevatorsStream(true, local, buildingIds),
        _netManager.connectionStream
            .distinct()
            .where((connected) => connected)
            .asyncExpand((_) =>
                _handleBuildingsElevatorsStream(true, local, buildingIds))
      ]);
    } on Failure catch (e) {
      yield Left(e);
    } catch (e) {
      yield Left(CustomFailure("تعذر تحميل مصاعد المباني."));
    }
  }

  Stream<Either<Failure, List<ElevatorModel>>> _handleBuildingsElevatorsStream(
      bool isConnected,
      List<ElevatorModel> local,
      List<String> buildingIds) async* {
    if (!isConnected) return;

    final remoteStream =
        _remote.streamBuildingsElevators(buildingIds).handleError((error) {
      if (error is RealtimeSubscribeException) {
        Future.delayed(Duration(seconds: 5), () {
          _remote.streamBuildingsElevators(buildingIds);
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
