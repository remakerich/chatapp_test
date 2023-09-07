import 'package:chatapp_test/core/core.dart';

part 'message.freezed.dart';
part 'message.g.dart';

@freezed
class Message with _$Message {

  const factory Message({
    @Default('') String text,
    @Default(false) bool isIncoming,
  }) = _Message;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
}
