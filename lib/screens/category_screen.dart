import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/appCubit/cubit.dart';
import 'package:shop_app/appCubit/status.dart';
import 'package:shop_app/model/categories_model.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStatus>(
      listener: (context, state) {},
        builder: (context, state) {
   return Padding(
     padding: const EdgeInsets.all(15.0),
     child: ListView.separated(
     itemBuilder:(context, index) => buildCategoryList(ShopCubit.get(context).categoriesModel!.data!.data[index]) ,
      separatorBuilder: (context, index) => Divider(), itemCount:ShopCubit.get(context).categoriesModel!.data!.data.length ),
   );
        }
    );
  }
  Widget buildCategoryList(DataModel model)=>  Row(
    children: [
      Image(image: NetworkImage('${model.image}'),width: 100,height: 100,),
      Text('${model.name}'),
      Spacer(),
      Icon(Icons.arrow_forward_ios)
    ],
  );
}
