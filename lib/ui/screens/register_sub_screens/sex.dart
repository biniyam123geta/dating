import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:dating/util/constants.dart';
class Sex extends StatefulWidget {
  final Function(String) onChanged;

  Sex({@required this.onChanged});

  @override
  _SexState createState() => _SexState();
}

class _SexState extends State<Sex> {

  String _chosenValue;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My',
                style: Theme.of(context).textTheme.headline3,
              ),
              Text(
                'Sex is',
                style: Theme.of(context).textTheme.headline3,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(20),
          child: Center(
            child: DropdownButton<String>(
              focusColor:Colors.white,
              value: _chosenValue,
              //elevation: 5,
              style: TextStyle(color: Colors.white),
              iconEnabledColor:Colors.white,
              items: <String>[
                'Male',
                'Female',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value,style:TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize: 20,fontFamily: kFontFamily)),
                );
              }).toList(),
              hint:Text(
                "Please choose a sex",
                style: TextStyle(
                    fontSize: 20,
                    color:kAccentColor,
                    fontFamily:kFontFamily ,
                    fontWeight: FontWeight.w500),
                   ),
                    onChanged: (value) => {
                   setState(() {
                   _chosenValue = value;
                      }),
                   widget.onChanged(value)
    }),
            ),
          ),
      ],
    );
  }
}
