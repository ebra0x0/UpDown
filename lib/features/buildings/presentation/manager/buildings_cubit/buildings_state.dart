part of 'buildings_cubit.dart';

enum BuildingsStates { initial, loading, loaded, error }

class BuildingsState {
  BuildingsStates status;
  String? errorMsg;
  List<BuildingSummaryModel>? buildings;

  BuildingsState({
    this.status = BuildingsStates.initial,
    this.errorMsg,
    this.buildings,
  });

  BuildingsState copyWith({
    BuildingsStates? status,
    String? errorMsg,
    List<BuildingSummaryModel>? buildings,
  }) =>
      BuildingsState(
        status: status ?? this.status,
        errorMsg: errorMsg ?? this.errorMsg,
        buildings: buildings ?? this.buildings,
      );
}
