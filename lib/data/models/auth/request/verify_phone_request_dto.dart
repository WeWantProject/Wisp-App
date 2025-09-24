import 'package:freezed_annotation/freezed_annotation.dart';

part 'verify_phone_request_dto.freezed.dart';
part 'verify_phone_request_dto.g.dart';

@freezed
abstract class VerifyPhoneRequestDto with _$VerifyPhoneRequestDto {
  const factory VerifyPhoneRequestDto({
    required String phoneNumber,
    required String code,
  }) = _VerifyPhoneRequestDto;

  factory VerifyPhoneRequestDto.fromJson(Map<String, dynamic> json) =>
      _$VerifyPhoneRequestDtoFromJson(json);
}
