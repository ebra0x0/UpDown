import 'dart:io';
import 'package:UpDown/features/account_setup/data/repos/account_setup_repo.dart';
import 'package:UpDown/features/profile/data/model/profile_request_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'account_setup_state.dart';

class AccountSetupCubit extends Cubit<AccountSetupState> {
  final AccountSetupRepo _repo;
  AccountSetupCubit(this._repo) : super(AccountSetupState());

  void setAvatar(File avatar) {
    emit(state.copyWith(avatarPath: avatar.path));
  }

  void setName(String? name) {
    emit(state.copyWith(name: name));
  }

  void setPhone(String? phone) {
    emit(state.copyWith(phone: phone));
  }

  void setAddress(String? address) {
    emit(state.copyWith(address: address));
  }

  Future<void> setup() async {
    if (state.status == AccountSetupStatus.loading) return;

    emit(state.copyWith(status: AccountSetupStatus.loading));

    final ProfileRequestModel profile = ProfileRequestModel(
      name: state.name!,
      phone: state.phone!,
      address: state.address!,
      imagePath: state.avatarPath,
    );
    final res = await _repo.setup(profile);

    res.fold(
      (f) => emit(state.copyWith(
        status: AccountSetupStatus.error,
        error: f.errMessage,
      )),
      (r) => emit(state.copyWith(
        status: AccountSetupStatus.success,
      )),
    );
  }
}
