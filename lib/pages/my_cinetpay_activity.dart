import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';
import 'my_cinetpay_web_app_interface.dart'; // Assurez-vous que ce fichier est correctement configuré

class MyCinetPayActivity extends StatefulWidget {
  final String apiKey;
  final String siteId;
  final String transactionId;
  final int amount;
  final String currency;
  final String description;
  final String channels;
  final String customerName;
  final String customerSurname;
  final String customerEmail;
  final String customerAddress;
  final String customerPhoneNumber;
  final String customerCity;
  final String customerCountry;
  final String customerZipCode;

  MyCinetPayActivity({
    required this.apiKey,
    required this.siteId,
    required this.transactionId,
    required this.amount,
    required this.currency,
    required this.description,
    required this.channels,
    required this.customerName,
    required this.customerSurname,
    required this.customerEmail,
    required this.customerAddress,
    required this.customerPhoneNumber,
    required this.customerCity,
    required this.customerCountry,
    required this.customerZipCode,
  });

  @override
  _MyCinetPayActivityState createState() => _MyCinetPayActivityState();
}

class _MyCinetPayActivityState extends State<MyCinetPayActivity> {
  late Future<String> paymentUrlFuture;
  late WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    paymentUrlFuture = getPaymentUrl();
  }

  Future<String> getPaymentUrl() async {
    final response = await http.post(
      Uri.parse('https://api.cinetpay.com/v1/payment'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'apikey': widget.apiKey,
        'site_id': widget.siteId,
        'transaction_id': widget.transactionId,
        'amount': widget.amount,
        'currency': widget.currency,
        'description': widget.description,
        // Ajoutez d'autres paramètres requis par CinetPay
      }),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse['payment_url']; // Assurez-vous que c'est le bon chemin pour obtenir l'URL
    } else {
      throw Exception('Failed to get payment URL');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CinetPay Payment'),
      ),
      body: FutureBuilder<String>(
        future: paymentUrlFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return WebView(
              initialUrl: snapshot.data,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _webViewController = webViewController;
                _setupJavaScriptChannels();
              },
            );
          }
        },
      ),
    );
  }

  void _setupJavaScriptChannels() {
    _webViewController.runJavascript(
      "window.addEventListener('message', function(event) { "
      "window.flutter_inappwebview.callHandler('messageHandler', event.data); "
      "});"
    );
  }
}
