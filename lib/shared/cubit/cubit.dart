import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/favourite_model.dart';
import 'package:shop/models/get_favourite_model.dart';
import 'package:shop/models/home_model.dart';
import 'package:shop/models/register_model.dart';
import 'package:shop/modules/categories/categories.dart';
import 'package:shop/modules/favourite/favourite.dart';
import 'package:shop/modules/products/products.dart';
import 'package:shop/modules/settings/settings.dart';
import 'package:shop/network/dio/dio.dart';
import 'package:shop/network/endpoints/endpoints.dart';
import 'package:shop/shared/constant/constant.dart';
import 'package:shop/shared/cubit/state.dart';
import '../../models/GetUserData.dart';
import '../../models/search_model.dart';
import '../../models/category_model.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

////////////////////////////////////////////////////////////////////////////////
  List<Widget> screensnav = [
    products(),
    categories(),
    const Favourite(),
    settings(),
  ];

////////////////////////////////////////////////////////////////////////////////
  int currentindex = 0;

  void changebottomnav(index) {
    currentindex = index;
    emit(ShopNavChangeBarState());
  }

  ///////////////////////////////////////////////////////////////////////////////
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

  ///////////////////////////////////////////////////////////////////////////////
  CategoriesModel? categorydata;

  GetCategory() {
    DioHelper.getdata(url: CATEGORY, token: token).then((value) {
      categorydata = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoryState());
    }).catchError((error) {
      emit(ShopErrorCategoryState());
    });
  }

  //////////////////////////////////////////////////////////////////////////////
  FavouriteModel? FavouriteModelData;

  MyFavourites(ProductsId) {
    favourites[ProductsId] = !favourites[ProductsId]!;

    emit(ShopSuccessfFavouirteState());

    DioHelper.postdata(
            url: FAVOURITS, data: {'product_id': ProductsId}, token: token)
        .then((value) {
      FavouriteModelData = FavouriteModel.fromJson(value.data);
      emit(ShopSuccessFavouirteState());
      GetFavourite();
    }).catchError((error) {
      emit(ShopErrorFavouriteState());
    });
  }

  //////////////////////////////////////////////////////////////////////////////
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

  ////////////////////////////////////////////////////////////////////////////
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

  ///////////////////////////////////////////////////////////////////////////
  SearchModel? searchModel;

  Search({required searchDATA}) {
    emit(ShopLoadingSearchState());
    DioHelper.postdata(url: SEARCH, data: {'text': searchDATA}, token: token)
        .then((value) {
      searchModel = SearchModel.fromJson(value.data);
      print(searchModel?.data.data[9].name.toString());
      emit(ShopSuccessSearchState());
    }).catchError((error) {
      emit(ShopErrorSearchState());
    });
  }
}
