import 'package:shop/models/GetUserData.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopNavChangeBarState extends ShopStates {}

class ShopLoadingState extends ShopStates {}

class ShopSuccessState extends ShopStates {}

class ShopErrorState extends ShopStates {}

class ShopSuccessCategoryState extends ShopStates {}

class ShopErrorCategoryState extends ShopStates {}

class ShopSuccessFavouirteState extends ShopStates {}

class ShopErrorFavouriteState extends ShopStates {}

class ShopSuccessGetFavState extends ShopStates {}

class ShopErrorGetFavState extends ShopStates {}

class ShopSuccessfFavouirteState extends ShopStates {}

class ShopLoadingFavouirteState extends ShopStates {}

class ShopLoadingGetProfileState extends ShopStates {}

class ShopSuccessGetProfileState extends ShopStates {}

class ShopErrorGetProfileState extends ShopStates {}

class ShopLoadingSearchState extends ShopStates {}

class ShopSuccessSearchState extends ShopStates {}

class ShopErrorSearchState extends ShopStates {}
