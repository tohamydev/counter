import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:counter/core/db/local_db/local_db_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/home_cubit.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text("Product Details"),
          ),
          body: ConditionalBuilder(
            condition: context.read<HomeCubit>().product != null,
            builder: (BuildContext context) {
              return Padding(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 300,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                              context.read<HomeCubit>().product!.image!)),
                    ),
                    SizedBox(height: 10),
                    Text(
                      context.read<HomeCubit>().product!.title!,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      context.read<HomeCubit>().product!.description!,
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(height: 10),
                    Text(
                      context.read<HomeCubit>().product!.price.toString(),
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              );
            },
            fallback: (BuildContext context) {
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              try {
                var data = context.read<HomeCubit>().product;
                await SQLHelper.add(
                    data!.id.toString(),
                    data.title!,
                    data.description ?? "",
                    data.image!,
                    1,
                    data.price!.toDouble());
              } catch (e) {
                print(e);
              }
            },
            child: Icon(Icons.add_shopping_cart_sharp),
          ),
        );
      },
    );
  }
}
