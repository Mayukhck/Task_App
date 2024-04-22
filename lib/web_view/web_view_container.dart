import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart' ;

class WebViewContainer extends StatefulWidget {
   const WebViewContainer({super.key});

  @override
  State<WebViewContainer> createState() {
    return _WebViewContainerState();
  }
}

class _WebViewContainerState extends State<WebViewContainer> {

  static String html = ''' 
  <!DOCTYPE html><html>
<head><title>Navigation Delegate Example</title></head>
<body>
<p>
The navigation delegate is set to block navigation to the youtube website.
</p>
<ul>
<ul><a href="https://www.youtube.com/">https://www.youtube.com/</a></ul>
<ul><a href="https://www.google.com/">https://www.google.com/</a></ul>
</ul>
</body>
</html>
  ''';

    final controllers = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    //..loadRequest(Uri.parse('https://flutter.dev'));
    ..loadHtmlString(html);
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WebView Controller'),
      ),
      body: WebViewWidget(controller: controllers),
    );
  }
}
