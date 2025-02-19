import 'package:counter/feature/home/data/model/product_model.dart';
import 'package:counter/feature/home/data/model/user_model.dart';
import 'package:counter/feature/home/logic/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getProducts(),
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              return state is HomeProductsLoading
                  ? buildLoading()
                  : state is HomeProductsLoaded &&
                          context.read<HomeCubit>().products.isNotEmpty
                      ? buildLoaded(context.read<HomeCubit>().products)
                      : buildError();
            },
          ),
        ),
      ),
    );
  }
}

Widget buildLoading() {
  return Center(
    child: CircularProgressIndicator(),
  );
}

Widget buildLoaded(List<ProductModel> products) {
  return ListView.builder(itemBuilder: (context, index) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(products[index].image!),
      ),
      title: Text(products[index].title!),
      subtitle: Text(products[index].description! , style: TextStyle(color: Colors.grey),),
    );
  });
}

Widget buildError() {
  return Center(
    child: Text("Error"),
  );
}
