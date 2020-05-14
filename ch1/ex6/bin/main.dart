
bool trueIfNull(a,b){
  return a == null && b == null;
}

void main(List<String> arguments) {
  final nulls = trueIfNull(null, null);
  final ints = trueIfNull(1, 2);
  final doubles = trueIfNull(1.0, 2.0);
  final bools = trueIfNull(true, false);

  
  print('$nulls');
  print('$ints');
  print('$doubles');
  print('$bools');
}
