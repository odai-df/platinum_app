// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'solutions_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SolutionsResponse _$SolutionsResponseFromJson(Map<String, dynamic> json) {
  return _SolutionsResponse.fromJson(json);
}

/// @nodoc
mixin _$SolutionsResponse {
  String get status => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  List<SolutionModel> get data => throw _privateConstructorUsedError;

  /// Serializes this SolutionsResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SolutionsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SolutionsResponseCopyWith<SolutionsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SolutionsResponseCopyWith<$Res> {
  factory $SolutionsResponseCopyWith(
          SolutionsResponse value, $Res Function(SolutionsResponse) then) =
      _$SolutionsResponseCopyWithImpl<$Res, SolutionsResponse>;
  @useResult
  $Res call({String status, String message, List<SolutionModel> data});
}

/// @nodoc
class _$SolutionsResponseCopyWithImpl<$Res, $Val extends SolutionsResponse>
    implements $SolutionsResponseCopyWith<$Res> {
  _$SolutionsResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SolutionsResponse
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
              as List<SolutionModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SolutionsResponseImplCopyWith<$Res>
    implements $SolutionsResponseCopyWith<$Res> {
  factory _$$SolutionsResponseImplCopyWith(_$SolutionsResponseImpl value,
          $Res Function(_$SolutionsResponseImpl) then) =
      __$$SolutionsResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String status, String message, List<SolutionModel> data});
}

/// @nodoc
class __$$SolutionsResponseImplCopyWithImpl<$Res>
    extends _$SolutionsResponseCopyWithImpl<$Res, _$SolutionsResponseImpl>
    implements _$$SolutionsResponseImplCopyWith<$Res> {
  __$$SolutionsResponseImplCopyWithImpl(_$SolutionsResponseImpl _value,
      $Res Function(_$SolutionsResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of SolutionsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
    Object? data = null,
  }) {
    return _then(_$SolutionsResponseImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<SolutionModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SolutionsResponseImpl implements _SolutionsResponse {
  const _$SolutionsResponseImpl(
      {required this.status,
      required this.message,
      required final List<SolutionModel> data})
      : _data = data;

  factory _$SolutionsResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$SolutionsResponseImplFromJson(json);

  @override
  final String status;
  @override
  final String message;
  final List<SolutionModel> _data;
  @override
  List<SolutionModel> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  String toString() {
    return 'SolutionsResponse(status: $status, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SolutionsResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, status, message, const DeepCollectionEquality().hash(_data));

  /// Create a copy of SolutionsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SolutionsResponseImplCopyWith<_$SolutionsResponseImpl> get copyWith =>
      __$$SolutionsResponseImplCopyWithImpl<_$SolutionsResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SolutionsResponseImplToJson(
      this,
    );
  }
}

abstract class _SolutionsResponse implements SolutionsResponse {
  const factory _SolutionsResponse(
      {required final String status,
      required final String message,
      required final List<SolutionModel> data}) = _$SolutionsResponseImpl;

  factory _SolutionsResponse.fromJson(Map<String, dynamic> json) =
      _$SolutionsResponseImpl.fromJson;

  @override
  String get status;
  @override
  String get message;
  @override
  List<SolutionModel> get data;

  /// Create a copy of SolutionsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SolutionsResponseImplCopyWith<_$SolutionsResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
