import 'package:wisp/domain/entities/auth/token_entity.dart';
import 'package:wisp/domain/repositories/auth/auth_repository.dart';

class RefreshTokenUseCase {
  final AuthRepository authRepository;

  RefreshTokenUseCase(this.authRepository);

  Future<TokenEntity> refreshToken(String refreshToken) async {
    return await authRepository.refreshToken(refreshToken);
  }
}
