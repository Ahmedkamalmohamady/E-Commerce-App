import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class CacheHelper
{
 static SharedPreferences? sharedPreferences ;
 static init()
 async{
   sharedPreferences=await SharedPreferences.getInstance();

 }
static dynamic getData({required String key})
 async{
  await CacheHelper.init();
 return sharedPreferences!.get(key);
}
 static Future<bool> saveData({required String key, value})
async {
  CacheHelper.init();
  if (value is String) {
    return await sharedPreferences!.setString(key, value);
  } else if (value is double) {
    return await sharedPreferences!.setDouble(key, value);
  } else if (value is bool) {
    return await sharedPreferences!.setBool(key, value);

  } else {
    return await sharedPreferences!.setInt(key, value);
  }
}
static Future<bool> remove({required String key})
async{
  return await sharedPreferences!.remove(key);
}
}
void removeOnBoardingScreen()
async{
  await CacheHelper.saveData(key: kOnBoarding,value: false).
  then(
          (value)
      {
        print('success');
      }
  );
}