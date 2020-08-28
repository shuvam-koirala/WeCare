import 'package:WeCare/view/authentication/phoneauthUI/continue_with_phone.dart';

import 'package:WeCare/view/preparedness/Screens/Newsfeed.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<String>(context);
    print(user);

    if (user == null) {
      return ContinueWithPhone();
    } else {
      return NewsFeed();
    }
  }
}
