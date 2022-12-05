import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:shop/modules/login/Login.dart';
import 'package:shop/shared/cache/cache.dart';
import 'package:shop/shared/componant/componant.dart';
import 'package:shop/shared/cubit/cubit.dart';
import 'package:shop/shared/cubit/state.dart';

class settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var namecontrol = TextEditingController();
    var emailcontrol = TextEditingController();
    var phonecontrol = TextEditingController();
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Image.network(
                        'https://th.bing.com/th/id/OIP.07-sPb5I_DSJhbfDYMWaTAHaHa?pid=ImgDet&w=207&h=207&c=7&dpr=1%D9%AB25'),
                    SizedBox(
                      height: 30,
                    ),
                    defaultFormField(
                        isenable: false,
                        bordercircular: 20,
                        mycolor: Colors.black,
                        controller: namecontrol,
                        type: TextInputType.name,
                        label:
                            '${ShopCubit.get(context).getuserdata?.data?.name.toString()}',
                        prefix: Icons.drive_file_rename_outline),
                    SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                        isenable: false,
                        bordercircular: 20,
                        mycolor: Colors.black,
                        controller: emailcontrol,
                        type: TextInputType.name,
                        label:
                            '${ShopCubit.get(context).getuserdata?.data?.email.toString()}',
                        prefix: Icons.email_outlined),
                    SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                        isenable: false,
                        bordercircular: 20,
                        mycolor: Colors.black,
                        controller: phonecontrol,
                        type: TextInputType.name,
                        label:
                            '${ShopCubit.get(context).getuserdata?.data?.phone.toString()}',
                        prefix: Icons.phone),
                    SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                        isenable: false,
                        bordercircular: 20,
                        mycolor: Colors.black,
                        controller: emailcontrol,
                        type: TextInputType.name,
                        label:
                            '${ShopCubit.get(context).getuserdata?.data?.id.toString()}',
                        prefix: Icons.perm_identity),
                    SizedBox(
                      height: 40,
                    ),
                    MaterialButton(
                      minWidth: 450,
                      height: 60,
                      onPressed: () {
                        showAnimatedDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (BuildContext context) {
                            return ClassicGeneralDialogWidget(
                              positiveText: 'Log out',
                              titleText: 'Are you sure to log out',
                              negativeText: 'Cancel',
                              onPositiveClick: () {
                                Navigator.of(context).pop();
                                showtoast(
                                    text: 'log out successfully',
                                    state: ShowToastState.SUCCESS);
                                CacheHelper.removedata(key: 'token');
                                ShopCubit.get(context).currentindex = 0;
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            loginscreen())).then(
                                    (value) => {Phoenix.rebirth(context)});
                              },
                              onNegativeClick: () {
                                Navigator.of(context).pop();
                              },
                            );
                          },
                          animationType: DialogTransitionType.scale,
                          curve: Curves.fastOutSlowIn,
                          duration: Duration(seconds: 1),
                        );
                      },
                      child: Text(
                        'Log out',
                        style: TextStyle(
                          fontSize: 23,
                        ),
                      ),
                      color: Colors.deepPurple,
                      textColor: Colors.white,
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    SizedBox(
                      height: 15,
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
