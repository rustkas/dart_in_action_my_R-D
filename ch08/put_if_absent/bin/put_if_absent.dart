void main() {
  final userLogons = usingPutIfAbsent();
  print(userLogons);
}

Map<String, List<DateTime>> usingPutIfAbsent() {
  final userLogons = <String, List<DateTime>>{};

  userLogons.putIfAbsent('charlie', () => <DateTime>[]);
  userLogons['charlie'].add(DateTime.now());
  return userLogons;
}
