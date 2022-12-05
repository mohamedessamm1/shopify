// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:shop/modules/login/Login.dart';
import 'package:shop/shared/cache/cache.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  State<splash> createState() => _splashState();
}

class boarding {
  String? image;
  String? page;
  String? title;

  boarding({
    required this.image,
    required this.title,
    required this.page,
  });
}

class _splashState extends State<splash> {
  bool islast = false;
  var controlpage = PageController();
  List<boarding> listboarding = [
    boarding(
        image: 'assets/images/first.png',
        title: 'explore our offers',
        page: 'here you will find what you want'),
    boarding(
        image: 'assets/images/delivery.png',
        title: 'fast shipping',
        page: 'we deliver package to anywhere'),
    boarding(
        image: 'assets/images/payment.png',
        title: 'online payment',
        page: 'you can easily pay online'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                submit(context: context);
              },
              child: const Text('SKIP'))
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (index) {
                  if (index == listboarding.length - 1) {
                    islast = true;
                  } else {
                    islast = false;
                  }
                },
                controller: controlpage,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => itembuild(listboarding[index]),
                itemCount: listboarding.length,
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: controlpage,
                    count: 3,
                    effect: const ExpandingDotsEffect(
                      activeDotColor: Colors.deepPurple,
                      dotHeight: 10,
                      dotWidth: 19,
                      expansionFactor: 3,
                      spacing: 6,
                    ),
                    textDirection: TextDirection.ltr),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (islast) {
                      submit(context: context);
                    } else {
                      setState(() {
                        controlpage.nextPage(
                            duration: const Duration(milliseconds: 800),
                            curve: Curves.easeInOutCubicEmphasized);
                      });
                    }
                  },
                  child: const Icon(Icons.navigate_next),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget itembuild(boarding model) => SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 50,
          ),
          Image.asset('${model.image}'),
          const SizedBox(
            height: 130,
          ),
          Text(
            '${model.title}',
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          Text(
            '${model.page}',
            style: const TextStyle(fontSize: 27, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );

void submit({required context}) {
  CacheHelper.savedata(key: 'onboarding', value: true).then((value) {
    if (value) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => loginscreen()));
    }
  });
}
