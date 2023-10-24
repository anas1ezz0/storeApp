
import 'package:flutter/material.dart';
import 'package:shop_app/CashHelper/cash_helper.dart';
import 'package:shop_app/compo/compo.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'login_screen.dart';
class OnBoardingModel{
  final  String image ;
  final  String title ;
  final  String body ;

  OnBoardingModel({required this.image, required this.title, required this.body});
}
class OnBoarding extends StatefulWidget {
   const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
var boardingCtlr = PageController();
List<OnBoardingModel>   boarding = [
  OnBoardingModel(
    image: 'assets/onboard_1.jpg',
    title: 'On Board 1 Title',
    body: 'On Board 1 Body',
  ),
  OnBoardingModel(
    image: 'assets/onboard_1.jpg',
    title: 'On Board 2 Title',
    body: 'On Board 2 Body',
  ),
  OnBoardingModel(
    image: 'assets/onboard_1.jpg',
    title: 'On Board 3 Title',
    body: 'On Board 3 Body',
  ),
];
bool isLast = false;
void submit(){
  CacheHelper.saveData(key: 'onBoarding', value: true).then((value)
  {
    if(value){
      navigateTo(context, ShopLoginScreen());
    }
  });

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: (){
            submit();
          }, child: const Text("SKIP",style: TextStyle(color: Colors.teal),))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index){
                  if(index ==boarding.length -1){
isLast = true;
                  }else{
                    isLast = false;
                  }
                },
                  itemBuilder: (context, index) => buildBoarding(boarding[index]),
                itemCount: boarding.length,
                controller: boardingCtlr,
                physics: const BouncingScrollPhysics(),

              ),
            ),

            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardingCtlr,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Colors.teal,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5.0,
                  ),
                  count: boarding.length,
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: (){
                    if(isLast){
                      navigateTo(context, ShopLoginScreen());
                    }else {
                      boardingCtlr.nextPage(duration: const Duration(milliseconds: 750), curve: Curves.fastLinearToSlowEaseIn,);
                    }
                },child: const Icon(Icons.arrow_forward_ios,color: Colors.white,),)
              ],
            )
          ],
        ),
      ),
    );

  }

   Widget buildBoarding(OnBoardingModel model) => Column(
     crossAxisAlignment: CrossAxisAlignment.start,
     children: [
       Expanded(child: Image.asset(model.image)),
      // const SizedBox(height: 30,),
      Text(model.title ,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
       const SizedBox(height: 15,),
       Text(model.body,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600,) ),
       const SizedBox(height: 30,)
     ],
   );
}
