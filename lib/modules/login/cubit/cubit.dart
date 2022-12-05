import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/login_models.dart';
import 'package:shop/modules/login/cubit/state.dart';
import 'package:shop/network/dio/dio.dart';
import 'package:shop/network/endpoints/endpoints.dart';

import '../../../models/GetUserData.dart';
import '../../../models/category_model.dart';
import '../../../models/favourite_model.dart';
import '../../../models/get_favourite_model.dart';
import '../../../models/home_model.dart';
import '../../../shared/constant/constant.dart';

class ShopLoginCubit extends Cubit<shoploginstate> {
  ShopLoginCubit() : super(shoplogininitialstate());

  static ShopLoginCubit get(context) => BlocProvider.of(context);
  ShopLoginModel? loginModel;

  void userlogin({required String email, required String password}) {
    emit(shoploginloadingstate());
    DioHelper.postdata(url: LOGIN, data: {
      'email': email,
      'password': password,
    }).then((value) {
      loginModel = ShopLoginModel.fromJson(value.data);
      emit(shoploginsuccesstate(loginModel!));
    }).catchError((error) {
      emit(shoploginerrorstate(error.toString()));
    });
  }

  bool passvisible = true;
  IconData? suffixx = Icons.visibility_off;

  passwordvis() {
    passvisible = !passvisible;
    suffixx = passvisible ? Icons.visibility_off : Icons.visibility;

    emit(passstate());
  }

  GetFavoritesModel? getfavouirtemodel;

  GetFavourite() {
    DioHelper.getdata(url: FAVOURITS, token: token).then((value) {
      emit(ShopLoadingFavouirteState());

      getfavouirtemodel = GetFavoritesModel.fromJson(value.data);
      emit(ShopSuccessGetFavState());
    }).catchError((error) {
      emit(ShopErrorGetFavState());
    });
  }

  ///////////////////////////////////////////
  GetUserData? getuserdata;

  GetData() {
    DioHelper.getdata(url: PROFILE, token: token).then((value) {
      emit(ShopLoadingGetProfileState());

      getuserdata = GetUserData.fromJson(value.data);
      emit(ShopSuccessGetProfileState());
    }).catchError((error) {
      emit(ShopErrorGetProfileState());
    });
  }

  //////////////////////////////////////////
  CategoriesModel? categorydata;

  GetCategory() {
    DioHelper.getdata(url: CATEGORY, token: token).then((value) {
      categorydata = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoryState());
    }).catchError((error) {
      emit(ShopErrorCategoryState());
    });
  }

  /////////////////////////////////////////
  Map<num?, bool?> favourites = {};
  HomeModel? homemodeldata;

  getdatahome() {
    DioHelper.getdata(url: HOME, token: token).then((value) {
      homemodeldata = HomeModel.fromJson(value.data);
      homemodeldata?.data?.products?.forEach((element) {
        favourites.addAll({element.id!: element.inFavorites!});
      });
      emit(ShopSuccessState());
    }).catchError((error) {
      emit(ShopErrorState());
    });
  }

  ////////////////////////////////////////
  FavouriteModel? FavouriteModelData;

  MyFavourites(ProductsId, context) {
    ShopLoginCubit.get(context).favourites[ProductsId] =
        !ShopLoginCubit.get(context).favourites[ProductsId]!;

    emit(ShopSuccessfFavouirteState());

    DioHelper.postdata(
            url: FAVOURITS, data: {'product_id': ProductsId}, token: token)
        .then((value) {
      FavouriteModelData = FavouriteModel.fromJson(value.data);
      emit(ShopSuccessFavouirteState());
      ShopLoginCubit.get(context).GetFavourite();
    }).catchError((error) {
      emit(ShopErrorFavouriteState());
    });
  }
}
