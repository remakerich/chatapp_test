import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

@freezed
class Failure with _$Failure {
  const Failure._();

  const factory Failure.server(String? value) = FailureServer;
  const factory Failure.client(String? value) = FailureClient;

  String get message => when(
        server: (value) => value ?? 'Ошибка сервера',
        client: (value) => value ?? 'Ошибка клиента',
      );
}
