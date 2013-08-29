import 'package:unittest/unittest.dart';
import 'package:http/http.dart';
import 'dart:io';
import 'dart:convert';

main() {
  
  test('Synchronous Http test', () {
    get("http://localhost:3000/test").then((response) {
      expect(response.body, equals("Test"));
    });
  });
  
  test('Asynchronous Http test', () {
    HttpClient client = new HttpClient();
    return client.getUrl(Uri.parse("http://localhost:3000/test"))
      .then((HttpClientRequest request) => request.close())
      .then((HttpClientResponse response) => response.transform(UTF8.decoder).toList()
      .then((data) {
        expect(data.join(), equals("Test"));  
      }));
  });
  
}