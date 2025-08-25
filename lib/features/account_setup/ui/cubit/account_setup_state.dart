part of 'account_setup_cubit.dart';

enum AccountSetupStatus { initial, loading, success, error }

class AccountSetupState {
  final AccountSetupStatus status;
  final String? error;
  final String? name;
  final String? phone;
  final String? address;
  final String? avatarPath;
  AccountSetupState({
    this.status = AccountSetupStatus.initial,
    this.error,
    this.name,
    this.phone,
    this.address,
    this.avatarPath,
  });
  AccountSetupState copyWith({
    AccountSetupStatus? status,
    String? error,
    String? name,
    String? phone,
    String? address,
    String? avatarPath,
  }) {
    return AccountSetupState(
      status: status ?? this.status,
      error: error ?? this.error,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      avatarPath: avatarPath ?? this.avatarPath,
    );
  }
}
