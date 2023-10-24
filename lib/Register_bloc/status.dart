import 'package:shop_app/model/model.dart';

abstract class ShopRegisterState{}

class ShopRegisterInitialState extends ShopRegisterState{}
class ShopRegisterLoadingState extends ShopRegisterState{}
class ShopRegisterSuccsessState extends ShopRegisterState{
  final ShopLoginModel loginModel;


  ShopRegisterSuccsessState(this.loginModel);}
class ShopRegisterErrorState extends ShopRegisterState{
  final String error;

  ShopRegisterErrorState(this.error);
}
class ShopRegisterChangeVisibilityState extends ShopRegisterState{}