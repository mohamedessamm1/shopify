import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/search_model.dart';
import 'package:shop/modules/settings/settings.dart';
import 'package:shop/shared/cubit/cubit.dart';
import 'package:shop/shared/cubit/state.dart';
import 'package:shop/shared/componant/componant.dart';

class search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var searchcontrol = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: InkWell(
            child: Icon(Icons.arrow_back_ios, color: Colors.deepPurple),
            onTap: () {
              Navigator.pop(
                  context, MaterialPageRoute(builder: (context) => settings()));
            }),
        centerTitle: true,
        title: Text('Search New Products',
            style: TextStyle(color: Colors.deepPurple)),
      ),
      body: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  defaultFormField(
                      bordercircular: 16,
                      onSubmit: (value) {
                        ShopCubit.get(context)
                            .Search(searchDATA: searchcontrol.text);
                      },
                      controller: searchcontrol,
                      type: TextInputType.text,
                      label: 'search',
                      prefix: Icons.search),
                  Expanded(
                    child: ConditionalBuilder(
                      condition: state is! ShopLoadingSearchState,
                      builder: (context) =>
                          ShopCubit.get(context).searchModel?.data.data == null
                              ? Text('')
                              : ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) =>
                                      buildSearchItem(
                                          ShopCubit.get(context)
                                              .searchModel
                                              ?.data
                                              .data[index],
                                          context),
                                  separatorBuilder: (context, index) =>
                                      const Divider(),
                                  itemCount: ShopCubit.get(context)
                                      .searchModel
                                      ?.data
                                      .total),
                      fallback: (context) =>
                          Center(child: CircularProgressIndicator()),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildSearchItem(Product? model, context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image(
                  image: NetworkImage("${model?.image}"),
                  height: 120,
                  width: 120,
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
                        "${model?.name}",
                        style: const TextStyle(fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "${model?.price} EGP",
                            style: const TextStyle(
                                fontSize: 12, color: Colors.green),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
// ListView.separated(
// physics: const BouncingScrollPhysics(),
// itemBuilder: (context, index) => buildSearchItem(
// ShopCubit.get(context).searchModel?.data.data[index],
// context),
// separatorBuilder: (context, index) => const Divider(),
// itemCount: ShopCubit.get(context)
// .getfavouirtemodel!
// .data!
// .data!
// .length),
