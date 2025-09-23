import 'package:injectable/injectable.dart';
import 'package:wisp/domain/repositories/auth/auth_repository.dart';

@injectable
class LogoutUseCase {
  final AuthRepository authRepository;

  LogoutUseCase(this.authRepository);

  Future<void> logout(String refreshToken) async {
    await authRepository.logout(refreshToken);
  }
}
