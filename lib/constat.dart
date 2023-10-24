import 'package:shop_app/CashHelper/cash_helper.dart';
import 'package:shop_app/compo/compo.dart';
import 'package:shop_app/screens/login_screen.dart';

String token = 'DPpDU0IvRiPKjASJNuWOVyjYuf1rORWJ2PhbBZ28Amj0bk2i2zqiKhTxGwxLKixmRSnFsr';
void signOut(context)
{
  CacheHelper.removeData(
    key: 'token',
  ).then((value)
  {
    if (value)
    {
      navigateAndFinsh(
        context,
        ShopLoginScreen(),
      );
    }
  });
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

// String token = '';