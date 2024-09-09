import 'package:flutter/material.dart';

import '../constant/constant.dart';

class DefaultButton extends StatelessWidget {
  final String btnText;
  final VoidCallback onPressed;
  const DefaultButton({
     super.key, required this.btnText, required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(vertical: kDefaultPadding),
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: kLessPadding),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kShape),
          ),
          backgroundColor: Colors.blue,
        ),
        onPressed: onPressed,
        child: Text(btnText.toUpperCase(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),
      ),

    );
  }
}