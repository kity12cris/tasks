import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:tasks/presentation/pages/home_page.dart';
import 'package:tasks/presentation/pages/new_account_page.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../config/colors.dart';
import '../../config/text_styles.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../core/util.dart';
import '../controllers/login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = Get.put(LoginController());
  final _formKey= GlobalKey<FormState>();
  late String email;
  late String pass;


  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(

      body: GetBuilder<LoginController>(
        init: LoginController(),
        builder: (_){
          return SingleChildScrollView(
            padding: const EdgeInsets.all(10),
              child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Padding(padding: const EdgeInsets.all(8.0),
                  child: formulario(screenSize,_),
                )
              ],
            ),
          );
        },
      )
    );
  }

  Widget formulario(var screenSize, LoginController lc){
    return Form(
        key: _formKey,
        child: Column(
      children: [
        SizedBox(height: screenSize.height * 0.15),
        Text("Iniciar Sesión",
          style: AppTextStyle.labelTitle,
        ),
        SizedBox(height: screenSize.height * 0.025),
        boxEmail(),
        SizedBox(height: screenSize.height * 0.015),
        BoxPass(),
        ButtonEnter(screenSize.height * 0.35),
        ButtonGoogle(lc),
        SizedBox(height: screenSize.height * 0.045),
        Row(children: [
          Expanded(child: Divider()),
          Text(
            "Otras opciones",
            style: AppTextStyle.bottonRegistry,
          ),
          Expanded(child: Divider()),
        ],),

        ButtonCreateAcount(),
        ButtonRememberPass()
      ],
    ));
  }


  Widget boxEmail(){
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Correo Electrónico",
        border: OutlineInputBorder(
          borderRadius: new BorderRadius.circular(8),
          borderSide: new BorderSide(color: Colors.black)
        )
      ),
      keyboardType: TextInputType.emailAddress,
      onSaved: (String? value){
        email=value!;
      },
      validator: (value){
        if(value!.isEmpty){
          return "Debe ingresar su email registrado";
        }
        return null;
      },
    );
  }
  Widget BoxPass(){
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Contraseña",
          border: OutlineInputBorder(
              borderRadius: new BorderRadius.circular(8),
              borderSide: new BorderSide(color: Colors.black)
          )
      ),
      obscureText: true,
      keyboardType: TextInputType.emailAddress,
      onSaved: (String? value){
        pass=value!;
      },
      validator: (value){
        if(value!.isEmpty){
          return "Ingrese su contraseña";
        }
        return null;
      },
    );
  }

  Widget ButtonEnter(var screenSize){
    return TextButton.icon(
      style: TextButton.styleFrom(
        foregroundColor: CustomColors.fifthColorCustom,
        backgroundColor: CustomColors.secondColorCustom,
        fixedSize: Size(screenSize, 20)
      ),
      onPressed: () async {
        if(_formKey.currentState!.validate()){
          _formKey.currentState!.save();
          UserCredential? credentials = await loginByEmailAndPass(email,pass);
          if(credentials!=null){
            if(credentials.user!=null){
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> HomePage()), (route) => false);
            }else{
              showToastError("Credenciales inválidas");
            }
          }

        }else{
          showToastError("Completa los campos obligatorios");
        }



      },
      icon: const Icon(Icons.input),
      label: const Text('Ingresar'),
    );
  }

  Widget ButtonGoogle(LoginController lc){
    return SignInButton(
      Buttons.Google,
      text: "Ingresa con Google",
      onPressed: () async{
        if(await CheckConnection()){
          lc.signInWithGoogle();
        }else{
          Get.snackbar("Error", "Error");
          Future.delayed(Duration(seconds: 3));
        };

      },
    );
  }
  Widget ButtonCreateAcount(){
    return  TextButton(
          child: Text(
            "Registrarme",
            style: AppTextStyle.bottonRegistry,
          ),
          onPressed: () async {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateAccountPage()));
           // launchUrl(Uri.parse(""));
          },
    );
  }
  Widget ButtonRememberPass(){
    return TextButton(
      child: Text(
        "Olvide mi contraseña",
        style: AppTextStyle.bottonRememberPass,
      ),
      onPressed: () async {
        launchUrl(Uri.parse(""));
      },
    );
  }

  void showToastError(String data) => Fluttertoast.showToast(
      msg: data,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      textColor: Colors.white,
      fontSize: 16.0
  );

  Future<UserCredential?> loginByEmailAndPass(String email, String pass) async{
    try{
      UserCredential userCredential= await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: pass);
      return userCredential;
    }
    //se debe implementar un uso correcto para los diferentes errores y excepciones
    on FirebaseAuthException catch(e) {
      print("No pudo ingresar: "+e.code);
    }

  }
}