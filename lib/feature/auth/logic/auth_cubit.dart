import 'package:counter/core/network/dio_helper.dart';
import 'package:counter/core/network/endpoints.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void login(String userName, String password) {
    emit(AuthLoginLoading());
    Map<String, String> data = {'username': "mor_2314", 'password': "83r5^_"};
    DioHelper.postData(url: Endpoints.loginEndPoint, data: data)
        .then((value) {
          if (value.statusCode == 200) {
            emit(AuthLoginSuccess());
          } else{
            emit(AuthLoginFailure("Login failed , please try again"));
          }

    }).onError((error, stackTrace) {
      emit(AuthLoginFailure("Login failed , please try again"));

    });
  }
}
