import 'package:shop_app/model/model.dart';

abstract class ShopLoginState{}

class ShopLoginInitialState extends ShopLoginState{}
class ShopLoginLoadingState extends ShopLoginState{}
class ShopLoginSuccsessState extends ShopLoginState{
  final ShopLoginModel loginModel;


  ShopLoginSuccsessState(this.loginModel);}
class ShopLoginErrorState extends ShopLoginState{
  final String error;

  ShopLoginErrorState(this.error);
}
class ShopChangeVisibilityState extends ShopLoginState{}