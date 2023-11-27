
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/services/user_services.dart';
import 'package:shop_app/widgets/custom_widgets.dart';

import '../../constants.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());
  bool isLoading=false;
 late LoginModel updateResponse;
   LoginModel? userInfo;
 static UserCubit get(context)=>BlocProvider.of<UserCubit>(context);
  ///updateUserProfile Method

  void updateUserProfile({name, email, phone, password, image,context})
  async{
    emit(UpdateUserProfileLoading());
    isLoading=true;
    updateResponse=await UserServices().updateUserProfile(
        token: token,
        name: name,
        email: email,
        phone: phone,
        password: password,
        image: image,
    );
    print(token);
    if(updateResponse.status!)
    {
      isLoading=false;
      emit(UpdateUserProfileSuccess());
      print(updateResponse.data);
    }
    else{
      isLoading=false;
      emit(UpdateUserProfileFailed(errorMessage: updateResponse.message!));

    }
    ShowToastMessage(msg: updateResponse.message!);
    Navigator.pop(context);
  }
  ///getUserProfile Method

  Future<void> getUserProfile()async{
userInfo=await UserServices().getUserProfile(token: token);
if(userInfo!.status!)
  {
    print(userInfo!.data!.name!);
    print(userInfo!.data!.phone!);
    print(userInfo!.data!.email!);
    emit(GetUserDataSuccessfully());
  }
  }
  void registerUser({name, email, phone, password})
  async{
    isLoading=true;
    emit(RegisterUserLoading());
 var registerResponse=await UserServices().registerUser(name: name, email: email, password: password,phone: phone);
  if(registerResponse.status!)
  {
    isLoading=false;
    emit(RegisterUserSuccess(message: registerResponse.message!));
  }
  else{
    isLoading=false;
    emit(RegisterUserFailed(errorMessage: registerResponse.message!));
  }

  }

}
