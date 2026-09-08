// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'solution_details_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SolutionDetailsResponse _$SolutionDetailsResponseFromJson(
    Map<String, dynamic> json) {
  return _SolutionDetailsResponse.fromJson(json);
}

/// @nodoc
mixin _$SolutionDetailsResponse {
  String get status => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  SolutionDetailsModel get data => throw _privateConstructorUsedError;

  /// Serializes this SolutionDetailsResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SolutionDetailsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SolutionDetailsResponseCopyWith<SolutionDetailsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SolutionDetailsResponseCopyWith<$Res> {
  factory $SolutionDetailsResponseCopyWith(SolutionDetailsResponse value,
          $Res Function(SolutionDetailsResponse) then) =
      _$SolutionDetailsResponseCopyWithImpl<$Res, SolutionDetailsResponse>;
  @useResult
  $Res call({String status, String message, SolutionDetailsModel data});

  $SolutionDetailsModelCopyWith<$Res> get data;
}

/// @nodoc
class _$SolutionDetailsResponseCopyWithImpl<$Res,
        $Val extends SolutionDetailsResponse>
    implements $SolutionDetailsResponseCopyWith<$Res> {
  _$SolutionDetailsResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SolutionDetailsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as SolutionDetailsModel,
    ) as $Val);
  }

  /// Create a copy of SolutionDetailsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SolutionDetailsModelCopyWith<$Res> get data {
    return $SolutionDetailsModelCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SolutionDetailsResponseImplCopyWith<$Res>
    implements $SolutionDetailsResponseCopyWith<$Res> {
  factory _$$SolutionDetailsResponseImplCopyWith(
          _$SolutionDetailsResponseImpl value,
          $Res Function(_$SolutionDetailsResponseImpl) then) =
      __$$SolutionDetailsResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String status, String message, SolutionDetailsModel data});

  @override
  $SolutionDetailsModelCopyWith<$Res> get data;
}

/// @nodoc
class __$$SolutionDetailsResponseImplCopyWithImpl<$Res>
    extends _$SolutionDetailsResponseCopyWithImpl<$Res,
        _$SolutionDetailsResponseImpl>
    implements _$$SolutionDetailsResponseImplCopyWith<$Res> {
  __$$SolutionDetailsResponseImplCopyWithImpl(
      _$SolutionDetailsResponseImpl _value,
      $Res Function(_$SolutionDetailsResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of SolutionDetailsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
    Object? data = null,
  }) {
    return _then(_$SolutionDetailsResponseImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as SolutionDetailsModel,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SolutionDetailsResponseImpl implements _SolutionDetailsResponse {
  const _$SolutionDetailsResponseImpl(
      {required this.status, required this.message, required this.data});

  factory _$SolutionDetailsResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$SolutionDetailsResponseImplFromJson(json);

  @override
  final String status;
  @override
  final String message;
  @override
  final SolutionDetailsModel data;

  @override
  String toString() {
    return 'SolutionDetailsResponse(status: $status, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SolutionDetailsResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, message, data);

  /// Create a copy of SolutionDetailsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SolutionDetailsResponseImplCopyWith<_$SolutionDetailsResponseImpl>
      get copyWith => __$$SolutionDetailsResponseImplCopyWithImpl<
          _$SolutionDetailsResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SolutionDetailsResponseImplToJson(
      this,
    );
  }
}

abstract class _SolutionDetailsResponse implements SolutionDetailsResponse {
  const factory _SolutionDetailsResponse(
          {required final String status,
          required final String message,
          required final SolutionDetailsModel data}) =
      _$SolutionDetailsResponseImpl;

  factory _SolutionDetailsResponse.fromJson(Map<String, dynamic> json) =
      _$SolutionDetailsResponseImpl.fromJson;

  @override
  String get status;
  @override
  String get message;
  @override
  SolutionDetailsModel get data;

  /// Create a copy of SolutionDetailsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SolutionDetailsResponseImplCopyWith<_$SolutionDetailsResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
