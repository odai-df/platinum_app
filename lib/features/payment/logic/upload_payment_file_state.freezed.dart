// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'upload_payment_file_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UploadPaymentFileState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(int paymentId) loading,
    required TResult Function(int paymentId, PaymentUploadData data) success,
    required TResult Function(int paymentId, String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(int paymentId)? loading,
    TResult? Function(int paymentId, PaymentUploadData data)? success,
    TResult? Function(int paymentId, String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(int paymentId)? loading,
    TResult Function(int paymentId, PaymentUploadData data)? success,
    TResult Function(int paymentId, String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UploadPaymentFileInitial value) initial,
    required TResult Function(UploadPaymentFileLoading value) loading,
    required TResult Function(UploadPaymentFileSuccess value) success,
    required TResult Function(UploadPaymentFileError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UploadPaymentFileInitial value)? initial,
    TResult? Function(UploadPaymentFileLoading value)? loading,
    TResult? Function(UploadPaymentFileSuccess value)? success,
    TResult? Function(UploadPaymentFileError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UploadPaymentFileInitial value)? initial,
    TResult Function(UploadPaymentFileLoading value)? loading,
    TResult Function(UploadPaymentFileSuccess value)? success,
    TResult Function(UploadPaymentFileError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UploadPaymentFileStateCopyWith<$Res> {
  factory $UploadPaymentFileStateCopyWith(UploadPaymentFileState value,
          $Res Function(UploadPaymentFileState) then) =
      _$UploadPaymentFileStateCopyWithImpl<$Res, UploadPaymentFileState>;
}

/// @nodoc
class _$UploadPaymentFileStateCopyWithImpl<$Res,
        $Val extends UploadPaymentFileState>
    implements $UploadPaymentFileStateCopyWith<$Res> {
  _$UploadPaymentFileStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UploadPaymentFileState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$UploadPaymentFileInitialImplCopyWith<$Res> {
  factory _$$UploadPaymentFileInitialImplCopyWith(
          _$UploadPaymentFileInitialImpl value,
          $Res Function(_$UploadPaymentFileInitialImpl) then) =
      __$$UploadPaymentFileInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UploadPaymentFileInitialImplCopyWithImpl<$Res>
    extends _$UploadPaymentFileStateCopyWithImpl<$Res,
        _$UploadPaymentFileInitialImpl>
    implements _$$UploadPaymentFileInitialImplCopyWith<$Res> {
  __$$UploadPaymentFileInitialImplCopyWithImpl(
      _$UploadPaymentFileInitialImpl _value,
      $Res Function(_$UploadPaymentFileInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of UploadPaymentFileState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$UploadPaymentFileInitialImpl implements UploadPaymentFileInitial {
  const _$UploadPaymentFileInitialImpl();

  @override
  String toString() {
    return 'UploadPaymentFileState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UploadPaymentFileInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(int paymentId) loading,
    required TResult Function(int paymentId, PaymentUploadData data) success,
    required TResult Function(int paymentId, String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(int paymentId)? loading,
    TResult? Function(int paymentId, PaymentUploadData data)? success,
    TResult? Function(int paymentId, String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(int paymentId)? loading,
    TResult Function(int paymentId, PaymentUploadData data)? success,
    TResult Function(int paymentId, String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UploadPaymentFileInitial value) initial,
    required TResult Function(UploadPaymentFileLoading value) loading,
    required TResult Function(UploadPaymentFileSuccess value) success,
    required TResult Function(UploadPaymentFileError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UploadPaymentFileInitial value)? initial,
    TResult? Function(UploadPaymentFileLoading value)? loading,
    TResult? Function(UploadPaymentFileSuccess value)? success,
    TResult? Function(UploadPaymentFileError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UploadPaymentFileInitial value)? initial,
    TResult Function(UploadPaymentFileLoading value)? loading,
    TResult Function(UploadPaymentFileSuccess value)? success,
    TResult Function(UploadPaymentFileError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class UploadPaymentFileInitial implements UploadPaymentFileState {
  const factory UploadPaymentFileInitial() = _$UploadPaymentFileInitialImpl;
}

/// @nodoc
abstract class _$$UploadPaymentFileLoadingImplCopyWith<$Res> {
  factory _$$UploadPaymentFileLoadingImplCopyWith(
          _$UploadPaymentFileLoadingImpl value,
          $Res Function(_$UploadPaymentFileLoadingImpl) then) =
      __$$UploadPaymentFileLoadingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int paymentId});
}

/// @nodoc
class __$$UploadPaymentFileLoadingImplCopyWithImpl<$Res>
    extends _$UploadPaymentFileStateCopyWithImpl<$Res,
        _$UploadPaymentFileLoadingImpl>
    implements _$$UploadPaymentFileLoadingImplCopyWith<$Res> {
  __$$UploadPaymentFileLoadingImplCopyWithImpl(
      _$UploadPaymentFileLoadingImpl _value,
      $Res Function(_$UploadPaymentFileLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of UploadPaymentFileState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paymentId = null,
  }) {
    return _then(_$UploadPaymentFileLoadingImpl(
      null == paymentId
          ? _value.paymentId
          : paymentId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$UploadPaymentFileLoadingImpl implements UploadPaymentFileLoading {
  const _$UploadPaymentFileLoadingImpl(this.paymentId);

  @override
  final int paymentId;

  @override
  String toString() {
    return 'UploadPaymentFileState.loading(paymentId: $paymentId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UploadPaymentFileLoadingImpl &&
            (identical(other.paymentId, paymentId) ||
                other.paymentId == paymentId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, paymentId);

  /// Create a copy of UploadPaymentFileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UploadPaymentFileLoadingImplCopyWith<_$UploadPaymentFileLoadingImpl>
      get copyWith => __$$UploadPaymentFileLoadingImplCopyWithImpl<
          _$UploadPaymentFileLoadingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(int paymentId) loading,
    required TResult Function(int paymentId, PaymentUploadData data) success,
    required TResult Function(int paymentId, String message) error,
  }) {
    return loading(paymentId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(int paymentId)? loading,
    TResult? Function(int paymentId, PaymentUploadData data)? success,
    TResult? Function(int paymentId, String message)? error,
  }) {
    return loading?.call(paymentId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(int paymentId)? loading,
    TResult Function(int paymentId, PaymentUploadData data)? success,
    TResult Function(int paymentId, String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(paymentId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UploadPaymentFileInitial value) initial,
    required TResult Function(UploadPaymentFileLoading value) loading,
    required TResult Function(UploadPaymentFileSuccess value) success,
    required TResult Function(UploadPaymentFileError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UploadPaymentFileInitial value)? initial,
    TResult? Function(UploadPaymentFileLoading value)? loading,
    TResult? Function(UploadPaymentFileSuccess value)? success,
    TResult? Function(UploadPaymentFileError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UploadPaymentFileInitial value)? initial,
    TResult Function(UploadPaymentFileLoading value)? loading,
    TResult Function(UploadPaymentFileSuccess value)? success,
    TResult Function(UploadPaymentFileError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class UploadPaymentFileLoading implements UploadPaymentFileState {
  const factory UploadPaymentFileLoading(final int paymentId) =
      _$UploadPaymentFileLoadingImpl;

  int get paymentId;

  /// Create a copy of UploadPaymentFileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UploadPaymentFileLoadingImplCopyWith<_$UploadPaymentFileLoadingImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UploadPaymentFileSuccessImplCopyWith<$Res> {
  factory _$$UploadPaymentFileSuccessImplCopyWith(
          _$UploadPaymentFileSuccessImpl value,
          $Res Function(_$UploadPaymentFileSuccessImpl) then) =
      __$$UploadPaymentFileSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int paymentId, PaymentUploadData data});
}

/// @nodoc
class __$$UploadPaymentFileSuccessImplCopyWithImpl<$Res>
    extends _$UploadPaymentFileStateCopyWithImpl<$Res,
        _$UploadPaymentFileSuccessImpl>
    implements _$$UploadPaymentFileSuccessImplCopyWith<$Res> {
  __$$UploadPaymentFileSuccessImplCopyWithImpl(
      _$UploadPaymentFileSuccessImpl _value,
      $Res Function(_$UploadPaymentFileSuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of UploadPaymentFileState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paymentId = null,
    Object? data = null,
  }) {
    return _then(_$UploadPaymentFileSuccessImpl(
      null == paymentId
          ? _value.paymentId
          : paymentId // ignore: cast_nullable_to_non_nullable
              as int,
      null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as PaymentUploadData,
    ));
  }
}

/// @nodoc

class _$UploadPaymentFileSuccessImpl implements UploadPaymentFileSuccess {
  const _$UploadPaymentFileSuccessImpl(this.paymentId, this.data);

  @override
  final int paymentId;
  @override
  final PaymentUploadData data;

  @override
  String toString() {
    return 'UploadPaymentFileState.success(paymentId: $paymentId, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UploadPaymentFileSuccessImpl &&
            (identical(other.paymentId, paymentId) ||
                other.paymentId == paymentId) &&
            (identical(other.data, data) || other.data == data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, paymentId, data);

  /// Create a copy of UploadPaymentFileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UploadPaymentFileSuccessImplCopyWith<_$UploadPaymentFileSuccessImpl>
      get copyWith => __$$UploadPaymentFileSuccessImplCopyWithImpl<
          _$UploadPaymentFileSuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(int paymentId) loading,
    required TResult Function(int paymentId, PaymentUploadData data) success,
    required TResult Function(int paymentId, String message) error,
  }) {
    return success(paymentId, data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(int paymentId)? loading,
    TResult? Function(int paymentId, PaymentUploadData data)? success,
    TResult? Function(int paymentId, String message)? error,
  }) {
    return success?.call(paymentId, data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(int paymentId)? loading,
    TResult Function(int paymentId, PaymentUploadData data)? success,
    TResult Function(int paymentId, String message)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(paymentId, data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UploadPaymentFileInitial value) initial,
    required TResult Function(UploadPaymentFileLoading value) loading,
    required TResult Function(UploadPaymentFileSuccess value) success,
    required TResult Function(UploadPaymentFileError value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UploadPaymentFileInitial value)? initial,
    TResult? Function(UploadPaymentFileLoading value)? loading,
    TResult? Function(UploadPaymentFileSuccess value)? success,
    TResult? Function(UploadPaymentFileError value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UploadPaymentFileInitial value)? initial,
    TResult Function(UploadPaymentFileLoading value)? loading,
    TResult Function(UploadPaymentFileSuccess value)? success,
    TResult Function(UploadPaymentFileError value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class UploadPaymentFileSuccess implements UploadPaymentFileState {
  const factory UploadPaymentFileSuccess(
          final int paymentId, final PaymentUploadData data) =
      _$UploadPaymentFileSuccessImpl;

  int get paymentId;
  PaymentUploadData get data;

  /// Create a copy of UploadPaymentFileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UploadPaymentFileSuccessImplCopyWith<_$UploadPaymentFileSuccessImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UploadPaymentFileErrorImplCopyWith<$Res> {
  factory _$$UploadPaymentFileErrorImplCopyWith(
          _$UploadPaymentFileErrorImpl value,
          $Res Function(_$UploadPaymentFileErrorImpl) then) =
      __$$UploadPaymentFileErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int paymentId, String message});
}

/// @nodoc
class __$$UploadPaymentFileErrorImplCopyWithImpl<$Res>
    extends _$UploadPaymentFileStateCopyWithImpl<$Res,
        _$UploadPaymentFileErrorImpl>
    implements _$$UploadPaymentFileErrorImplCopyWith<$Res> {
  __$$UploadPaymentFileErrorImplCopyWithImpl(
      _$UploadPaymentFileErrorImpl _value,
      $Res Function(_$UploadPaymentFileErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of UploadPaymentFileState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paymentId = null,
    Object? message = null,
  }) {
    return _then(_$UploadPaymentFileErrorImpl(
      null == paymentId
          ? _value.paymentId
          : paymentId // ignore: cast_nullable_to_non_nullable
              as int,
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$UploadPaymentFileErrorImpl implements UploadPaymentFileError {
  const _$UploadPaymentFileErrorImpl(this.paymentId, this.message);

  @override
  final int paymentId;
  @override
  final String message;

  @override
  String toString() {
    return 'UploadPaymentFileState.error(paymentId: $paymentId, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UploadPaymentFileErrorImpl &&
            (identical(other.paymentId, paymentId) ||
                other.paymentId == paymentId) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, paymentId, message);

  /// Create a copy of UploadPaymentFileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UploadPaymentFileErrorImplCopyWith<_$UploadPaymentFileErrorImpl>
      get copyWith => __$$UploadPaymentFileErrorImplCopyWithImpl<
          _$UploadPaymentFileErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(int paymentId) loading,
    required TResult Function(int paymentId, PaymentUploadData data) success,
    required TResult Function(int paymentId, String message) error,
  }) {
    return error(paymentId, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(int paymentId)? loading,
    TResult? Function(int paymentId, PaymentUploadData data)? success,
    TResult? Function(int paymentId, String message)? error,
  }) {
    return error?.call(paymentId, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(int paymentId)? loading,
    TResult Function(int paymentId, PaymentUploadData data)? success,
    TResult Function(int paymentId, String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(paymentId, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UploadPaymentFileInitial value) initial,
    required TResult Function(UploadPaymentFileLoading value) loading,
    required TResult Function(UploadPaymentFileSuccess value) success,
    required TResult Function(UploadPaymentFileError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UploadPaymentFileInitial value)? initial,
    TResult? Function(UploadPaymentFileLoading value)? loading,
    TResult? Function(UploadPaymentFileSuccess value)? success,
    TResult? Function(UploadPaymentFileError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UploadPaymentFileInitial value)? initial,
    TResult Function(UploadPaymentFileLoading value)? loading,
    TResult Function(UploadPaymentFileSuccess value)? success,
    TResult Function(UploadPaymentFileError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class UploadPaymentFileError implements UploadPaymentFileState {
  const factory UploadPaymentFileError(
      final int paymentId, final String message) = _$UploadPaymentFileErrorImpl;

  int get paymentId;
  String get message;

  /// Create a copy of UploadPaymentFileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UploadPaymentFileErrorImplCopyWith<_$UploadPaymentFileErrorImpl>
      get copyWith => throw _privateConstructorUsedError;
}
