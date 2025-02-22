import 'package:counter/core/network/dio_helper.dart';
import 'package:counter/core/network/endpoints.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../data/model/product_model.dart';
import '../data/model/user_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  UserModel? userData;

  List<ProductModel> products = [];

  ProductModel ? product ;

  void getUserData() {
    emit(HomeUserLoading());
    DioHelper.getData(url: Endpoints.currentUserDataEndpoint).then((value) {
      if (value.statusCode == 200 && value.data != null) {
        userData = UserModel.fromJson(value.data);
        print(userData!.name);
        emit(HomeUserLoaded());
      } else {
        emit(HomeUserError("Error"));
      }
    }).catchError((error) {
      emit(HomeUserError(error.toString()));
    });
  }

  void getProducts() {
    DioHelper.getData(url: Endpoints.productsEndpoint).then((value) {
      if (value.statusCode == 200 && value.data != null) {
        products =
            (value.data as List).map((e) => ProductModel.fromJson(e)).toList();

        print(products.length);
        emit(HomeProductsLoaded());
      } else {
        emit(HomeProductsError("Error"));

      }
    }).catchError((error) {
      print(error.toString());
      emit(HomeProductsError(error.toString()));
    });
  }

  Future<void> getHomeData() async {

    userData = null;
    products = [];

    emit(HomeUserLoading());
   await DioHelper.getData(url: Endpoints.currentUserDataEndpoint).then((value) {
      if (value.statusCode == 200 && value.data != null) {
        userData = UserModel.fromJson(value.data);
        print(userData!.name);
        emit(HomeUserLoaded());
      } else {
        emit(HomeUserError("Error"));
      }
    }).catchError((error) {
      emit(HomeUserError(error.toString()));
    });
    await DioHelper.getData(url: Endpoints.productsEndpoint).then((value) {
      if (value.statusCode == 200 && value.data != null) {
        products =
            (value.data as List).map((e) => ProductModel.fromJson(e)).toList();

        print(products.length);
        emit(HomeProductsLoaded());
      } else {
        emit(HomeProductsError("Error"));

      }
    }).catchError((error) {
      print(error.toString());
      emit(HomeProductsError(error.toString()));
    });

  }

  void getSingleProduct(int id) {
    product = null;
    emit(ProductDetailsLoading());
    DioHelper.getData(url: "${Endpoints.productByIdEndpoint}$id").then((value) {
      if (value.statusCode == 200 && value.data != null) {
        product = ProductModel.fromJson(value.data);
        emit(ProductDetailsLoaded());
      } else {
        emit(ProductDetailsError("Error"));
      }
    }).catchError((error) {
      emit(ProductDetailsError(error.toString()));
    });

  }


}
