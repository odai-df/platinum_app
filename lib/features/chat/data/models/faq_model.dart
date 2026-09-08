import 'package:json_annotation/json_annotation.dart';

part 'faq_model.g.dart';

@JsonSerializable()
class FaqModel {
  final int id;
  final String title;
  final String? content;
  final String type;

  FaqModel({
    required this.id,
    required this.title,
    this.content,
    required this.type,
  });

  factory FaqModel.fromJson(Map<String, dynamic> json) =>
      _$FaqModelFromJson(json);

  Map<String, dynamic> toJson() => _$FaqModelToJson(this);

  bool get isCategory => type == 'category';

  bool get isAnswer => type == 'answer';

  bool get isActionHuman => type == 'action_human';
}