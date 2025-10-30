import 'package:flutter/cupertino.dart';

import '../models/user_model.dart';

final appBrain = AppBrain() ;
class AppBrain{

  ValueNotifier <List<UserModel>> users = ValueNotifier([]) ;
}