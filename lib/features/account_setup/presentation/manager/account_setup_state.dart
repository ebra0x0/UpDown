part of 'account_setup_cubit.dart';

class AccountSetupState {
  final String? name;
  final String? phone;
  final String? address;
  final XFile? avatar;
  AccountSetupState({
    this.name,
    this.phone,
    this.address,
    this.avatar,
  });
  AccountSetupState copyWith({
    String? name,
    String? phone,
    String? address,
    XFile? avatar,
  }) {
    return AccountSetupState(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      avatar: avatar ?? avatar,
    );
  }
}

class AccountSetupInitial extends AccountSetupState {}

class AccountSetupLoading extends AccountSetupState {}

class AccountSetupSuccess extends AccountSetupState {}

class AccountSetupError extends AccountSetupState {
  final String error;

  AccountSetupError({required this.error});
}
