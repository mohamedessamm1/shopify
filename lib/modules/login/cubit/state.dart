import 'package:shop/models/login_models.dart';

abstract class shoploginstate {}

class shoplogininitialstate extends shoploginstate {}

class shoploginsuccesstate extends shoploginstate {
  final ShopLoginModel loginModel;

  shoploginsuccesstate(this.loginModel);
}

class shoploginloadingstate extends shoploginstate {}

class shoploginerrorstate extends shoploginstate {
  final String error;

  shoploginerrorstate(this.error);
}

class passstate extends shoploginstate {}

class ShopSuccessGetFavState extends shoploginstate {}

class ShopErrorGetFavState extends shoploginstate {}

class ShopLoadingGetProfileState extends shoploginstate {}

class ShopSuccessGetProfileState extends shoploginstate {}

class ShopSuccessCategoryState extends shoploginstate {}

class ShopErrorCategoryState extends shoploginstate {}

class ShopErrorGetProfileState extends shoploginstate {}

class ShopSuccessState extends shoploginstate {}

class ShopErrorState extends shoploginstate {}

class ShopLoadingFavouirteState extends shoploginstate {}

class ShopSuccessFavouirteState extends shoploginstate {}

class ShopErrorFavouriteState extends shoploginstate {}

class ShopSuccessfFavouirteState extends shoploginstate {}
