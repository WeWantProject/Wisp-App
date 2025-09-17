import 'package:injectable/injectable.dart';
import 'package:wisp/domain/repositories/auth/auth_repository.dart';

@injectable
class LogoutUsecase {
  final AuthRepository authRepository;

  LogoutUsecase(this.authRepository);

  Future<void> logount(String refreshToken) async {
    await authRepository.logout(refreshToken);
  }
}
