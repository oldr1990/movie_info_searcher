
abstract class Result<T extends Object> {
}

class Success<T extends Object> extends Result<T> {
  final T value;

  Success(this.value);
}

class Error<T extends Object> extends Result<T> {
  final String errorMessage;

  Error(this.errorMessage);
}