import 'dart:async';
import 'dart:developer';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/utils/helper/sort_list.dart';
import 'package:UpDown/features/issues/data/models/issue_response_model.dart';
import 'package:UpDown/features/issues/data/repo/issues_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'issues_state.dart';

class IssuesCubit extends Cubit<IssuesState> {
  IssuesCubit(this._repo) : super(IssuesState());

  final IssuesRepo _repo;
  StreamSubscription? _streamAllSubscription;
  StreamSubscription? _streamBuildingSubscription;
  StreamSubscription? _streamElevatorSubscription;

  void emitStreamAllActive() {
    if (state.status == ContentStatus.loading ||
        _streamAllSubscription != null) {
      return;
    }

    emit(
      state.copyWith(
        status: ContentStatus.loading,
        issues: List.generate(
          2,
          (_) => IssueResponseModel.empty(),
        ),
      ),
    );

    _streamAllSubscription = _repo.streamAllActiveIssues().listen((stream) {
      if (isClosed) return;
      stream.fold(
        (errMsg) => emit(state.copyWith(
          status: ContentStatus.error,
          errorMsg: errMsg.errMessage,
        )),
        (issues) {
          final List<IssueResponseModel> orderedIssues =
              sortList(issues, (issue) => issue.updatedAt ?? issue.createdAt);
          emit(state.copyWith(
            status: ContentStatus.loaded,
            issues: orderedIssues,
          ));
        },
      );
    }, onError: (e) {
      log(e.toString());
      if (isClosed) return;
      if (state.issues != null) return;
      emit(state.copyWith(
        status: ContentStatus.error,
        errorMsg: e.toString(),
      ));
    });
  }

  void emitStreamAllActiveForBuilding(String buildingId) {
    if (state.status == ContentStatus.loading ||
        _streamBuildingSubscription != null) {
      return;
    }

    emit(state.copyWith(status: ContentStatus.loading));

    _streamBuildingSubscription =
        _repo.streamBuildingActiveIssues(buildingId).listen((stream) {
      if (isClosed) return;
      stream.fold(
        (errMsg) => emit(state.copyWith(
            status: ContentStatus.error, errorMsg: errMsg.errMessage)),
        (issues) {
          final List<IssueResponseModel> orderedIssues =
              sortList(issues, (issue) => issue.updatedAt ?? issue.createdAt);
          emit(state.copyWith(
            status: ContentStatus.loaded,
            issues: orderedIssues,
          ));
        },
      );
    }, onError: (e) {
      log(e.toString());
      if (isClosed) return;
      if (state.issues != null) return;
      emit(state.copyWith(status: ContentStatus.error, errorMsg: e.toString()));
    });
  }

  void emitStreamAllActiveForElevator(String elevatorId) {
    if (state.status == ContentStatus.loading ||
        _streamElevatorSubscription != null) {
      return;
    }

    emit(state.copyWith(status: ContentStatus.loading));

    _streamElevatorSubscription =
        _repo.streamElevatorActiveIssues(elevatorId).listen((stream) {
      if (isClosed) return;
      stream.fold(
        (errMsg) => emit(state.copyWith(
            status: ContentStatus.error, errorMsg: errMsg.errMessage)),
        (issues) {
          final List<IssueResponseModel> orderedIssues =
              sortList(issues, (issue) => issue.updatedAt ?? issue.createdAt);
          emit(state.copyWith(
            status: ContentStatus.loaded,
            issues: orderedIssues,
          ));
        },
      );
    }, onError: (e) {
      log(e.toString());
      if (isClosed) return;
      if (state.issues != null) return;
      emit(state.copyWith(status: ContentStatus.error, errorMsg: e.toString()));
    });
  }

  @override
  Future<void> close() {
    _streamAllSubscription?.cancel();
    _streamBuildingSubscription?.cancel();
    _streamElevatorSubscription?.cancel();
    return super.close();
  }
}
