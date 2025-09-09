import 'package:freezed_annotation/freezed_annotation.dart';

part 'signin_request_dto.freezed.dart';
part 'signin_request_dto.g.dart';

@freezed
abstract class SigninRequestDto with _$SigninRequestDto {
  const factory SigninRequestDto({
    required String phoneNumber,
    required String password,
  }) = _SigninRequestDto;

  factory SigninRequestDto.fromJson(Map<String, dynamic> json) =>
      _$SigninRequestDtoFromJson(json);
}
