// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'solution_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SolutionModel _$SolutionModelFromJson(Map<String, dynamic> json) {
  return _SolutionModel.fromJson(json);
}

/// @nodoc
mixin _$SolutionModel {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'original_price')
  num get originalPrice => throw _privateConstructorUsedError;
  @JsonKey(name: 'current_price')
  num get currentPrice => throw _privateConstructorUsedError;
  @JsonKey(name: 'has_active_offer')
  bool get hasActiveOffer => throw _privateConstructorUsedError;
  @JsonKey(name: 'discount_percentage')
  int get discountPercentage => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_from')
  String get createdFrom => throw _privateConstructorUsedError;
  List<AttachmentModel> get attachments => throw _privateConstructorUsedError;

  /// Serializes this SolutionModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SolutionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SolutionModelCopyWith<SolutionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SolutionModelCopyWith<$Res> {
  factory $SolutionModelCopyWith(
          SolutionModel value, $Res Function(SolutionModel) then) =
      _$SolutionModelCopyWithImpl<$Res, SolutionModel>;
  @useResult
  $Res call(
      {int id,
      String name,
      String? description,
      @JsonKey(name: 'original_price') num originalPrice,
      @JsonKey(name: 'current_price') num currentPrice,
      @JsonKey(name: 'has_active_offer') bool hasActiveOffer,
      @JsonKey(name: 'discount_percentage') int discountPercentage,
      @JsonKey(name: 'created_at') String createdAt,
      @JsonKey(name: 'created_from') String createdFrom,
      List<AttachmentModel> attachments});
}

/// @nodoc
class _$SolutionModelCopyWithImpl<$Res, $Val extends SolutionModel>
    implements $SolutionModelCopyWith<$Res> {
  _$SolutionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SolutionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? originalPrice = null,
    Object? currentPrice = null,
    Object? hasActiveOffer = null,
    Object? discountPercentage = null,
    Object? createdAt = null,
    Object? createdFrom = null,
    Object? attachments = null,
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
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
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
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      createdFrom: null == createdFrom
          ? _value.createdFrom
          : createdFrom // ignore: cast_nullable_to_non_nullable
              as String,
      attachments: null == attachments
          ? _value.attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<AttachmentModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SolutionModelImplCopyWith<$Res>
    implements $SolutionModelCopyWith<$Res> {
  factory _$$SolutionModelImplCopyWith(
          _$SolutionModelImpl value, $Res Function(_$SolutionModelImpl) then) =
      __$$SolutionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String? description,
      @JsonKey(name: 'original_price') num originalPrice,
      @JsonKey(name: 'current_price') num currentPrice,
      @JsonKey(name: 'has_active_offer') bool hasActiveOffer,
      @JsonKey(name: 'discount_percentage') int discountPercentage,
      @JsonKey(name: 'created_at') String createdAt,
      @JsonKey(name: 'created_from') String createdFrom,
      List<AttachmentModel> attachments});
}

/// @nodoc
class __$$SolutionModelImplCopyWithImpl<$Res>
    extends _$SolutionModelCopyWithImpl<$Res, _$SolutionModelImpl>
    implements _$$SolutionModelImplCopyWith<$Res> {
  __$$SolutionModelImplCopyWithImpl(
      _$SolutionModelImpl _value, $Res Function(_$SolutionModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of SolutionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? originalPrice = null,
    Object? currentPrice = null,
    Object? hasActiveOffer = null,
    Object? discountPercentage = null,
    Object? createdAt = null,
    Object? createdFrom = null,
    Object? attachments = null,
  }) {
    return _then(_$SolutionModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
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
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      createdFrom: null == createdFrom
          ? _value.createdFrom
          : createdFrom // ignore: cast_nullable_to_non_nullable
              as String,
      attachments: null == attachments
          ? _value._attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<AttachmentModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SolutionModelImpl implements _SolutionModel {
  const _$SolutionModelImpl(
      {required this.id,
      required this.name,
      this.description,
      @JsonKey(name: 'original_price') required this.originalPrice,
      @JsonKey(name: 'current_price') required this.currentPrice,
      @JsonKey(name: 'has_active_offer') required this.hasActiveOffer,
      @JsonKey(name: 'discount_percentage') required this.discountPercentage,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'created_from') required this.createdFrom,
      final List<AttachmentModel> attachments = const []})
      : _attachments = attachments;

  factory _$SolutionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SolutionModelImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String? description;
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
  final int discountPercentage;
  @override
  @JsonKey(name: 'created_at')
  final String createdAt;
  @override
  @JsonKey(name: 'created_from')
  final String createdFrom;
  final List<AttachmentModel> _attachments;
  @override
  @JsonKey()
  List<AttachmentModel> get attachments {
    if (_attachments is EqualUnmodifiableListView) return _attachments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attachments);
  }

  @override
  String toString() {
    return 'SolutionModel(id: $id, name: $name, description: $description, originalPrice: $originalPrice, currentPrice: $currentPrice, hasActiveOffer: $hasActiveOffer, discountPercentage: $discountPercentage, createdAt: $createdAt, createdFrom: $createdFrom, attachments: $attachments)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SolutionModelImpl &&
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

  /// Create a copy of SolutionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SolutionModelImplCopyWith<_$SolutionModelImpl> get copyWith =>
      __$$SolutionModelImplCopyWithImpl<_$SolutionModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SolutionModelImplToJson(
      this,
    );
  }
}

abstract class _SolutionModel implements SolutionModel {
  const factory _SolutionModel(
      {required final int id,
      required final String name,
      final String? description,
      @JsonKey(name: 'original_price') required final num originalPrice,
      @JsonKey(name: 'current_price') required final num currentPrice,
      @JsonKey(name: 'has_active_offer') required final bool hasActiveOffer,
      @JsonKey(name: 'discount_percentage')
      required final int discountPercentage,
      @JsonKey(name: 'created_at') required final String createdAt,
      @JsonKey(name: 'created_from') required final String createdFrom,
      final List<AttachmentModel> attachments}) = _$SolutionModelImpl;

  factory _SolutionModel.fromJson(Map<String, dynamic> json) =
      _$SolutionModelImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String? get description;
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
  int get discountPercentage;
  @override
  @JsonKey(name: 'created_at')
  String get createdAt;
  @override
  @JsonKey(name: 'created_from')
  String get createdFrom;
  @override
  List<AttachmentModel> get attachments;

  /// Create a copy of SolutionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SolutionModelImplCopyWith<_$SolutionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
