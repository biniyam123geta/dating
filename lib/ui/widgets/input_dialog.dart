import 'package:flutter/material.dart';
import 'package:dating/ui/widgets/bordered_text_field.dart';
import 'package:dating/util/constants.dart';

class InputDialog extends StatefulWidget {
  final String labelText;
  final Function(String) onSavePressed;
  final String startInputText;

  @override
  _InputDialogState createState() => _InputDialogState();

  InputDialog(
      {@required this.labelText,
      @required this.onSavePressed,
      this.startInputText = ''});
}

class _InputDialogState extends State<InputDialog> {
  String inputText = '';
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    textController.text = widget.startInputText;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: kBackgroundColor,
      contentPadding: EdgeInsets.all(16.0),
      content:new Theme(
      data: new ThemeData(
      primaryColor: Colors.redAccent,
      primaryColorDark: Colors.red,
      ),child:TextField(
       maxLength: 70,
        style:TextStyle(color: Colors.white),
        decoration: InputDecoration(
          border: new OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.teal)),
              labelText: textController.text,
              labelStyle: TextStyle(
              color: Colors.white
          ),
              prefixIcon: const Icon(
              Icons.favorite,
              color: Colors.pink,
          ),
            suffixText: 'Bio',
            suffixStyle: const TextStyle(color: Colors.pink,)
        ),
        textCapitalization: TextCapitalization.sentences,
        keyboardType: TextInputType.text,
        onChanged: (value) => {inputText = value},

      )),
      actions: <Widget>[
        // ignore: deprecated_member_use
        FlatButton(
          color: kColorPrimaryVariant,
          child: Text(
            'CANCEL',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        // ignore: deprecated_member_use
        FlatButton(
          color: kAccentColor,
          child: Text(
            'SAVE',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          onPressed: () {
            widget.onSavePressed(inputText);
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
