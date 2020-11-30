import 'dart:ui';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spot_promo_test/base/controllers/user_controller.dart';
import 'package:spot_promo_test/utils/custom_colors.dart';
import 'package:spot_promo_test/utils/custom_fonts.dart';
import 'package:spot_promo_test/widgets/custom_label.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var _formKey = GlobalKey<FormState>();
  var _nameController = TextEditingController();
  var _dateController = TextEditingController();
  var _userController = TextEditingController();
  var _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.reddishRose,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 30),
                  color: Colors.white,
                  padding: EdgeInsets.all(40),
                  child: Image.asset("lib/assets/images/logo_spot.png"),
                ),
                CustomLabel(
                  text: "NOME",
                  isTitle: true,
                ),
                _formField(_nameController, _validName),
                CustomLabel(
                  text: "DATA DE NASCIMENTO",
                  isTitle: true,
                ),
                _formField(_dateController, _validDate, isDate: true),
                CustomLabel(
                  text: "USUÁRIO",
                  isTitle: true,
                ),
                _formField(_userController, _validUser),
                CustomLabel(
                  text: "SENHA",
                  isTitle: true,
                ),
                _formField(_passController, _validPass),
                _btn(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _formField(controller, validator, {bool isDate = false}) {
    return Container(
      padding: EdgeInsets.all(15),
      child: TextFormField(
        controller: controller,
        validator: validator,
        inputFormatters: isDate
            ? [
                FilteringTextInputFormatter.digitsOnly,
                DataInputFormatter(),
              ]
            : [],
        keyboardType: isDate ? TextInputType.number : TextInputType.text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
          fontFamily: CustomFonts.fontRegular,
          color: Colors.white,
        ),
        decoration: InputDecoration(
          errorStyle: TextStyle(
            color: Colors.yellow,
            fontFamily: CustomFonts.fontRegular,
          ),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
            color: CustomColors.greenishYellow,
          )),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
            color: Colors.white,
          )),
        ),
      ),
    );
  }

  String _validName(String text) {
    if (text.isEmpty || text.length < 2) {
      return "Necessário incluir um nome";
    }
    return null;
  }

  String _validDate(String text) {
    if (text.isEmpty) {
      return "Necessário incluir a data de nascimento";
    }
    if (text.length < 10) {
      return "Necessário retornar uma data válida no formato dd/mm/aaaa";
    }
    return null;
  }

  String _validUser(String text) {
    if (text.isEmpty) {
      return "Necessário incluir um usuário";
    }
    return null;
  }

  String _validPass(String text) {
    if (text.isEmpty) {
      return "Necessário incluir a senha";
    }
    if (text.length < 3) {
      return "Necessário que a senha tenha pelo menos 3 digitos";
    }
    return null;
  }

  Widget _btn() {
    return Container(
      child: ButtonTheme(
        buttonColor: CustomColors.greenishYellow,
        child: RaisedButton(
          child: CustomLabel(
            text: "CADASTRAR",
            fontSize: 25,
          ),
          onPressed: () async {
            bool isValid = _formKey.currentState.validate();
            var serviceReturn;
            if (isValid) {
              serviceReturn = await UserController.createUser(
                  name: _nameController.text,
                  dateOfBirth: _dateController.text,
                  userName: _userController.text,
                  pass: _passController.text);
            }

            if (serviceReturn[0]) {
              Navigator.pushNamedAndRemoveUntil(
                  context, 'newRouteName', (route) => false);
            } else {
              showDialog(
                  context: (context),
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: CustomColors.reddishRose,
                      content: Text(serviceReturn[1]),
                      actions: [
                        FlatButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text("Fechar"))
                      ],
                    );
                  });
            }
          },
        ),
      ),
    );
  }
}
