import 'package:UpDown/core/network/api/api_failure/api_failures.dart';
import 'package:UpDown/core/network/network_manager.dart';
import 'package:UpDown/features/issues/data/models/issue_request_model.dart';
import 'package:UpDown/features/issues/data/models/issue_response_model.dart';
import 'package:UpDown/features/issues/data/sources/local.dart';
import 'package:UpDown/features/issues/data/sources/remote.dart';
import 'package:either_dart/either.dart';
import 'package:rxdart/rxdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class IssuesRepo {
  final IssuesLocalDataSource _local;
  final IssuesRemoteDataSource _remote;
  final NetworkManager _netManager;
  bool get isConnected => _netManager.isConnected;

  IssuesRepo(this._local, this._remote, this._netManager);

  Future<Either<Failure, void>> createIssue(
      IssueRequestModel issueModel) async {
    try {
      final res = await _remote.createIssue(issueModel);
      return Right(res);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(CustomFailure((e as Failure).errMessage));
    }
  }

  // Stream all active issues
  Stream<Either<Failure, List<IssueResponseModel>>>
      streamAllActiveIssues() async* {
    try {
      final local = await _local.getList();
      if (local.isNotEmpty) {
        yield Right(local);
      }

      yield* Rx.merge([
        if (isConnected) _handleAllActiveIssuesStream(true, local),
        _netManager.connectionStream
            .distinct()
            .where((connected) => connected)
            .asyncExpand((_) => _handleAllActiveIssuesStream(true, local))
      ]);
    } on Failure catch (e) {
      yield Left(e);
    } catch (e) {
      yield Left(CustomFailure("تعذر تحميل الأعطال النشطة."));
    }
  }

  Stream<Either<Failure, List<IssueResponseModel>>>
      _handleAllActiveIssuesStream(
          bool isConnected, List<IssueResponseModel> local) async* {
    if (!isConnected) return;

    final remoteStream = _remote.streamAllActiveIssues().handleError((error) {
      if (error is RealtimeSubscribeException) {
        Future.delayed(Duration(seconds: 5), () {
          _remote.streamAllActiveIssues();
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

  Future<Either<Failure, List<IssueResponseModel>>> getIssues(
      {int offset = 0, int limit = 5}) async {
    try {
      final local = await _local.getList(offset: offset, limit: limit);
      if (local.isNotEmpty) {
        return Right(local);
      }

      final remote = await _remote.fetchIssues(offset: offset, limit: limit);
      if (remote.isNotEmpty) {
        await _local.saveAll(remote);
      }
      return Right(remote);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(CustomFailure("تعذر تحميل الأعطال."));
    }
  }

  Future<Either<Failure, List<IssueResponseModel>>> getBuildingIssues(
      {required String buildingId, int offset = 0, int limit = 5}) async {
    try {
      final local = await _local.getBuildingIssues(
          buildingId: buildingId, offset: offset, limit: limit);
      if (local.isNotEmpty) {
        return Right(local);
      }

      final remote = await _remote.fetchBuildingIssues(
          buildingId: buildingId, offset: offset, limit: limit);

      if (remote.isNotEmpty) {
        await _local.saveAll(remote);
      }

      return Right(remote);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(CustomFailure("تعذر تحميل اعطال المبنى."));
    }
  }

  Future<Either<Failure, List<IssueResponseModel>>> getElevatorIssues(
      {required String elevatorId, int offset = 0, int limit = 5}) async {
    try {
      final local = await _local.getElevatorIssues(
          elevatorId: elevatorId, offset: offset, limit: limit);
      if (local.isNotEmpty) {
        return Right(local);
      }

      final remote = await _remote.fetchElevatorIssues(
          elevatorId: elevatorId, offset: offset, limit: limit);

      if (remote.isNotEmpty) {
        await _local.saveAll(remote);
      }

      return Right(remote);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(CustomFailure("تعذر تحميل اعطال المصعد."));
    }
  }
}
