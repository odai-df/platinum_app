// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'solution_details_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SolutionDetailsModel _$SolutionDetailsModelFromJson(Map<String, dynamic> json) {
  return _SolutionDetailsModel.fromJson(json);
}

/// @nodoc
mixin _$SolutionDetailsModel {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'original_price')
  num get originalPrice => throw _privateConstructorUsedError;
  @JsonKey(name: 'current_price')
  num get currentPrice => throw _privateConstructorUsedError;
  @JsonKey(name: 'has_active_offer')
  bool get hasActiveOffer => throw _privateConstructorUsedError;
  @JsonKey(name: 'discount_percentage')
  num get discountPercentage => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_from')
  String get createdFrom => throw _privateConstructorUsedError;
  List<AttachmentModel>? get attachments => throw _privateConstructorUsedError;

  /// Serializes this SolutionDetailsModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SolutionDetailsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SolutionDetailsModelCopyWith<SolutionDetailsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SolutionDetailsModelCopyWith<$Res> {
  factory $SolutionDetailsModelCopyWith(SolutionDetailsModel value,
          $Res Function(SolutionDetailsModel) then) =
      _$SolutionDetailsModelCopyWithImpl<$Res, SolutionDetailsModel>;
  @useResult
  $Res call(
      {int id,
      String name,
      String description,
      @JsonKey(name: 'original_price') num originalPrice,
      @JsonKey(name: 'current_price') num currentPrice,
      @JsonKey(name: 'has_active_offer') bool hasActiveOffer,
      @JsonKey(name: 'discount_percentage') num discountPercentage,
      @JsonKey(name: 'created_at') String createdAt,
      @JsonKey(name: 'created_from') String createdFrom,
      List<AttachmentModel>? attachments});
}

/// @nodoc
class _$SolutionDetailsModelCopyWithImpl<$Res,
        $Val extends SolutionDetailsModel>
    implements $SolutionDetailsModelCopyWith<$Res> {
  _$SolutionDetailsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SolutionDetailsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? originalPrice = null,
    Object? currentPrice = null,
    Object? hasActiveOffer = null,
    Object? discountPercentage = null,
    Object? createdAt = null,
    Object? createdFrom = null,
    Object? attachments = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      originalPrice: null == originalPrice
          ? _value.originalPrice
          : originalPrice // ignore: cast_nullable_to_non_nullable
              as num,
      currentPrice: null == currentPrice
          ? _value.currentPrice
          : currentPrice // ignore: cast_nullable_to_non_nullable
              as num,
      hasActiveOffer: null == hasActiveOffer
          ? _value.hasActiveOffer
          : hasActiveOffer // ignore: cast_nullable_to_non_nullable
              as bool,
      discountPercentage: null == discountPercentage
          ? _value.discountPercentage
          : discountPercentage // ignore: cast_nullable_to_non_nullable
              as num,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      createdFrom: null == createdFrom
          ? _value.createdFrom
          : createdFrom // ignore: cast_nullable_to_non_nullable
              as String,
      attachments: freezed == attachments
          ? _value.attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<AttachmentModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SolutionDetailsModelImplCopyWith<$Res>
    implements $SolutionDetailsModelCopyWith<$Res> {
  factory _$$SolutionDetailsModelImplCopyWith(_$SolutionDetailsModelImpl value,
          $Res Function(_$SolutionDetailsModelImpl) then) =
      __$$SolutionDetailsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String description,
      @JsonKey(name: 'original_price') num originalPrice,
      @JsonKey(name: 'current_price') num currentPrice,
      @JsonKey(name: 'has_active_offer') bool hasActiveOffer,
      @JsonKey(name: 'discount_percentage') num discountPercentage,
      @JsonKey(name: 'created_at') String createdAt,
      @JsonKey(name: 'created_from') String createdFrom,
      List<AttachmentModel>? attachments});
}

