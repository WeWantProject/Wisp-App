import 'package:wisp/domain/repositories/auth/auth_repository.dart';

class ChangePasswordUsecase {
  final AuthRepository authRepository;

  ChangePasswordUsecase(this.authRepository);

  Future<void> call(String phoneNumber, String newPassword) async {
    return await authRepository.ChangePassword(phoneNumber, newPassword);
  }
}
