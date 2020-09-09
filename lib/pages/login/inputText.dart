import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


/// Creates a Input Widget .
///
/// * String [placeholder, initValue]  .
/// /// * If [validator] color for icon .
/// iconPath for input
class InputText extends StatefulWidget {
  final String placeholder, initValue;
  final Function(String text) validator;
  final ValueChanged<String>  onChanged;
  final bool showIcon, typePassword;
  final IconData iconPath;
  final TextInputType keyboardType;
  final bool onlyReal;
  final FormFieldSetter<String> onSaved;

  const InputText(
      {Key key,
        this.iconPath = FontAwesomeIcons.font,
        this.placeholder = '',
        this.validator,
        this.onSaved,
        this.onChanged,
        this.initValue = '',
        this.showIcon = true,
        this.keyboardType,
        this.typePassword = false, this.onlyReal = false})
      : assert(placeholder != null),
        super(key: key);

  @override
  _InputTextState createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  TextEditingController _controller;
  bool _validationOk = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initValue);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: new ThemeData(
        primaryColor: Colors.grey
      ),
      child: TextFormField(
        onSaved: widget.onSaved,
        onChanged: this.widget.onChanged,
        controller: _controller,
        validator: this.widget.validator,
        keyboardType: widget.keyboardType,
        obscureText: this.widget.typePassword,
        readOnly: widget.onlyReal,
        decoration: InputDecoration(
          border: new OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.only(top: 6.0, left: 10.0),
              child: FaIcon(
                this.widget.iconPath,
                size: 16,
              ),
            ),
          ),
          hintText: widget.placeholder,
        ),
      ),
    );
  }
}
