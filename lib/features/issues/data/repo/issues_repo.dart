import 'package:UpDown/core/network/api/api_failure.dart';
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

  Future<Either<Failure, void>> create(IssueRequestModel issueModel) async {
    try {
      final res = await _remote.createIssue(issueModel);
      return Right(res);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(CustomFailure((e as Failure).errMessage));
    }
  }

  // Stream building active issues
  Stream<Either<Failure, List<IssueResponseModel>>> streamBuildingActiveIssues(
      String buildingId) async* {
    try {
      final local = await _local.getIssuesForBuilding(buildingId);
      if (local.isNotEmpty) {
        yield Right(local);
      }

      yield* Rx.merge([
        if (isConnected)
          _handleBuildingActiveIssuesStream(true, local, buildingId),
        _netManager.connectionStream
            .distinct()
            .where((connected) => connected)
            .asyncExpand((_) =>
                _handleBuildingActiveIssuesStream(true, local, buildingId))
      ]);
    } on Failure catch (e) {
      yield Left(e);
    } catch (e) {
      yield Left(CustomFailure("تعذر تحميل الأعطال النشطة."));
    }
  }

  Stream<Either<Failure, List<IssueResponseModel>>>
      _handleBuildingActiveIssuesStream(bool isConnected,
          List<IssueResponseModel> local, String buildingId) async* {
    if (!isConnected) return;

    final remoteStream =
        _remote.fetchBuildingActiveIssues(buildingId).handleError((error) {
      if (error is RealtimeSubscribeException) {
        Future.delayed(Duration(seconds: 5), () {
          _remote.fetchBuildingActiveIssues(buildingId);
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

  // Stream elevator active issues
  Stream<Either<Failure, List<IssueResponseModel>>> streamElevatorActiveIssues(
      String elevatorId) async* {
    try {
      final local = await _local.getIssuesForElevator(elevatorId);
      if (local.isNotEmpty) {
        yield Right(local);
      }

      yield* Rx.merge([
        if (isConnected)
          _handleElevatorActiveIssuesStream(true, local, elevatorId),
        _netManager.connectionStream
            .distinct()
            .where((connected) => connected)
            .asyncExpand((_) =>
                _handleElevatorActiveIssuesStream(true, local, elevatorId))
      ]);
    } on Failure catch (e) {
      yield Left(e);
    } catch (e) {
      yield Left(CustomFailure("تعذر تحميل الأعطال النشطة."));
    }
  }

  Stream<Either<Failure, List<IssueResponseModel>>>
      _handleElevatorActiveIssuesStream(bool isConnected,
          List<IssueResponseModel> local, String elevatorId) async* {
    if (!isConnected) return;

    final remoteStream =
        _remote.fetchElevatorActiveIssues(elevatorId).handleError((error) {
      if (error is RealtimeSubscribeException) {
        Future.delayed(Duration(seconds: 5), () {
          _remote.fetchElevatorActiveIssues(elevatorId);
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

  // Stream all active issues
  Stream<Either<Failure, List<IssueResponseModel>>>
      streamAllActiveIssues() async* {
    try {
      final local = await _local.getAll();
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

    final remoteStream = _remote.fetchAllActiveIssues().handleError((error) {
      if (error is RealtimeSubscribeException) {
        Future.delayed(Duration(seconds: 5), () {
          _remote.fetchAllActiveIssues();
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
