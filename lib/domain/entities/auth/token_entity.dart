import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_entity.freezed.dart';

@freezed
abstract class TokenEntity with _$TokenEntity {
  factory TokenEntity({
    required String accessToken,
    required String refreshToken,
  }) = _TokenEntity;
}
