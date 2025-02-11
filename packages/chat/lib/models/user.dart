import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  @JsonSerializable(fieldRename: FieldRename.none)
  const factory User({
    required String name,
    required String type,
  }) = _User;

  @JsonSerializable(
    fieldRename: FieldRename.snake,
  )
  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}
