import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:counter/feature/cart/presentation/cart_screen.dart';
import 'package:counter/feature/home/data/model/product_model.dart';
import 'package:counter/feature/home/logic/home_cubit.dart';
import 'package:counter/feature/home/presentation/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/db/cache/cache_helper.dart';
import '../../../core/db/local_db/local_db_helper.dart';
import '../../auth/presentation/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      HomeCubit()
        ..getHomeData(),
      child: Scaffold(
        backgroundColor: Colors.white,

        body: SafeArea(
          child: BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              return RefreshIndicator(
                onRefresh: () {
                  return context.read<HomeCubit>().getHomeData();
                },
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ConditionalBuilder(
                          condition: context
                              .watch<HomeCubit>()
                              .userData != null,
                          builder: (BuildContext context) {
                            var user = context
                                .watch<HomeCubit>()
                                .userData;
                            return Row(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                      "https://t3.ftcdn.net/jpg/02/99/04/20/360_F_299042079_vGBD7wIlSeNl7vOevWHiL93G4koMM967.jpg"),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Hello",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Text(
                                      "${user!.name!.firstname!} ${user!.name!
                                          .lastname!}",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                IconButton(
                                  onPressed: ()  {
                                    Navigator.push(context,
                                      MaterialPageRoute(
                                          builder: (context) => CartScreen()),);
                                  },

                                  icon: Icon(Icons.shopping_cart, color: Colors.grey,),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    await CacheHelper.removeData(key: "token");
                                    Navigator.pushAndRemoveUntil(context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen()), (
                                          route) => false,);
                                  },

                                  icon: Icon(Icons.login, color: Colors.red,),
                                )
                              ],
                            );
                          },
                          fallback: (BuildContext context) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Products",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ConditionalBuilder(
                          condition:
                          context
                              .read<HomeCubit>()
                              .products
                              .isNotEmpty,
                          builder: (context) =>
                              buildLoaded(
                                  context
                                      .watch<HomeCubit>()
                                      .products, context),
                          fallback: (context) => buildLoading(),
                        ),
                      ],
                    ),
                  ),
                ),
              );
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

Widget buildLoaded(List<ProductModel> products, BuildContext contextC) {
  return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: products.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    BlocProvider.value(
                      value: BlocProvider.of<HomeCubit>(contextC)
                        ..getSingleProduct(products[index].id!),
                      child: ProductDetailsScreen(),
                    )));
          },
          leading: CircleAvatar(
            backgroundImage: NetworkImage(products[index].image!),
          ),
          title: Text(products[index].title!),
          subtitle: Text(
            products[index].description!,
            style: TextStyle(color: Colors.grey),
          ),
          trailing: IconButton(onPressed: () async {
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
          }, icon: Icon(Icons.add_shopping_cart)),
        );
      });
}

Widget buildError() {
  return Center(
    child: Text("Error"),
  );
}
