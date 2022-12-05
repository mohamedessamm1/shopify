import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/shared/cubit/cubit.dart';
import 'package:shop/shared/cubit/state.dart';
import '../../models/category_model.dart';

class categories extends StatelessWidget {
  const categories({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
          body: ListView.separated(
              itemBuilder: (context, index) => BuildCategory(
                  ShopCubit.get(context).categorydata!.data!.data[index]),
              separatorBuilder: (context, index) => const Divider(),
              itemCount:
                  ShopCubit.get(context).categorydata!.data!.data.length)),
    );
  }

  Widget BuildCategory(DataModel model) => Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Image(
                  alignment: Alignment.center,
                  image: NetworkImage('${model.image}'),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 230,
                ),
                Container(
                  height: 40,
                  width: double.infinity,
                  color: Colors.black.withOpacity(0.6),
                  child: Text('${model.name}',
                      style: const TextStyle(color: Colors.white, fontSize: 24),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                )
              ],
            )
          ],
        ),
      );
}
