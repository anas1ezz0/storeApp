import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/model/get_favourites_model.dart';

import '../appCubit/cubit.dart';
import '../appCubit/status.dart';
import '../compo/compo.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopCubit,ShopStatus>(
        listener: (context, state) {},
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: ConditionalBuilder(
              condition:state is! ShopLoadingGetFavouritesState ,
              builder: (context) => ListView.separated(
                  itemBuilder:(context, index) => buildListProduct(ShopCubit.get(context).favouritesModel?.data?.data![index].product, context),
                  separatorBuilder: (context, index) => Divider(), itemCount: ShopCubit.get(context).favouritesModel!.data!.data!.length, ),
              fallback: (context) =>const Center(child:  CircularProgressIndicator(color: Colors.teal,)),

            ),
          );
        }
    );
  }

}
