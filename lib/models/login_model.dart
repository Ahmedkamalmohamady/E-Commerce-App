import 'package:shop_app/models/user_model.dart';

class LoginModel{

  bool? status;
  String? message;
  UserModel? data;

  LoginModel({this.status, this.message, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
  status = json['status'];
  message = json['message'];
  data = json['data']!=null?UserModel.fromJson(json['data']):null;
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['status'] = status;
  data['message'] = message;
  data['data'] = UserModel().toJson();
  return data;
  }


  }