/// @nodoc
class __$$SolutionDetailsModelImplCopyWithImpl<$Res>
    extends _$SolutionDetailsModelCopyWithImpl<$Res, _$SolutionDetailsModelImpl>
    implements _$$SolutionDetailsModelImplCopyWith<$Res> {
  __$$SolutionDetailsModelImplCopyWithImpl(_$SolutionDetailsModelImpl _value,
      $Res Function(_$SolutionDetailsModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of SolutionDetailsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? originalPrice = null,
    Object? currentPrice = null,
    Object? hasActiveOffer = null,
    Object? discountPercentage = null,
    Object? createdAt = null,
    Object? createdFrom = null,
    Object? attachments = freezed,
  }) {
    return _then(_$SolutionDetailsModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      originalPrice: null == originalPrice
          ? _value.originalPrice
          : originalPrice // ignore: cast_nullable_to_non_nullable
              as num,
      currentPrice: null == currentPrice
          ? _value.currentPrice
          : currentPrice // ignore: cast_nullable_to_non_nullable
              as num,
      hasActiveOffer: null == hasActiveOffer
          ? _value.hasActiveOffer
          : hasActiveOffer // ignore: cast_nullable_to_non_nullable
              as bool,
      discountPercentage: null == discountPercentage
          ? _value.discountPercentage
          : discountPercentage // ignore: cast_nullable_to_non_nullable
              as num,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      createdFrom: null == createdFrom
          ? _value.createdFrom
          : createdFrom // ignore: cast_nullable_to_non_nullable
              as String,
      attachments: freezed == attachments
          ? _value._attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<AttachmentModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SolutionDetailsModelImpl implements _SolutionDetailsModel {
  const _$SolutionDetailsModelImpl(
      {required this.id,
      required this.name,
      required this.description,
      @JsonKey(name: 'original_price') required this.originalPrice,
      @JsonKey(name: 'current_price') required this.currentPrice,
      @JsonKey(name: 'has_active_offer') required this.hasActiveOffer,
      @JsonKey(name: 'discount_percentage') required this.discountPercentage,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'created_from') required this.createdFrom,
      final List<AttachmentModel>? attachments})
      : _attachments = attachments;

  factory _$SolutionDetailsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SolutionDetailsModelImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String description;
  @override
  @JsonKey(name: 'original_price')
  final num originalPrice;
  @override
  @JsonKey(name: 'current_price')
  final num currentPrice;
  @override
  @JsonKey(name: 'has_active_offer')
  final bool hasActiveOffer;
  @override
  @JsonKey(name: 'discount_percentage')
  final num discountPercentage;
  @override
  @JsonKey(name: 'created_at')
  final String createdAt;
  @override
  @JsonKey(name: 'created_from')
  final String createdFrom;
  final List<AttachmentModel>? _attachments;
  @override
  List<AttachmentModel>? get attachments {
    final value = _attachments;
    if (value == null) return null;
    if (_attachments is EqualUnmodifiableListView) return _attachments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'SolutionDetailsModel(id: $id, name: $name, description: $description, originalPrice: $originalPrice, currentPrice: $currentPrice, hasActiveOffer: $hasActiveOffer, discountPercentage: $discountPercentage, createdAt: $createdAt, createdFrom: $createdFrom, attachments: $attachments)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SolutionDetailsModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.originalPrice, originalPrice) ||
                other.originalPrice == originalPrice) &&
            (identical(other.currentPrice, currentPrice) ||
                other.currentPrice == currentPrice) &&
            (identical(other.hasActiveOffer, hasActiveOffer) ||
                other.hasActiveOffer == hasActiveOffer) &&
            (identical(other.discountPercentage, discountPercentage) ||
                other.discountPercentage == discountPercentage) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.createdFrom, createdFrom) ||
                other.createdFrom == createdFrom) &&
            const DeepCollectionEquality()
                .equals(other._attachments, _attachments));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      originalPrice,
      currentPrice,
      hasActiveOffer,
      discountPercentage,
      createdAt,
      createdFrom,
      const DeepCollectionEquality().hash(_attachments));

  /// Create a copy of SolutionDetailsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SolutionDetailsModelImplCopyWith<_$SolutionDetailsModelImpl>
      get copyWith =>
          __$$SolutionDetailsModelImplCopyWithImpl<_$SolutionDetailsModelImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SolutionDetailsModelImplToJson(
      this,
    );
  }
}

abstract class _SolutionDetailsModel implements SolutionDetailsModel {
  const factory _SolutionDetailsModel(
      {required final int id,
      required final String name,
      required final String description,
      @JsonKey(name: 'original_price') required final num originalPrice,
      @JsonKey(name: 'current_price') required final num currentPrice,
      @JsonKey(name: 'has_active_offer') required final bool hasActiveOffer,
      @JsonKey(name: 'discount_percentage')
      required final num discountPercentage,
      @JsonKey(name: 'created_at') required final String createdAt,
      @JsonKey(name: 'created_from') required final String createdFrom,
      final List<AttachmentModel>? attachments}) = _$SolutionDetailsModelImpl;

  factory _SolutionDetailsModel.fromJson(Map<String, dynamic> json) =
      _$SolutionDetailsModelImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get description;
  @override
  @JsonKey(name: 'original_price')
  num get originalPrice;
  @override
  @JsonKey(name: 'current_price')
  num get currentPrice;
  @override
  @JsonKey(name: 'has_active_offer')
  bool get hasActiveOffer;
  @override
  @JsonKey(name: 'discount_percentage')
  num get discountPercentage;
  @override
  @JsonKey(name: 'created_at')
  String get createdAt;
  @override
  @JsonKey(name: 'created_from')
  String get createdFrom;
  @override
  List<AttachmentModel>? get attachments;

  /// Create a copy of SolutionDetailsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SolutionDetailsModelImplCopyWith<_$SolutionDetailsModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
