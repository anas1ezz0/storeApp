


import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Login_bloc/status.dart';
import 'package:shop_app/Register_bloc/status.dart';

import '../EndPoints/end_points.dart';
import '../dio/dio_helper.dart';
import '../model/model.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterState> {
  ShopRegisterCubit() :super(ShopRegisterInitialState());
static ShopRegisterCubit get(context) =>BlocProvider.of(context);
  IconData  suffix = Icons.visibility_outlined ;
  bool isPassword = true;
late  ShopLoginModel loginModel;
  void changePasswordVisibility(){
    isPassword = !isPassword;
    suffix =isPassword? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopRegisterChangeVisibilityState());
  }

  void userRegister ({
    required name ,
    required email ,
    required password ,
    required phone ,
})

  {
    emit(ShopRegisterLoadingState());
  DioHelper.postData(
      url:REGISTER ,
      data: {
    'name' : name,
    'email' :email ,
    'password' :password,
    'phone' :phone ,

  }).then((value) {
    print(value);
    loginModel= ShopLoginModel.fromJson(value.data,);
    print(loginModel.data?.name);
    emit(ShopRegisterSuccsessState(ShopLoginModel.fromJson(value.data)));
  }).catchError((error){
    emit(ShopRegisterErrorState(error.toString()));
    print(error.toString());
  });
  }
}