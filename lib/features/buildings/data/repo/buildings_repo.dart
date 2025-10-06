import 'dart:async';
import 'package:UpDown/core/network/api/api_failure.dart';
import 'package:UpDown/core/network/network_manager.dart';
import 'package:UpDown/features/buildings/data/models/building_model.dart';
import 'package:UpDown/features/buildings/data/sources/local.dart';
import 'package:UpDown/features/buildings/data/sources/remote.dart';
import 'package:collection/collection.dart';
import 'package:either_dart/either.dart';
import 'package:rxdart/rxdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BuildingsRepo {
  final BuildingsLocalDataSource _local;
  final BuildingsRemoteDataSource _remote;
  final NetworkManager _netManager;

  bool get isConnected => _netManager.isConnected;

  BuildingsRepo(this._local, this._remote, this._netManager);

  Stream<Either<Failure, List<BuildingModel>>> getAll() async* {
    try {
      final local = await _local.getAll();
      if (local.isNotEmpty) {
        yield Right(local);
      }

      yield* Rx.merge([
        if (isConnected) _handleGetAllBuildingsStream(true, local),
        _netManager.connectionStream
            .distinct()
            .where((connected) => connected)
            .asyncExpand((_) => _handleGetAllBuildingsStream(true, local)),
      ]);
    } on Failure catch (e) {
      yield Left(e);
    } catch (_) {
      yield Left(CustomFailure("تعذر تحميل الأبنية."));
    }
  }

  Stream<Either<Failure, List<BuildingModel>>> _handleGetAllBuildingsStream(
      bool isConnected, List<BuildingModel> local) async* {
    if (!isConnected) return;
    final remoteStream = _remote.getAll().handleError((error) {
      if (error is RealtimeSubscribeException) {
        Future.delayed(Duration(seconds: 5), () {
          _remote.getAll();
        });
      }
    });

    yield* remoteStream.asyncMap((remoteRes) async {
      try {
        if (remoteRes.isEmpty) {
          await _local.clear();
          return const Right([]);
        }

        final bool isSame =
            const UnorderedIterableEquality().equals(local, remoteRes);

        if (!isSame) {
          await _local.saveAll(remoteRes);
        }
        return Right(remoteRes);
      } catch (e) {
        return Right(remoteRes);
      }
    });
  }
}
