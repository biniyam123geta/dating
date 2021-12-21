import 'package:flutter/material.dart';
import 'package:dating/ui/widgets/bordered_text_field.dart';

class NameScreen extends StatelessWidget {
  final Function(String) onChanged;

  NameScreen({@required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Column(
            children: [
              Text(
                'My first',
                style: Theme.of(context).textTheme.headline3,
              ),
              Text(
                'name is',
                style: Theme.of(context).textTheme.headline3,
              ),
            ],
          ),
        ),
        SizedBox(height: 25),
        Expanded(
         child: new Theme(
              data: new ThemeData(
                primaryColor: Colors.redAccent,
                primaryColorDark: Colors.red,
              ),
              child:TextField(
                maxLength:12 ,
                style: TextStyle(color:Colors.black),
                decoration: new InputDecoration(
                  labelText: "Enter name",
                  hintText: "please Enter your name here...",
                  hintStyle: TextStyle(color:Colors.white70),
                  fillColor: Colors.black,
                  border: new OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2.0),
                    borderRadius: new BorderRadius.circular(25.0),

                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.pink, width: 2.0),
                  ),
                 suffixText: 'Name',
                  suffixStyle: const TextStyle(color: Colors.pink),
                 ),

                keyboardType: TextInputType.emailAddress,
                onChanged: onChanged,
              )),
        ),
      ],
    );
  }
}
