import 'package:e_commerce/screens/cart/bloc/cart_bloc.dart';
import 'package:e_commerce/screens/home/bloc/home_bloc.dart';
import 'package:e_commerce/screens/home/ui/product_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartUi extends StatefulWidget {
  const CartUi({super.key});

  @override
  State<CartUi> createState() => _CartUiState();
}

class _CartUiState extends State<CartUi> {
  final CartBloc cartBloc = CartBloc();
  final HomeBloc homeBloc = HomeBloc();
  @override
  void initState() {
    cartBloc.add(CartIntialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(
      bloc: cartBloc,
      listenWhen: (previous, current) => current is CartActionState,
      buildWhen: (previous, current) => current is! CartActionState,
      listener: (context, state) {},
      builder: (context, state) {
        print(state.runtimeType);
        if (state is CartLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is CartLoadedState) {
          var successState = state;
          return Column(
            children: [
              successState.cartList.isNotEmpty
                  ? Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: .8,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                        ),
                        scrollDirection: Axis.vertical,
                        itemCount: successState.cartList.length,
                        // shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ProductTile(
                            productItem: successState.cartList[index],
                            homeBloc: homeBloc,
                          );
                        },
                      ),
                    )
                  : Expanded(
                      child: Container(
                        child: Center(child: Text("No Item Found.")),
                      ),
                    ),
            ],
          );
        } else {
          return Container(
            child: Text("No Item Found."),
          );
        }
      },
    );
  }
}
