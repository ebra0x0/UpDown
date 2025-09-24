import 'package:UpDown/core/network/api/api_failure.dart';
import 'package:UpDown/core/network/network_manager.dart';
import 'package:UpDown/features/maintenance/data/models/maintenanace_model.dart';
import 'package:UpDown/features/maintenance/data/sources/local.dart';
import 'package:UpDown/features/maintenance/data/sources/remote.dart';
import 'package:either_dart/either.dart';
import 'package:rxdart/rxdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MaintenanceRepo {
  final MaintenanceLocalDataSource _local;
  final MaintenanceRemoteDataSource _remote;

  final NetworkManager _netManager;
  bool get isConnected => _netManager.isConnected;

  MaintenanceRepo(this._local, this._remote, this._netManager);

  Stream<Either<Failure, MaintenanceModel?>> streamActiveMaintenance() async* {
    try {
      final local = await _local.getActive();
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

  Stream<Either<Failure, MaintenanceModel?>> _handleCurrentMaintainanceStream(
      bool isConnected, MaintenanceModel? local) async* {
    if (!isConnected) return;

    final remoteStream = _remote.streamActiveMaintenance().handleError((error) {
      if (error is RealtimeSubscribeException) {
        Future.delayed(Duration(seconds: 5), () {
          _remote.streamActiveMaintenance();
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
}
