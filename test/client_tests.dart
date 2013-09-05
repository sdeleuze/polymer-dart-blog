import 'package:unittest/unittest.dart';
import 'dart:html';


main() {
  
  test('Client simple test using dart:html', () {
    AnchorElement link = query('#example');
    link.href = 'http://dartlang.org/';
    expect((query('#example') as AnchorElement).href, equals('http://dartlang.org/'));   
  });
  
  test('Test DOM node removal', () {
    expect(query('#toto').children.length, equals(5));
    query('#toto').children.clear();
    expect(query('#toto').children.length, equals(0));    
  });
   
}