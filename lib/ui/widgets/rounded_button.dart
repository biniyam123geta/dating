import 'package:flutter/material.dart';
import 'package:dating/util/constants.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  RoundedButton({@required this.text, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // ignore: deprecated_member_use
      child: RaisedButton(
        disabledColor: kAccentColor.withOpacity(0.25),
        padding: EdgeInsets.symmetric(vertical: 14),
        highlightElevation: 0,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        child: Text(text, style: Theme.of(context).textTheme.button),
        onPressed: onPressed,
      ),
    );
  }
}
