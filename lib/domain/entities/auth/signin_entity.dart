import 'package:freezed_annotation/freezed_annotation.dart';

part 'signin_entity.freezed.dart';

@freezed
abstract class SigInEntity with _$SigInEntity {
  const factory SigInEntity({
    required String phoneNumber,
    required String password,
  }) = _SigInEntity;
}
