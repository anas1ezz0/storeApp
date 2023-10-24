// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable, avoid_print



import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/CashHelper/cash_helper.dart';
import 'package:shop_app/constat.dart';
import 'package:shop_app/screens/register_screen.dart';


import '../Login_bloc/cubit.dart';
import '../Login_bloc/status.dart';
import '../compo/compo.dart';
import 'home_page.dart';

class ShopLoginScreen extends StatelessWidget
{

  ShopLoginScreen({super.key});

  var formKey =  GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginState>(
        listener: ((context, state) {
          if(state is ShopLoginSuccsessState){
            if(state.loginModel.status){
              print(state.loginModel.data?.token);

              CacheHelper.saveData(key: 'token', value: state.loginModel.message).then((value) {
                token = state.loginModel.data!.token!;
                navigateAndFinsh(context, HomePage());
              });
            }else{
              print(state.loginModel.message);
              Fluttertoast.showToast(
                  msg: state.loginModel.message!,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            }
          }
        }),
        builder: (context, state) {
          return  Scaffold(
              appBar: AppBar(),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Login' ,
                            style: TextStyle
                              (
                                fontSize: 30 ,
                                fontWeight: FontWeight.bold),),
                          SizedBox(height: 15,),
                          Text('Login to show our offers' ,),
                          SizedBox(height: 25,),
                          defaultFormField(
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              validate: (String value){
                                if(value.isEmpty){
                                  return 'Email must not be empty';
                                }
                              },
                              label: 'Email',
                              prefix: Icons.email),
                          SizedBox(height: 15,),
                          defaultFormField(
                              controller: passwordController,
                              type: TextInputType.visiblePassword,
                              validate: (String value){
                                if(value.isEmpty){
                                  return 'password must not be empty';
                                }
                              },
                              label: 'password',
                              prefix: Icons.lock_outline,


                              onSubmit: (value){
                                if(formKey.currentState!.validate())
                                {
                                  ShopLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }

                              },
                              suffix: ShopLoginCubit.get(context).suffix,
                              isPassword: ShopLoginCubit.get(context).isPassword,
                              suffixPressed: (){
                                ShopLoginCubit.get(context).changePasswordVisibility();
                              }
                          ),

                          SizedBox(height: 22,),
                          // ConditionalBuilder(
                          //   condition: state is! ShopLoginLoadingState ,
                          //   builder: (context) => defaultButton(function: (){
                          //     if(formKey.currentState!.validate()){
                          //       ShopLoginCubit.get(context).userLogin(
                          //           email: emailController.text,
                          //           password: passwordController.text);
                          //     }
                          //
                          //   },
                          //       text: 'login', isUpperCase: true),
                          //   fallback:(context) => Center(child: CircularProgressIndicator()),
                          //
                          // ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: ConditionalBuilder(

                              condition:state is! ShopLoginLoadingState ,
                              builder: (context) => defaultButton(function: (){
                                if(formKey.currentState!.validate()){
                                  ShopLoginCubit.get(context).userLogin(email: emailController.text, password: passwordController.text);
                                }

                              }, text: 'Login',isUpperCase: true),
                              fallback: (context) => Center(child: CircularProgressIndicator(color: Colors.teal,)),
                                ),
                          ),
                          Row(
                            children: [
                              Text(' you don\'t have am email?'),
                              TextButton(onPressed: (){
                                navigateTo(context, RegisterScreen());
                              }, child: Text('Register here',style: TextStyle(color: Colors.teal),))
                            ],
                          ),
                          SizedBox(height: 20,),

                        ],),
                    ),
                  ),
                ),
              )
          );
        },
      ),
    );
  }
}