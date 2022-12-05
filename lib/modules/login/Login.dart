import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:shop/layout/layout_screen.dart';
import 'package:shop/modules/login/cubit/cubit.dart';
import 'package:shop/modules/login/cubit/state.dart';
import 'package:shop/modules/register/register.dart';
import 'package:shop/shared/cache/cache.dart';
import 'package:shop/shared/componant/componant.dart';
import 'package:shop/shared/constant/constant.dart';
import 'package:shop/shared/cubit/cubit.dart';

class loginscreen extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  var emailcontrol = TextEditingController();
  var passwordcontrol = TextEditingController();

  loginscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ShopLoginCubit(),
        child: BlocConsumer<ShopLoginCubit, shoploginstate>(
          listener: (context, state) {
            if (state is shoploginsuccesstate) {
              if (state.loginModel.status!) {
                showtoast(
                    text: state.loginModel.message,
                    state: ShowToastState.SUCCESS);
                token = state.loginModel.data!.token;
                CacheHelper.savedata(
                        key: 'token', value: state.loginModel.data!.token)
                    .then((value) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => home_layout()));
                  Phoenix.rebirth(context);
                });
              } else {
                showtoast(
                    text: state.loginModel.message,
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
                                'LOGIN',
                                style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Login now and explore our hot offer',
                                style:
                                    TextStyle(fontSize: 20, color: Colors.grey),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
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
                          defaultFormField(
                              bordercircular: 20,
                              isPassword:
                                  ShopLoginCubit.get(context).passvisible,
                              onSubmit: (value) {
                                if (formkey.currentState!.validate()) {
                                  ShopLoginCubit.get(context).userlogin(
                                      email: emailcontrol.text,
                                      password: passwordcontrol.text);
                                }
                                return null;
                              },
                              suffix: ShopLoginCubit.get(context).suffixx,
                              suffixTab: () {
                                ShopLoginCubit.get(context).passwordvis();
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
                          ConditionalBuilder(
                              condition: state is! shoploginloadingstate,
                              builder: (context) => defaultButton(
                                  height: 50,
                                  bordercircular: 18,
                                  function: () {
                                    if (formkey.currentState!.validate()) {
                                      ShopLoginCubit.get(context).userlogin(
                                          email: emailcontrol.text,
                                          password: passwordcontrol.text);
                                    }
                                  },
                                  text: 'LOGIN '),
                              fallback: (context) => const Center(
                                  child: CircularProgressIndicator())),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('don\'t have an account'),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RegisterScreen()));
                                  },
                                  child: const Text(
                                    'Register now',
                                    style: TextStyle(fontSize: 17),
                                  ))
                            ],
                          ),
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
