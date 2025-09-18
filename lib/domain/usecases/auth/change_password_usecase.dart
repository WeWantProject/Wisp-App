import 'package:injectable/injectable.dart';
import 'package:wisp/domain/repositories/auth/auth_repository.dart';

@injectable
class ChangePasswordUseCase {
  final AuthRepository authRepository;

  ChangePasswordUseCase(this.authRepository);

  Future<void> changePassword(String phoneNumber, String newPassword) async {
    return await authRepository.changePassword(phoneNumber, newPassword);
  }
}
