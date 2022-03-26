// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:shopapp/modules/login/LoginScreen.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/network/local/sharedpreferences/sharedpreferences.dart';
import 'package:shopapp/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String title;
  final String image;

  BoardingModel({@required this.title, @required this.image});
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var BoardingCotroller = PageController();

  List<BoardingModel> BoardingList = [
    BoardingModel(
      title:
          'تأكـد مـن اتباعـك أنـت والمحيطيـن بـك ممارسـات النظافـة الجيـدة و تنفـس هـواء النقـي',
      image: 'assets/images/3776133.jpg',
    ),
    BoardingModel(
      title:
          'تتمثــل أعــراض الاكثـر شــيوعًا لمــرض كوفيــد-19 فــي الحمــى والســـــــــعال الجـاف وضيـق فـي التنفـس ',
      image: 'assets/images/3859310.jpg',
    ),
    BoardingModel(
        title:
            'اســتخدام الكمامــات الواقيــة اثنــاء الجلــوس مـع اكثـر مـن اثنيـن او عنـد الخـروج مـن المنـزل',
        image: 'assets/images/4058271.jpg'),
  ];
  bool isLast = false;

  void submit(){

    CacheHelper.saveData(
      key: 'boarding',
      value: true,
    ).then((value){
      if(value){
        NavigateAndRemove(
            context,
            LoginScreen()
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              submit();
            },
            child: const Text('skip'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: BoardingCotroller,
                onPageChanged: (int index) {
                  if (index == BoardingList.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) =>
                    ItemBuilder(BoardingList[index]),
                itemCount: BoardingList.length,
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: BoardingCotroller,
                  count: BoardingList.length,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: blue,
                    expansionFactor: 4,
                    spacing: 6,
                    dotWidth: 10,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast == true) {
                      submit();
                    } else {
                      BoardingCotroller.nextPage(
                        duration: const Duration(milliseconds: 750),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: const Icon(Icons.arrow_forward_outlined),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget ItemBuilder(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(
            image: AssetImage(model.image),
            height: 450,
          ),
          const SizedBox(
            height: 20.0,
          ),
          Text(
            model.title,
            textDirection: TextDirection.rtl,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          const SizedBox(
            height: 20.0,
          ),
        ],
      );


}
