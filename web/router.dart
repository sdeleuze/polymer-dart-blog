import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:route/client.dart';

final homeUrl = new UrlPattern(r'/index.html');
final postUrl = new UrlPattern(r'/post/(\d+)');
final aboutUrl = new UrlPattern(r'/about');

main() {

  var router = new Router()
      ..addHandler(homeUrl, showHome)
      ..addHandler(aboutUrl, showAbout)
      ..listen(); 
}

void showHome(String path) {
  query('#add-here').innerHtml = "toto";
}

void showAbout(String path) {
  query('#add-here').children.add(createElement('x-about'));
}