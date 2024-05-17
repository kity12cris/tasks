import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../config/colors.dart';
import '../../config/text_styles.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {

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

        body:
             SingleChildScrollView(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(padding: const EdgeInsets.all(8.0),
                    child: formulario(screenSize),
                  )
                ],
              ),
            )
    );
  }

  Widget formulario(var screenSize){
    return Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(height: screenSize.height * 0.15),
            Text("Nuevo Registro",
              style: AppTextStyle.labelTitle,
            ),
            SizedBox(height: screenSize.height * 0.025),
            boxEmail(),
            SizedBox(height: screenSize.height * 0.015),
            BoxPass(),
            ButtonEnter(screenSize.height * 0.35),
            SizedBox(height: screenSize.height * 0.045),

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
          return "Debe ingresar un email";
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
          UserCredential? credentials = await createByEmailAndPass(email,pass);
          if(credentials!=null){
            if(credentials.user!=null){
              await credentials.user!.sendEmailVerification();
              Navigator.of(context).pop();
            }
            else{
              showToastError("No se pudo verificar sus credenciales");
            }
          }else{
            showToastError("Credenciales inválidas");
          }
        }else{
          showToastError("Complete los campos obligatorios");
        }



      },
      icon: const Icon(Icons.app_registration),
      label: const Text('Registrar'),
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

  Future<UserCredential?> createByEmailAndPass(String email, String pass) async{
    try{
      UserCredential userCredential= await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: pass);
      return userCredential;
    }
    //se debe implementar un uso correcto para los diferentes errores y excepciones
    on FirebaseAuthException catch(e) {
      return null;
    }

  }
}