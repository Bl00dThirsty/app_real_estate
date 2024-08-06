import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'my_cinetpay_activity.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _amountController = TextEditingController();
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cityController = TextEditingController();
  final _zipCodeController = TextEditingController();

  String _currency = '';
  List<String> _channels = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(controller: _amountController, decoration: InputDecoration(labelText: 'Amount')),
            DropdownButton<String>(
              value: _currency,
              hint: Text('Select Currency'),
              onChanged: (String? newValue) {
                setState(() {
                  _currency = newValue!;
                });
              },
              items: <String>['XOF', 'USD', 'EUR']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            CheckboxListTile(
              title: Text("Credit Card"),
              value: _channels.contains("CREDIT_CARD"),
              onChanged: (bool? value) {
                setState(() {
                  if (value == true) {
                    _channels.add("CREDIT_CARD");
                  } else {
                    _channels.remove("CREDIT_CARD");
                  }
                });
              },
            ),
            ElevatedButton(
              onPressed: _onPayPressed,
              child: Text('Pay'),
            ),
          ],
        ),
      ),
    );
  }

  void _onPayPressed() {
    final amount = _amountController.text.trim();
    if (amount.isEmpty || _currency.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Veuillez saisir un montant et sélectionner la devise')));
      return;
    }
    if (_channels.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Veuillez sélectionner la méthode de paiement')));
      return;
    }
    final transactionId = DateTime.now().millisecondsSinceEpoch.toString();
    final description = "Recharge carte RFID";

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyCinetPayActivity(
          apiKey: "5337111116358eef42b6448.37599996",
          siteId: "301005",
          transactionId: transactionId,
          amount: int.parse(amount),
          currency: _currency,
          description: description,
          channels: _channels.join(','),
          customerName: _channels.contains("CREDIT_CARD") ? _nameController.text : '',
          customerSurname: _channels.contains("CREDIT_CARD") ? _surnameController.text : '',
          customerEmail: _channels.contains("CREDIT_CARD") ? _emailController.text : '',
          customerAddress: _channels.contains("CREDIT_CARD") ? _addressController.text : '',
          customerPhoneNumber: _channels.contains("CREDIT_CARD") ? _phoneController.text : '',
          customerCity: _channels.contains("CREDIT_CARD") ? _cityController.text : '',
          customerCountry: "CI",
          customerZipCode: _channels.contains("CREDIT_CARD") ? _zipCodeController.text : '',
        ),
      ),
    );

    final now = DateTime.now();
    final formatter = DateFormat('yyyy MM dd HH:mm:ss');
    final date = formatter.format(now);

    FirebaseDatabase.instance.ref('transactions').push().set({
      'transaction_id': transactionId,
      'amount': amount,
      'date': date,
      'status': 'OK',
    });
  }
}
