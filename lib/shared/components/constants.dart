import 'package:shopapp/modules/shop_app/login/login_screen.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/network/local/cache_helper.dart';

void signOut(context)
{
  CacheHelper.removeData(key: 'token').then((value) {
    if(value)
    {
      navigateAndFinishSS(context, ShopAppLoginScreen());
    }
  });

}

String? token = '';

void printFullText(String text)
{
  final pattern = RegExp('.{1,800}');  // 800 is size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}
