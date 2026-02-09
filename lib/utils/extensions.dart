import 'package:xecosystem/core/tokens.dart';
import 'package:xecosystem/core/api.dart';

extension XResponseExtension<T> on XResponse<T> {
  R when<R>({
    required R Function(T data) success,
    required R Function(String message) error,
  }) {
    if (this.success && data != null) {
      return success(data as T);
    } else {
      return error(message ?? 'Unknown error');
    }
  }
}
