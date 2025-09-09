import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_sms_request_dto.freezed.dart';
part 'send_sms_request_dto.g.dart';

@freezed
abstract class SendSmsRequestDto with _$SendSmsRequestDto {
  const factory SendSmsRequestDto({
    required String phoneNumber,
  }) = _SendSmsRequestDto;

  factory SendSmsRequestDto.fromJson(Map<String, dynamic> json) =>
      _$SendSmsRequestDtoFromJson(json);
}
