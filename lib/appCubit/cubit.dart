import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/appCubit/status.dart';
import 'package:shop_app/model/home_model.dart';
import 'package:shop_app/model/model.dart';
import 'package:shop_app/screens/category_screen.dart';
import 'package:shop_app/screens/favorit_screen.dart';
import 'package:shop_app/screens/products_screen.dart';

import '../EndPoints/end_points.dart';
import '../constat.dart';
import '../dio/dio_helper.dart';
import '../model/categories_model.dart';
import '../model/fav_model.dart';
import '../model/get_favourites_model.dart';
import '../screens/settings_screen.dart';

class ShopCubit extends Cubit<ShopStatus>{
  ShopCubit() : super(ShopInitialState());

static  ShopCubit get(context)=> BlocProvider.of(context);
int currantIndex = 0;

List<Widget> screen =
[
const ProductsScreen(),
  const CategoryScreen(),
  const FavoriteScreen(),
    SettingsScreen(),

];
void changeNavBar(int index)
{
currantIndex = index;
emit(ShopChangeBottomState());
}
  HomeModel? homeModel;
Map<int?, bool> favourites = {};
void getHomeData()
{
  emit(ShopLoadingState());
  DioHelper.getData(
      url: HOME,
      token: token
  ).then(
          (value) {
            homeModel = HomeModel.fromJson(value.data);

            homeModel!.data!.products.forEach((element) {
              favourites.addAll({
                element.id!:element.inFavorite!,
              });
            });
            print(favourites.toString());

            emit(ShopSuccessState());
          }).catchError((error)
  {
    emit(ShopErrorState());
print(error);
  });
}

  CategoriesModel? categoriesModel;
  void getCategoryData()
  {

    DioHelper.getData(
        url: GET_CATEGORIES,
    ).then(
            (value) {
              categoriesModel = CategoriesModel.fromJson(value.data);
          print(categoriesModel!.data!);
          print(categoriesModel?.status);

          emit(ShopSuccessCategoryState());
        }).catchError((error)
    {
      emit(ShopErrorCategoryState());
      print(error);
    });
  }
  FavouritesDataModel? favouritesDataModel;
  void changeFavourites(int? productId)
  {
    favourites[productId] =  !favourites[productId]!;
    emit(ShopFavouritesState());
    DioHelper.postData(
        url: FAVOURITES,
        data: {
          'product_id':productId
        },
    token: token,

    ).then((value) {
      favouritesDataModel = FavouritesDataModel.fromJson(value.data);
      print(value.data);
      if(!favouritesDataModel!.status!){
        favourites[productId] =  !favourites[productId]!;
      }else{
        getFavouritesData();
      }
      emit(ShopSuccessFavouritesState(favouritesDataModel!));
    }).catchError(
            (error){
              emit(ShopErrorFavouritesState());
            });
  }

  FavouritesModel? favouritesModel;
  void getFavouritesData()
  {
emit(ShopLoadingGetFavouritesState());
    DioHelper.getData(
      url: FAVOURITES,
      token: token
    ).then(
            (value) {
              favouritesModel = FavouritesModel.fromJson(value.data);
          print(favouritesModel!.data!);
          print(favouritesModel?.status);

          emit(ShopSuccessGetFavouritesState());
        }).catchError((error)
    {
      emit(ShopErrorGetFavouritesState());
      print(error);
    });
  }
  ShopLoginModel? shopLoginModel;
  void getUserData()
  {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
        url: PROFILE,
        token: token
    ).then(
            (value) {
              shopLoginModel = ShopLoginModel.fromJson(value.data);
          // print(favouritesModel!.data!);
          // print(favouritesModel?.status);
              print(shopLoginModel!.data!.name);

          emit(ShopSuccessUserDataState());
        }).catchError((error)
    {
      emit(ShopErrorUserDataState());
      print(error);
    });
  }
  void updateUserData({
    required name,
    required email,
    required phone,
})
  {
    emit(ShopLoadingUpdateUserDataState());
    DioHelper.putData(
      data: {
        'name' : name,
        'email' : email,
        'phone' : phone,
      },
        url: UPDATE_PROFILE,
        token: token
    ).then(
            (value) {
          shopLoginModel = ShopLoginModel.fromJson(value.data);
          // print(favouritesModel!.data!);
          // print(favouritesModel?.status);
          print(shopLoginModel!.data!.name);

          emit(ShopSuccessUpdateUserDataState());
        }).catchError((error)
    {
      emit(ShopErrorUpdateUserDataState());
      print(error);
    });
  }
}