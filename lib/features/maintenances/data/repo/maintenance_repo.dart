import 'package:UpDown/core/network/api/api_failure/api_failures.dart';
import 'package:UpDown/core/network/network_manager.dart';
import 'package:UpDown/features/maintenances/data/models/maintenance_view_model.dart';
import 'package:UpDown/features/maintenances/data/sources/local.dart';
import 'package:UpDown/features/maintenances/data/sources/remote.dart';
import 'package:either_dart/either.dart';
import 'package:rxdart/rxdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MaintenanceRepo {
  final MaintenanceLocalDataSource _local;
  final MaintenanceRemoteDataSource _remote;
  final NetworkManager _netManager;
  bool get isConnected => _netManager.isConnected;

  MaintenanceRepo(this._local, this._remote, this._netManager);

  Stream<Either<Failure, MaintenanceViewModel?>>
      streamCurrentMaintenance() async* {
    try {
      final local = await _local.getCurrent();
      if (local != null) {
        yield Right(local);
      }

      yield* Rx.merge([
        if (isConnected) _handleCurrentMaintainanceStream(true, local),
        _netManager.connectionStream
            .distinct()
            .where((connected) => connected)
            .asyncExpand((_) => _handleCurrentMaintainanceStream(true, local))
      ]);
    } on Failure catch (e) {
      yield Left(e);
    } catch (e) {
      yield Left(CustomFailure("تعذر تحميل أعمال الصيانة الحالية."));
    }
  }

  Stream<Either<Failure, MaintenanceViewModel?>>
      _handleCurrentMaintainanceStream(
          bool isConnected, MaintenanceViewModel? local) async* {
    if (!isConnected) return;

    final remoteStream =
        _remote.streamCurrentMaintenance().handleError((error) {
      if (error is RealtimeSubscribeException) {
        Future.delayed(Duration(seconds: 5), () {
          _remote.streamCurrentMaintenance();
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

  Future<Either<Failure, List<MaintenanceViewModel>>> fetchAllMaintenances(
      {int offset = 0, int limit = 5}) async {
    if (!isConnected) {
      final local = await _local.getAll();

      if (local.isNotEmpty) {
        return Right(local);
      }

      return const Left(CustomFailure("لا يوجد اتصال بالإنترنت."));
    }

    try {
      final remoteRes =
          await _remote.fetchAllMaintenances(offset: offset, limit: limit);

      if (remoteRes.isNotEmpty) await _local.saveAll(remoteRes);

      return Right(remoteRes);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(CustomFailure("تعذر تحميل أعمال الصيانة."));
    }
  }
}
