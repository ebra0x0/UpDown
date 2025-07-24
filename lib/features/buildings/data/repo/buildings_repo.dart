import 'dart:async';
import 'package:UpDown/core/network/api_failure.dart';
import 'package:UpDown/features/buildings/data/models/building_model.dart';
import 'package:UpDown/features/buildings/data/sources/local.dart';
import 'package:UpDown/features/buildings/data/sources/remote.dart';
import 'package:either_dart/either.dart';

class BuildingsRepo {
  final BuildingsLocalDataSource _local;
  final BuildingsRemoteDataSource _remote;

  BuildingsRepo(this._local, this._remote);

  Stream<Either<Failure, BuildingModel?>> get(String buildingId) async* {
    try {
      final localResult = await _local.get(buildingId);

      if (localResult != null) {
        yield Right(localResult);
      }

      yield* _remote.get(buildingId).asyncMap((remoteResult) async {
        if (remoteResult != null) {
          await _local.save(remoteResult);
        }
        return Right(remoteResult);
      });
    } on Failure catch (e) {
      yield Left(e);
    } catch (e) {
      yield Left(CustomFailure((e as Failure).errMessage));
    }
  }

  Stream<Either<Failure, List<BuildingModel>>> getAll() async* {
    try {
      final localResult = await _local.getAll();
      if (localResult.isNotEmpty) {
        yield Right(localResult);
      }

      yield* _remote.getAll().asyncMap((remoteResult) async {
        if (remoteResult.isNotEmpty) {
          await _local.saveAll(remoteResult);
        }
        return Right(remoteResult);
      });
    } on Failure catch (e) {
      yield Left(e);
    } catch (e) {
      yield Left(CustomFailure((e as Failure).errMessage));
    }
  }
}
