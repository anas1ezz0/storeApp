import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/appCubit/cubit.dart';
import 'package:shop_app/appCubit/status.dart';
import 'package:shop_app/compo/compo.dart';
import 'package:shop_app/constat.dart';

class SettingsScreen extends StatelessWidget {
   SettingsScreen({super.key});
   var formkey = GlobalKey<FormState>();
var nameCtrl = TextEditingController();
var emailCtrl = TextEditingController();
var phoneCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStatus>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).shopLoginModel;
        nameCtrl.text = model!.data!.name!;
        emailCtrl.text = model.data!.email!;
        phoneCtrl.text = model.data!.phone!;
        return ConditionalBuilder(
          condition: ShopCubit.get(context).shopLoginModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: formkey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if(state is ShopLoadingUpdateUserDataState)
                    LinearProgressIndicator(color: Colors.teal,),
                    SizedBox(height: 15,),
                    defaultFormField(
                        controller: nameCtrl,
                        type: TextInputType.name,
                        validate: (String value){
                          if(value.isEmpty){
                            return 'name must not be empty';
                          }
                        },
                        label: 'Name',
                        prefix: Icons.person
                    ),
                    const SizedBox(height: 15,),
                    defaultFormField(
                        controller: emailCtrl,
                        type: TextInputType.emailAddress,
                        validate: (String value){
                          if(value.isEmpty){
                            return 'email must not be empty';
                          }
                        },
                        label: 'Email',
                        prefix: Icons.email_outlined
                    ),
                    const SizedBox(height: 15,),
                    defaultFormField(
                        controller: phoneCtrl,
                        type: TextInputType.visiblePassword,
                        validate: (String value){
                          if(value.isEmpty){
                            return 'phone must not be empty';
                          }
                        },
                        label: 'phone',
                        prefix: Icons.phone
                    ),
                    const SizedBox(height: 15,),
                    defaultButton(function: (){signOut(context);}, text: 'log out'.toUpperCase()),
                    const SizedBox(height: 15,),
                    defaultButton(
                        function: (){
                          if(formkey.currentState!.validate()){
                            ShopCubit.get(context).updateUserData(name: nameCtrl.text, email: emailCtrl.text, phone: phoneCtrl.text);
                          }

                      }, text: 'update'.toUpperCase())

                  ],
                ),
              ),
            ),
          ),
          fallback: (context) => const Center(child: CircularProgressIndicator()),

        );
      },
    );
  }
}
