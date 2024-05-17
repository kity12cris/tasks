import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import '../../config/custom_details.dart';
//import '../../core/db_repository.dart';

class LoginController extends GetxController{

   String? token;
  //final DBRepository _base = DBRepository();
  late GoogleSignIn _googleSignIn = new GoogleSignIn();

  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? user=await _googleSignIn.signIn();
    if(user != null){
      final name=user.displayName;
      final url= user.photoUrl;
      final email= user.email;
      //En esta linea se toma el token acces y el IdToken de google para poder acceder a los microservicios.
      final GoogleSignInAuthentication googleAuth = await user.authentication;
      token=googleAuth.idToken;
       // usuario= new Usuario(correo: email, nombre:name.toString(),fotoUrl: url.toString(), tokenId: token.toString(), mode: 'google');
        //this._base.set('usuario', usuario?.toMap());
        Get.snackbar("Chale", 'Bienvenido ' + name! );
        Future.delayed(Duration(seconds: 2),
              (){
            Get.toNamed("/homepage");
          },);


    }else{
      Get.snackbar("Error", "What");
      Future.delayed(Duration(seconds: 3));
    }
  }
 /* Future<bool> consulta_usuario() async {
    var us= await this._base.get('usuario');
    if(us.isEmpty){
      print('No hay USUARIO registrado');
      return false;
    }else{
      usuario=new Usuario(correo: us["correo"], nombre: us["nombre"], fotoUrl: us["fotoUrl"], tokenId: us["tokenId"], mode: us["mode"]);
      print("esto encontro: ${us.toString()}");
      return true;
    }
  }*/

  Future<void> SignInSilencioso() async {
    GoogleSignInAccount? currentUser = _googleSignIn.currentUser;
    if (currentUser == null) {
      currentUser = await _googleSignIn.signInSilently();
    }
    currentUser?.authentication.then((value) {
      token=value.idToken.toString();
      debugPrint('[TokenNuevo] ${value.idToken.toString()}');
    });
  }

  Future<void> handleSignOut() async{
    _googleSignIn.disconnect();
    // GoogleSignIn().disconnect();
    //await this._base.del('usuario');
    Get.toNamed("/loginpage");
  }

}


