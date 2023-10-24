


import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Login_bloc/status.dart';

import '../EndPoints/end_points.dart';
import '../dio/dio_helper.dart';
import '../model/model.dart';

class ShopLoginCubit extends Cubit<ShopLoginState> {
  ShopLoginCubit() :super(ShopLoginInitialState());
static ShopLoginCubit get(context) =>BlocProvider.of(context);
  IconData  suffix = Icons.visibility_outlined ;
  bool isPassword = true;
  ShopLoginModel? loginModel;
  void changePasswordVisibility(){
    isPassword = !isPassword;
    suffix =isPassword? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopChangeVisibilityState());
  }

  void userLogin ({
    required email ,
    required password ,
})

  {
    emit(ShopLoginLoadingState());
  DioHelper.postData(
      url:LOGIN ,
      data: {
    'email' :email ,
    'password' :password

  }).then((value) {
    print(value);
    loginModel= ShopLoginModel.fromJson(value.data,);
    print(loginModel!.data!.name);
    emit(ShopLoginSuccsessState(ShopLoginModel.fromJson(value.data)));
  }).catchError((error){
    emit(ShopLoginErrorState(error.toString()));
  });
  }
}