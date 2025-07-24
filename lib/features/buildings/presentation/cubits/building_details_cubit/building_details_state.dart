part of 'building_details_cubit.dart';

class BuildingDetailsState {
  final ContentStatus status;
  final String? errorMsg;
  final BuildingModel? building;

  BuildingDetailsState({
    this.status = ContentStatus.initial,
    this.errorMsg,
    this.building,
  });

  BuildingDetailsState copyWith({
    ContentStatus? status,
    String? errorMsg,
    BuildingModel? building,
  }) =>
      BuildingDetailsState(
        status: status ?? this.status,
        errorMsg: errorMsg ?? this.errorMsg,
        building: building ?? this.building,
      );
}
