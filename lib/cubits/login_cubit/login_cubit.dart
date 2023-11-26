
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/cache_helper/shared_preferences.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/models/user_model.dart';
import 'package:shop_app/services/user_services.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  late LoginModel loginModel;
  bool isLoading =false;
  static LoginCubit get(context)=>BlocProvider.of(context);
  Future<void> loginUser({required String email, required String password})
  async{
    emit(LoginLoading());
     isLoading =true ;
      var data =await UserServices().login(email: email, password: password);
     loginModel=LoginModel.fromJson(data.data);

      isLoading=false;
      if(loginModel.status ==false)
      {
        emit(LoginFailed(loginModel: loginModel));
      }
      else{
        emit(LoginSuccess(loginModel: loginModel));

      }



  }
}
