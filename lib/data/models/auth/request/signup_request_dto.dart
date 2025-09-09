import 'package:freezed_annotation/freezed_annotation.dart';

part 'signup_request_dto.freezed.dart';

part 'signup_request_dto.g.dart';

@freezed
abstract class SignUpRequestDto with _$SignUpRequestDto {
  const factory SignUpRequestDto({
    required String phoneNumber,
    required String password,
  }) = _SignUpRequestDto;

  factory SignUpRequestDto.fromJson(Map<String, dynamic> json) =>
      _$SignUpRequestDtoFromJson(json);
}
