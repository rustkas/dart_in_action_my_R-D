import 'package:test/test.dart';
import 'package:concrete_mix/concrete_mix.dart';

void main() {
  test('Mix cement', () {
    final cement = Cement();
    cement.bags = 2;

    var sand = measureQty(Sand(), cement.bags, 2);
    var gravel = measureQty(Gravel(), cement.bags, 3);
    expect(4, sand.bags);
    expect(6, gravel.bags);

    var mortar = mix(cement, sand);
    var dryConcrete = mix(mortar, gravel);
    print(mortar.bags);
    // print(dryConcrete);
    // expect(mortar.bags, equals(6));
    // expect(dryConcrete.bags, equals(12));
  });

  // test('String.trim() removes surrounding whitespace', () {
  //   var string = '  foo ';
  //   expect(string.trim(), equals('foo'));
  // });
}
