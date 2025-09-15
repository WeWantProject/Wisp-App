import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wisp/core/enum/user_role.dart';

part 'signin_response_dto.g.dart';
part 'signin_response_dto.freezed.dart';

@freezed
abstract class SignInResponseDto with _$SignInResponseDto {
  const factory SignInResponseDto({
    required String accessToken,
    required String refreshToken,
    required DateTime accessTokenExpiration,
    required DateTime refreshTokenExpiration,
    required UserRole role,
  }) = _SignInResponseDto;

  factory SignInResponseDto.fromJson(Map<String, dynamic> json) =>
      _$SignInResponseDtoFromJson(json);
}
