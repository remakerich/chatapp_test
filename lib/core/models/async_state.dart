import 'package:chatapp_test/core/core.dart';

part 'async_state.freezed.dart';

@freezed
class AsyncState<T> with _$AsyncState<T> {
  const factory AsyncState.loading() = AsyncLoading;
  const factory AsyncState.data(T data) = AsyncData<T>;
  const factory AsyncState.error(Failure error) = AsyncError;
}
