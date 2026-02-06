extension XResponseExtension<T> on XResponse<T> {
  R when<R>({
    required R Function(T data) success,
    required R Function(String message) error,
  }) {
    return success ? success(data as T) : error(message!);
  }
}