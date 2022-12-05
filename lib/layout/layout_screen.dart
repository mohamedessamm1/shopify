import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/modules/login/Login.dart';
import 'package:shop/modules/search/search.dart';
import 'package:shop/shared/cache/cache.dart';
import 'package:shop/shared/cubit/cubit.dart';
import 'package:shop/shared/cubit/state.dart';

class home_layout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => search()));
                    },
                    icon: Icon(
                      Icons.search,
                      color: Colors.deepPurple,
                    ))
              ],
              title: Text(
                'Shopify',
                style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: cubit.screensnav[cubit.currentindex],
            bottomNavigationBar: BottomNavigationBar(
              iconSize: 32,
              currentIndex: cubit.currentindex,
              onTap: (index) {
                cubit.changebottomnav(index);
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.shopping_cart,
                    ),
                    label: 'home'),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.apps_rounded,
                    ),
                    label: 'categories'),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.favorite,
                    ),
                    label: 'favorite'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: 'settings'),
              ],
            ),
          );
        });
  }
}
