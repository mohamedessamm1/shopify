import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:shop/layout/layout_screen.dart';
import 'package:shop/modules/register/cubit/cubit.dart';
import 'package:shop/modules/register/cubit/states.dart';
import 'package:shop/shared/cache/cache.dart';
import 'package:shop/shared/componant/componant.dart';
import 'package:shop/shared/constant/constant.dart';

class RegisterScreen extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  var emailcontrol = TextEditingController();
  var passwordcontrol = TextEditingController();
  var namecontorl = TextEditingController();
  var phonecontrol = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ShopRegisterCubit(),
        child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
          listener: (context, state) {
            if (state is ShopRegisterSuccesState) {
              if (state.Registermodel.status!) {
                showtoast(
                    text: state.Registermodel.message,
                    state: ShowToastState.SUCCESS);
                CacheHelper.savedata(
                        key: 'token', value: state.Registermodel.data!.token)
                    .then((value) {
                  token = state.Registermodel.data!.token;
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => home_layout()));
                  Phoenix.rebirth(context);
                });
              } else {
                showtoast(
                    text: state.Registermodel.message,
                    state: ShowToastState.ERROR);
              }
            }
          },
          builder: (context, state) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
              ),
              body: SingleChildScrollView(
                child: Form(
                  key: formkey,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 90,
                      right: 30,
                      left: 30,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text(
                                'REGISTER',
                                style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                'register Now to Get New Offers',
                                style:
                                    TextStyle(fontSize: 20, color: Colors.grey),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // NAME FIELD///////////////////////////////////////////////////
                          defaultFormField(
                            bordercircular: 20,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'enter your name';
                              }
                              return null;
                            },
                            controller: namecontorl,
                            type: TextInputType.name,
                            label: 'enter your name',
                            prefix: Icons.drive_file_rename_outline,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          //EMAIL FIELD////////////////////////////////////////////////////
                          defaultFormField(
                              bordercircular: 20,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'enter your email';
                                }
                                return null;
                              },
                              controller: emailcontrol,
                              type: TextInputType.emailAddress,
                              label: 'enter your email',
                              prefix: Icons.alternate_email),
                          const SizedBox(
                            height: 20,
                          ),
                          //PASSWORD FIELD//////////////////////////////////////////
                          defaultFormField(
                              bordercircular: 20,
                              isPassword:
                                  ShopRegisterCubit.get(context).passvisible,
                              suffix: ShopRegisterCubit.get(context).suffixx,
                              suffixTab: () {
                                ShopRegisterCubit.get(context).passwordvis();
                              },
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'enter your password';
                                }
                                return null;
                              },
                              controller: passwordcontrol,
                              type: TextInputType.visiblePassword,
                              label: 'enter your password',
                              prefix: Icons.password_sharp),
                          const SizedBox(
                            height: 29,
                          ),
                          // PHONE FIELD//////////////////////////////////////////////
                          defaultFormField(
                              bordercircular: 20,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'enter your phone';
                                }
                                return null;
                              },
                              controller: phonecontrol,
                              type: TextInputType.phone,
                              label: 'enter your phone',
                              prefix: Icons.phone),
                          const SizedBox(
                            height: 20,
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                          const SizedBox(
                            height: 20,
                          ),
                          ConditionalBuilder(
                              condition: state is! ShopRegisterLoadingState,
                              builder: (context) => defaultButton(
                                  bordercircular: 18,
                                  height: 50,
                                  function: () {
                                    if (formkey.currentState!.validate()) {
                                      ShopRegisterCubit.get(context)
                                          .userRegister(
                                        email: emailcontrol.text,
                                        password: passwordcontrol.text,
                                        name: namecontorl.text.toLowerCase(),
                                        phone: phonecontrol.text,
                                      );
                                    }
                                  },
                                  text: 'Register '),
                              fallback: (context) => const Center(
                                  child: CircularProgressIndicator())),

                          // const Spacer()
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
