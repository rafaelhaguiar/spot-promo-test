import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spot_promo_test/base/controllers/user_controller.dart';
import 'package:spot_promo_test/utils/custom_colors.dart';
import 'package:spot_promo_test/utils/custom_fonts.dart';
import 'package:spot_promo_test/widgets/custom_label.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  var userController = TextEditingController();
  var passController = TextEditingController();

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.reddishRose,
      body: Container(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _containerLogo(constraints),
                    SizedBox(height: constraints.maxHeight / 10),
                    _textField("USUÁRIO", userController, _validarUsuario),
                    SizedBox(height: constraints.maxHeight / 80),
                    _textField("SENHA", passController, _validarSenha,
                        isPass: true, isFinalInput: true),
                    FlatButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, "/register"),
                        child: CustomLabel(
                          color: Colors.white,
                          text: "Não possui cadastro? CLIQUE AQUI",
                        )),
                    CustomLabel(
                      text: "",
                    ),
                    _btn(constraints, _onClickLogin),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _btn(BoxConstraints constraints, Function function) {
    return Container(
      margin: EdgeInsets.only(bottom: 8, top: 18),
      child: ButtonTheme(
        buttonColor: CustomColors.greenishYellow,
        padding: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        minWidth: constraints.maxWidth * .9,
        child: RaisedButton(
          onPressed: () => function(),
          child: CustomLabel(
            text: "ENTRAR",
            fontSize: constraints.maxWidth / 20,
          ),
        ),
      ),
    );
  }

  _textField(String label, TextEditingController controller,
      FormFieldValidator<String> validator,
      {bool isPass = false, bool isFinalInput = false}) {
    return Container(
      padding: EdgeInsets.all(20),
      child: TextFormField(
        controller: controller,
        validator: validator,
        textInputAction:
            isFinalInput ? TextInputAction.send : TextInputAction.next,
        obscureText: isPass,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          errorStyle: TextStyle(color: Colors.yellow),
          labelText: label,
          labelStyle: TextStyle(
              fontSize: 20,
              fontFamily: CustomFonts.fontRegular,
              color: Colors.white),
          enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: CustomColors.greenishYellow, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(40))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(40))),
        ),
      ),
    );
  }

  _containerLogo(BoxConstraints constraints) {
    return Container(
      padding: EdgeInsets.all(30),
      height: constraints.maxHeight / 3.5,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(80), bottomRight: Radius.circular(80)),
      ),
      child: Image.asset('lib/assets/images/logo_spot.png'),
    );
  }

  String _validarUsuario(String value) {
    if (value.isEmpty) {
      return "Digite um usuário";
    }
    return null;
  }

  String _validarSenha(String value) {
    if (value.isEmpty) {
      return "Digite uma senha";
    }
    return null;
  }

  _onClickLogin() async {
    bool isValid = _formKey.currentState.validate();
    if (isValid) {
      var result = await UserController.login(
          userName: userController.text, pass: passController.text);
      if (result[0]) {
        Navigator.pushNamedAndRemoveUntil(
            context, '/products', (route) => false);
      } else {
        showDialog(
            context: (context),
            builder: (context) {
              return AlertDialog(
                backgroundColor: CustomColors.reddishRose,
                content: Text(result[1]),
                actions: [
                  FlatButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("Fechar"))
                ],
              );
            });
      }
      return;
    }
  }
}
