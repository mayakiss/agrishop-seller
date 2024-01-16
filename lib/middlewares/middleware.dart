abstract class Middleware<T, R> {
  T next(R response);
}
