import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:counter/feature/cart/logic/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit()..getCartData(),
      child: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text('Cart'),
            ),
            body: ConditionalBuilder(
                condition: context.read<CartCubit>().products.isNotEmpty,
                builder: (context) {
                  return    ListView.builder(
                    shrinkWrap: true,
                    itemCount: context.watch<CartCubit>().products.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(context
                            .watch<CartCubit>()
                            .products[index]
                            .title!),
                        subtitle: Text(context
                            .watch<CartCubit>()
                            .products[index]
                            .price
                            .toString()),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            context
                                .read<CartCubit>()
                                .deleteProduct(context
                                .read<CartCubit>()
                                .products[index]
                                .id! , index);
                          },
                        ),
                      );
                    },
                  );
                },
                fallback: (context) {
                  return
                    Center(
                    child: Text("No Products in Cart"),
                  );
                }),
            bottomNavigationBar: Container(
              height: 100,
              color: Colors.blue,
              child: Center(
                child: Text(
                  'Total Price: ${context.watch<CartCubit>().totalPrice}',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
