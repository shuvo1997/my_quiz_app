import 'package:html_unescape/html_unescape.dart';

class HtmlEncoding {
  String htmlDecoder(String string) {
    var unescape = new HtmlUnescape();
    String text = unescape.convert(string);
    return text;
  }
}
