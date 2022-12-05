import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/register_model.dart';
import 'package:shop/modules/register/cubit/states.dart';
import 'package:shop/network/dio/dio.dart';
import 'package:shop/network/endpoints/endpoints.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop/shared/componant/componant.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);
  RegisterModel? RegistermodelData;

  userRegister(
      {required String name,
      required dynamic email,
      required dynamic password,
      required dynamic phone}) {
    emit(ShopRegisterLoadingState());
    DioHelper.postdata(url: REGISTER, data: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
    }).then((value) {
      RegistermodelData = RegisterModel.fromJson(value.data);
      emit(ShopRegisterSuccesState(RegistermodelData!));
    }).catchError((error) {
      emit(ShopRegisterErrorState(error));
    });
  }

  bool passvisible = true;
  IconData? suffixx = Icons.visibility_off;

  passwordvis() {
    passvisible = !passvisible;
    suffixx = passvisible ? Icons.visibility_off : Icons.visibility;
    emit(ShopPassState());
  }
}
