import 'package:shop/models/register_model.dart';

abstract class ShopRegisterStates {}

class ShopRegisterInitialState extends ShopRegisterStates {}

class ShopRegisterSuccesState extends ShopRegisterStates {
  final RegisterModel Registermodel;

  ShopRegisterSuccesState(this.Registermodel);
}

class ShopRegisterLoadingState extends ShopRegisterStates {}

class ShopRegisterErrorState extends ShopRegisterStates {
  final String error;

  ShopRegisterErrorState(this.error);
}

class ShopPassState extends ShopRegisterStates {}
