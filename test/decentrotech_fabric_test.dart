import 'package:flutter_test/flutter_test.dart';

import 'package:decentrotech_fabric/decentrotech_fabric.dart';

void main() {
  test('adds one to input values', () {
    const webview = UIStreamWebView(
      uistreamUrl: "https://decentro.tech",
    );
    expect(webview.uistreamUrl, "https://decentro.tech");
  });
}
