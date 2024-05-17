import 'package:internet_connection_checker/internet_connection_checker.dart';

Future<bool> CheckConnection() async{
  bool result = await InternetConnectionChecker().hasConnection;
  return result;
}
