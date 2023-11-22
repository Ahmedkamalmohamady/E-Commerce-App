import 'package:flutter_bloc/flutter_bloc.dart';

class MyBlocObserver extends BlocObserver{
@override void onCreate(BlocBase bloc) {
    // TODO: implement onCreate
    super.onCreate(bloc);
    print('created $bloc');
  }
  @override void onChange(BlocBase bloc, Change change) {
    // TODO: implement onChange
    super.onChange(bloc, change);
    print('changed $change');
  }
}