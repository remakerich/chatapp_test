import 'package:chatapp_test/core/core.dart';

Future<Either<Failure, T>> handleExceptions<T>(
  Future<T> Function() future,
) async {
  try {
    final result = await future();
    return Right(result);
  } on FailureServer catch (error) {
    return Left(
      Failure.server(error.message),
    );
  } catch (e, trace) {
    return Left(
      Failure.client('$e $trace'),
    );
  }
}
