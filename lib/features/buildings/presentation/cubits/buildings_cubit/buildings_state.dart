part of 'buildings_cubit.dart';

class BuildingsState {
  final ContentStatus status;
  final String? errorMsg;
  final List<BuildingModel>? buildings;
  final BuildingModel? currentBuilding;

  BuildingsState({
    this.status = ContentStatus.initial,
    this.errorMsg,
    this.buildings,
    this.currentBuilding,
  });

  BuildingsState copyWith({
    ContentStatus? status,
    String? errorMsg,
    List<BuildingModel>? buildings,
    BuildingModel? currentBuilding,
  }) =>
      BuildingsState(
        status: status ?? this.status,
        errorMsg: errorMsg ?? this.errorMsg,
        buildings: buildings ?? this.buildings,
        currentBuilding: currentBuilding ?? this.currentBuilding,
      );
}
