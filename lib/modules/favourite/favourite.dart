import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/get_favourite_model.dart';

import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/state.dart';

class Favourite extends StatelessWidget {
  const Favourite({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ShopCubit.get(context).getfavouirtemodel?.data?.total != 0
              ? SafeArea(
                  child: ConditionalBuilder(
                    condition: ShopCubit.get(context).homemodeldata != null &&
                        ShopCubit.get(context).categorydata != null,
                    builder: (context) => Scaffold(
                        body: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) => buildFavouirte(
                                ShopCubit.get(context)
                                    .getfavouirtemodel!
                                    .data!
                                    .data![index],
                                context),
                            separatorBuilder: (context, index) =>
                                const Divider(),
                            itemCount: ShopCubit.get(context)
                                .getfavouirtemodel!
                                .data!
                                .data!
                                .length)),
                    fallback: (context) =>
                        const Center(child: CircularProgressIndicator()),
                  ),
                )
              : SafeArea(
                  child: Scaffold(
                    body: Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 280,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Nothing to see here',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Icon(
                                Icons.shopping_cart_outlined,
                                size: 28,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
        });
  }

  Widget buildFavouirte(FavoritesData model, context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image(
                  image: NetworkImage("${model.product.image}"),
                  height: 150,
                  width: 150,
                ),
                if (model.product.discount != 0)
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.red),
                    width: 70,
                    height: 20,
                    child: Center(
                      child: Row(
                        children: const [
                          Text(
                            ' Discount',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 6, top: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: Text(
                        textAlign: TextAlign.start,
                        "${model.product.name}",
                        style: const TextStyle(fontSize: 20),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "${model.product.price!.round()} EGP",
                            style: const TextStyle(
                                fontSize: 18, color: Colors.green),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          if (model.product.oldPrice != model.product.price)
                            Text(
                              "${model.product.oldPrice!.round()} EGP",
                              style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              ShopCubit.get(context)
                                  .MyFavourites(model.product.id);
                            },
                            icon: Icon(Icons.favorite,
                                size: 40,
                                color: ShopCubit.get(context)
                                        .favourites[model.product.id]!
                                    ? Colors.red
                                    : Colors.grey.shade300)),
                        SizedBox(
                          width: 10,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
