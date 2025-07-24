part of 'buildings_cubit.dart';

class BuildingsState {
  ContentStatus status;
  String? errorMsg;
  List<BuildingModel>? buildings;

  BuildingsState({
    this.status = ContentStatus.initial,
    this.errorMsg,
    this.buildings,
  });

  BuildingsState copyWith({
    ContentStatus? status,
    String? errorMsg,
    List<BuildingModel>? buildings,
  }) =>
      BuildingsState(
        status: status ?? this.status,
        errorMsg: errorMsg ?? this.errorMsg,
        buildings: buildings ?? this.buildings,
      );
}
