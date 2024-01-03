import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebviewScreen extends StatefulWidget {
  final String url;

  const PaymentWebviewScreen({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  State<PaymentWebviewScreen> createState() => _PaymentWebviewScreenState();
}

class _PaymentWebviewScreenState extends State<PaymentWebviewScreen> {
  @override
  Widget build(BuildContext context) {
    print('payment view');
    print(widget.url);

    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));

    print('payment view');
    print(widget.url);

    return Scaffold(
        appBar: AppBar(
          title: Text('Payment VNPay'),
        ),
        body: SafeArea(
            child: widget.url != ''
                ? WebViewWidget(controller: controller)
                : SizedBox()));
  }
}
