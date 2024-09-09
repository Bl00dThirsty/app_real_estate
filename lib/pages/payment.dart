import 'package:Resmartha/pages/success.dart';
import 'package:flutter/material.dart';

import '../constant/constant.dart';
import '../widgets/default_appbar.dart';
import '../widgets/default_back_button.dart';
import '../widgets/default_button.dart';
import '../widgets/header_label.dart';

class Payment extends StatefulWidget {
  Payment({Key? key}) : super(key: key);

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  int value = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: 'Abonnement',
        child: DefaultBackButton(),
      ),
      body: Column(
        children: [
          HeaderLabel(
            headerText: 'Choisir votre méthode de paiement et devenez propriétaire',
          ),
          Expanded(
            child: ListView.separated(
              itemCount: paymentLabels.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Radio(
                    activeColor: kPrimaryColor,
                    value: index,
                    groupValue: value,
                    onChanged: (i) => setState(() => value = i!),
                  ),
                  title: Text(
                    paymentLabels[index],
                    style: TextStyle(color: kDarkColor),
                  ),
                  trailing: Icon(paymentIcons[index], color: kPrimaryColor),
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
            ),
          ),
          DefaultButton(
            btnText: 'Payez',
            onPressed: () => Navigator.of(context).pushNamed('/success'),
          ),
        ],
      ),
    );
  }
}
