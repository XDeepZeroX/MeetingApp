extension IterableExtensions<E> on Iterable<E> {
  E firstWhereOrNull(bool test(E element)) {
    return this.firstWhere(test, orElse: () => null);
  }
}
