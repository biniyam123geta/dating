import 'package:flutter/material.dart';
import 'package:dating/util/constants.dart';

class RoundedOutlinedButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  RoundedOutlinedButton({@required this.text, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        // ignore: deprecated_member_use
        child: OutlineButton(
          highlightedBorderColor: kAccentColor,
          borderSide: BorderSide(color: kSecondaryColor, width: 2.0),
          child: Text(text, style: Theme.of(context).textTheme.button),
          onPressed: onPressed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ));
  }
}
