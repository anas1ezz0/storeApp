

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/appCubit/cubit.dart';
import 'package:shop_app/appCubit/status.dart';
import 'package:shop_app/compo/compo.dart';
import 'package:shop_app/model/categories_model.dart';
import 'package:shop_app/model/home_model.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStatus>(
      listener: (context, state) {
        // if(state is ShopSuccessFavouritesState)
        //   {
        //     if(!state.model.status!){
        //       showToast(
        //           text: state.model.message!, state: ToastStates.error,);
        //     }
        //   }
      },
        builder: (context, state) {
          return ConditionalBuilder(
              condition: ShopCubit.get(context).homeModel != null && ShopCubit.get(context).categoriesModel != null,
              builder: (context) => productsBuilder(ShopCubit.get(context).homeModel,ShopCubit.get(context).categoriesModel,context),
              fallback: (context) => const Center(child: CircularProgressIndicator()),);
        },

    );
  }
  Widget productsBuilder(HomeModel? model , CategoriesModel? categoriesModel,context) => SingleChildScrollView(
    physics:const BouncingScrollPhysics() ,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         CarouselSlider(
             items: model?.data?.banners.map((e) => Image(image: NetworkImage(
                 '${e.image}',
             ),width: double.infinity,

             )).toList(),
             options: CarouselOptions(
               viewportFraction: 1.0,
               height: 200,
               autoPlay: true,
               initialPage: 0,
               enableInfiniteScroll: true,
               reverse: false,
               autoPlayInterval: const Duration(seconds: 3),
               autoPlayAnimationDuration:const Duration(seconds: 1),
               autoPlayCurve: Curves.fastOutSlowIn
             )),
         const SizedBox(
           height: 10,),
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 10),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,

             children: [
               const Text(
                 'Categories',style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700),),
               const SizedBox(
                 height: 10,),
               Container(
                 height: 100,
                 child: ListView.separated(
physics: const BouncingScrollPhysics(),
                     scrollDirection: Axis.horizontal,
                     itemBuilder: (context, index) => buildItemCategories(categoriesModel.data!.data[index],context),
                     separatorBuilder: (context, index) => const SizedBox(width: 10,),
                     itemCount: categoriesModel!.data!.data.length),
               ),
               const SizedBox(
                 height: 10,),
               const Text(
                 'New Products',style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700),),
               const SizedBox(
                 height: 10,),
             ],
           ),
         ),
         Container(
           color: Colors.grey[300],
           child: GridView.count(

               physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        childAspectRatio: 1 / 1.87,
             crossAxisSpacing: 2.5,
               mainAxisSpacing: 2.5,
               crossAxisCount: 2,
               children:
               List.generate(
               model!.data!.products.length, (index) => buildProductItem(model.data!.products[index],context)
               )

           ),
         )
       ],
    ),
  );
  Widget buildItemCategories(DataModel model,context) =>
      Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
       Image(
        image: NetworkImage('${model.image}'),
        width: 100,
        height: 100,
       fit: BoxFit.cover,
       ),
      Container(
        width: 100,
        color: Colors.black87,
        child:  Text('${model.name}',style: const TextStyle(color: Colors.white,),textAlign: TextAlign.center),)
    ],);
  Widget buildProductItem(ProductsModel model,context)=> Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Image(
    image: NetworkImage('${model.image}'),width: double.infinity,height: 200.0,),
            if(model.disCount != 0)
            Container(
              color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text('DISCOUNT',style: TextStyle(color: Colors.white,fontSize: 12),),
              ),)
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model.name}',overflow: TextOverflow.ellipsis,maxLines: 2,style: const TextStyle(fontWeight: FontWeight.w600),),
              Row(
                children: [
                  Text(
                    '${model.price.round()}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.teal),
                  ),
                  const SizedBox(
                    width: 10,),
                  if(model.disCount != 0)
                  Text(
                    '${model.price.round()}',
                    overflow: TextOverflow.ellipsis,

                    style: const TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey),
                  ),
                  Spacer(),
                  IconButton(onPressed: (){
                    ShopCubit.get(context).changeFavourites(model.id);
                    print(model.id);
                  }, icon:CircleAvatar(
                    radius: 15.0,
                    child: Icon(Icons.favorite_border_outlined,color: Colors.white,size: 20,),
                    backgroundColor:  ShopCubit.get(context).favourites[model.id]!?Colors.teal:Colors.grey,
                  )
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
