import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/Register_bloc/cubit.dart';
import 'package:shop_app/Register_bloc/status.dart';


import '../CashHelper/cash_helper.dart';
import '../compo/compo.dart';
import '../constat.dart';
import 'home_page.dart';

class RegisterScreen extends StatelessWidget {
   RegisterScreen({super.key});
  var formKey =  GlobalKey<FormState>();
   var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: BlocProvider(
          create: (context) => ShopRegisterCubit(),
          child: BlocConsumer<ShopRegisterCubit,ShopRegisterState>(
            listener: (context, state) {
              if(state is ShopRegisterSuccsessState){
                if(state.loginModel.status){
                  print(state.loginModel.data!.token);

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
            },
            builder: (context, state) {
              return Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Register' ,
                            style: TextStyle
                              (
                                fontSize: 30 ,
                                fontWeight: FontWeight.bold),),
                          const SizedBox(height: 15,),
                          const Text('Register to show our offers' ,),
                          const SizedBox(height: 15,),
                          defaultFormField(
                              controller: nameController,
                              type: TextInputType.name,
                              validate: (String value){
                                if(value.isEmpty){
                                  return 'Name must not be empty';
                                }
                              },
                              label: 'Name',
                              prefix: Icons.person),
                          const  SizedBox(height: 25,),
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
                          const  SizedBox(height: 15,),
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
                              suffix: ShopRegisterCubit.get(context).suffix,
                              isPassword: ShopRegisterCubit.get(context).isPassword,
                              suffixPressed: (){
                                ShopRegisterCubit.get(context).changePasswordVisibility();
                              }
                          ),
                          const  SizedBox(height: 15,),
                          defaultFormField(
                              controller: phoneController,
                              type: TextInputType.phone,
                              validate: (String value){
                                if(value.isEmpty){
                                  return 'phone must not be empty';
                                }
                              },
                              label: 'phone',
                              prefix: Icons.phone),
                          const  SizedBox(height: 22,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: ConditionalBuilder(
                              condition: state is! ShopRegisterLoadingState,
                              builder: (context) => defaultButton(function: (){
                                if(formKey.currentState!.validate()){
                                  ShopRegisterCubit.get(context).userRegister(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name: nameController.text,
                                      phone: phoneController.text,
                                  );
                                }

                              }, text: 'Register',isUpperCase: true),
                              fallback: (context) =>const Center(child: CircularProgressIndicator(color: Colors.teal,)),
                            ),
                          ),
                        ],),
                    ),
                  ),
                ),
              );
            },

          ),
        )
    );
  }
}
