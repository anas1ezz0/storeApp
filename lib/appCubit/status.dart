import '../model/fav_model.dart';

class ShopStatus {}
class ShopInitialState extends ShopStatus{}
class ShopChangeBottomState extends ShopStatus{}
class ShopLoadingState extends ShopStatus{}
class ShopSuccessState extends ShopStatus{}
class ShopErrorState extends ShopStatus{}
class ShopSuccessCategoryState extends ShopStatus{}
class ShopErrorCategoryState extends ShopStatus{}
class ShopFavouritesState extends ShopStatus{}
class ShopSuccessFavouritesState extends ShopStatus{
  final FavouritesDataModel model;

  ShopSuccessFavouritesState(this.model);
}
class ShopErrorFavouritesState extends ShopStatus{}

class ShopSuccessGetFavouritesState extends ShopStatus{}
class ShopErrorGetFavouritesState extends ShopStatus{}
class ShopLoadingGetFavouritesState extends ShopStatus{}

class ShopSuccessUserDataState extends ShopStatus{}
class ShopErrorUserDataState extends ShopStatus{}
class ShopLoadingUserDataState extends ShopStatus{}

class ShopSuccessUpdateUserDataState extends ShopStatus{}
class ShopErrorUpdateUserDataState extends ShopStatus{}
class ShopLoadingUpdateUserDataState extends ShopStatus{}