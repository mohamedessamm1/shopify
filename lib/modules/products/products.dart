import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/category_model.dart';
import 'package:shop/models/home_model.dart';
import 'package:shop/shared/componant/componant.dart';
import 'package:shop/shared/cubit/cubit.dart';
import 'package:shop/shared/cubit/state.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

class products extends StatelessWidget {
  const products({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: ConditionalBuilder(
                condition: ShopCubit.get(context).homemodeldata != null &&
                    ShopCubit.get(context).categorydata != null,
                builder: (context) => BUILDER(
                    ShopCubit.get(context).homemodeldata,
                    ShopCubit.get(context).categorydata,
                    context),
                fallback: (context) =>
                    const Center(child: CircularProgressIndicator())),
          ),
        );
      },
    );
  }

  // MAIN SCREEN BUILDER///////////////////////////////////////////////////////////
  Widget BUILDER(HomeModel? model, CategoriesModel? catmodel, context) =>
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
                items: model?.data?.banners
                    ?.map(
                      (e) => Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(25)),
                            image: DecorationImage(
                              image: NetworkImage('${e.image}'),
                              fit: BoxFit.cover,
                            )),
                      ),
                    )
                    .toList(),
                options: CarouselOptions(
                    autoPlay: true,
                    initialPage: 0,
                    reverse: false,
                    height: 220,
                    autoPlayAnimationDuration: const Duration(seconds: 3),
                    enableInfiniteScroll: true,
                    scrollDirection: Axis.horizontal,
                    autoPlayInterval: const Duration(seconds: 3),
                    viewportFraction: 1,
                    autoPlayCurve: Curves.fastOutSlowIn)),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Categorys',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) =>
                            BuildCategory(catmodel!.data!.data[index]),
                        separatorBuilder: (context, index) => const SizedBox(
                              width: 10,
                            ),
                        itemCount: catmodel!.data!.data.length),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'New Products',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.grey.shade300,
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
                childAspectRatio: 1 / 1.50,
                children: List.generate(
                    model!.data!.products!.length,
                    (index) =>
                        BuildrGidItem(model.data!.products![index], context)),
              ),
            ),
          ],
        ),
      );

  // CATEGORY BUILDER//////////////////////////////////////////////////////////////
  Widget BuildCategory(DataModel model) => Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image(
            image: NetworkImage(
                '${model.image == null ? 'https://sophiabikaner.org/assets/images/News_1.jpg' : model.image}'),
            fit: BoxFit.cover,
            width: 100,
            height: 100,
          ),
          Container(
            height: 25,
            width: 100,
            color: Colors.black.withOpacity(0.7),
            child: Text('${model.name}',
                style: const TextStyle(color: Colors.white, fontSize: 20),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
          )
        ],
      );

  //GRID BUILDER//////////////////////////////////////////////////////////////////الجريدايه
  Widget BuildrGidItem(Products model, context) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            InkWell(
              onTap: () {
                showAnimatedDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return ClassicGeneralDialogWidget(
                      positiveText: 'Add',
                      titleText: 'Add to your cart',
                      contentText: '${model.name}',
                      negativeText: 'Cancel',
                      onPositiveClick: () {
                        Navigator.of(context).pop();
                        showtoast(
                            text: 'this item added successfully',
                            state: ShowToastState.SUCCESS);
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
              child: Column(
                children: [
                  Center(
                      child: Stack(
                    children: [
                      Image(
                        image: NetworkImage(
                            "${model.image == null ? 'https://sophiabikaner.org/assets/images/News_1.jpg' : model.image}"),
                        height: 270,
                        width: double.infinity,
                      ),
                      if (model.discount != 0)
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
                        )
                    ],
                  )),
                  Padding(
                    padding: const EdgeInsets.only(left: 6),
                    child: Text(
                      "${model.name}",
                      style: const TextStyle(fontSize: 20),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 6, top: 5),
              child: Row(
                children: [
                  Text(
                    "${model.price!.round()} EGP",
                    style: const TextStyle(fontSize: 15, color: Colors.green),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  if (model.oldPrice != model.price)
                    Text(
                      "${model.oldPrice!.round()} EGP",
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        ShopCubit.get(context).MyFavourites(model.id);
                        ShopCubit.get(context).GetFavourite();
                      },
                      icon: Icon(
                          size: 33,
                          Icons.favorite,
                          color: ShopCubit.get(context).favourites[model.id]!
                              ? Colors.red
                              : Colors.grey.shade300))
                ],
              ),
            ),
          ],
        ),
      );
}
