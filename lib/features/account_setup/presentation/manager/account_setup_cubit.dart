import 'package:UpDown/core/utils/model/profile_model.dart';
import 'package:UpDown/features/account_setup/data/repos/account_setup_repo.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'account_setup_state.dart';

class AccountSetupCubit extends Cubit<AccountSetupState> {
  final AccountSetupRepo _repo;
  AccountSetupCubit(this._repo) : super(AccountSetupInitial());

  void setAvatar(XFile avatar) {
    emit(state.copyWith(avatar: avatar));
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

  Future<void> call() async {
    emit(AccountSetupLoading());
    final ProfileModel profile = ProfileModel.fromJson(
      {
        "name": state.name,
        "phone": state.phone,
        "address": state.address,
        "imagePath": state.avatar?.path,
      },
    );
    final res = _repo.setup(profile);
    res.fold(
      (f) => emit(AccountSetupError(error: f.errMessage)),
      (r) => emit(AccountSetupSuccess()),
    );
  }
}
