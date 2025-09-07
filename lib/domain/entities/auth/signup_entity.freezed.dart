// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'signup_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SignUpEntity {
  String get userName;
  String get phoneNumber;
  String get password;
  String get displayName;

  /// Create a copy of SignUpEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SignUpEntityCopyWith<SignUpEntity> get copyWith =>
      _$SignUpEntityCopyWithImpl<SignUpEntity>(
          this as SignUpEntity, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SignUpEntity &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, userName, phoneNumber, password, displayName);

  @override
  String toString() {
    return 'SignUpEntity(userName: $userName, phoneNumber: $phoneNumber, password: $password, displayName: $displayName)';
  }
}

/// @nodoc
abstract mixin class $SignUpEntityCopyWith<$Res> {
  factory $SignUpEntityCopyWith(
          SignUpEntity value, $Res Function(SignUpEntity) _then) =
      _$SignUpEntityCopyWithImpl;
  @useResult
  $Res call(
      {String userName,
      String phoneNumber,
      String password,
      String displayName});
}

/// @nodoc
class _$SignUpEntityCopyWithImpl<$Res> implements $SignUpEntityCopyWith<$Res> {
  _$SignUpEntityCopyWithImpl(this._self, this._then);

  final SignUpEntity _self;
  final $Res Function(SignUpEntity) _then;

  /// Create a copy of SignUpEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userName = null,
    Object? phoneNumber = null,
    Object? password = null,
    Object? displayName = null,
  }) {
    return _then(_self.copyWith(
      userName: null == userName
          ? _self.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _self.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _self.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _self.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [SignUpEntity].
extension SignUpEntityPatterns on SignUpEntity {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_SignUpEntity value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SignUpEntity() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_SignUpEntity value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SignUpEntity():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_SignUpEntity value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SignUpEntity() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String userName, String phoneNumber, String password,
            String displayName)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SignUpEntity() when $default != null:
        return $default(_that.userName, _that.phoneNumber, _that.password,
            _that.displayName);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String userName, String phoneNumber, String password,
            String displayName)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SignUpEntity():
        return $default(_that.userName, _that.phoneNumber, _that.password,
            _that.displayName);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String userName, String phoneNumber, String password,
            String displayName)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SignUpEntity() when $default != null:
        return $default(_that.userName, _that.phoneNumber, _that.password,
            _that.displayName);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _SignUpEntity implements SignUpEntity {
  _SignUpEntity(
      {required this.userName,
      required this.phoneNumber,
      required this.password,
      required this.displayName});

  @override
  final String userName;
  @override
  final String phoneNumber;
  @override
  final String password;
  @override
  final String displayName;

  /// Create a copy of SignUpEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SignUpEntityCopyWith<_SignUpEntity> get copyWith =>
      __$SignUpEntityCopyWithImpl<_SignUpEntity>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SignUpEntity &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, userName, phoneNumber, password, displayName);

  @override
  String toString() {
    return 'SignUpEntity(userName: $userName, phoneNumber: $phoneNumber, password: $password, displayName: $displayName)';
  }
}

/// @nodoc
abstract mixin class _$SignUpEntityCopyWith<$Res>
    implements $SignUpEntityCopyWith<$Res> {
  factory _$SignUpEntityCopyWith(
          _SignUpEntity value, $Res Function(_SignUpEntity) _then) =
      __$SignUpEntityCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String userName,
      String phoneNumber,
      String password,
      String displayName});
}

/// @nodoc
class __$SignUpEntityCopyWithImpl<$Res>
    implements _$SignUpEntityCopyWith<$Res> {
  __$SignUpEntityCopyWithImpl(this._self, this._then);

  final _SignUpEntity _self;
  final $Res Function(_SignUpEntity) _then;

  /// Create a copy of SignUpEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? userName = null,
    Object? phoneNumber = null,
    Object? password = null,
    Object? displayName = null,
  }) {
    return _then(_SignUpEntity(
      userName: null == userName
          ? _self.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _self.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _self.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _self.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
