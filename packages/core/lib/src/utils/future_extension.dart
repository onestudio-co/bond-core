/// An extension on [Future] that provides a method to map the result of the future to a different type.
extension MapFuture<T> on Future<T> {
  /// Maps the result of the future to a different type using the provided function.
  ///
  /// Returns a new [Future] that resolves to the result of applying the provided function
  /// [toElement] to the value of this future when it completes.
  Future<G> map<G>(G Function(T t) toElement) {
    return then((value) => toElement(value));
  }
}

/// An extension on [Future<List>] that provides a method to map the elements of the list to a different type.
extension MapListFuture<T> on Future<List<T>> {
  /// Maps the elements of the list to a different type using the provided function.
  ///
  /// Returns a new [Future<List>] that resolves to a list containing the results of applying
  /// the provided function [toElement] to each element of the list when the future completes.
  Future<List<G>> map<G>(G Function(T t) toElement) {
    return then((value) => value.map(toElement).toList());
  }
}
