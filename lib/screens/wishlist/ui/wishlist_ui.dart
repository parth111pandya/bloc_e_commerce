import 'package:e_commerce/screens/home/bloc/home_bloc.dart';
import 'package:e_commerce/screens/home/ui/product_tile.dart';
import 'package:e_commerce/screens/wishlist/bloc/wishlist_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistUi extends StatefulWidget {
  const WishlistUi({super.key});

  @override
  State<WishlistUi> createState() => _CartUiState();
}

class _CartUiState extends State<WishlistUi> {
  final WishlistBloc wishlistBloc = WishlistBloc();

  @override
  void initState() {
    wishlistBloc.add(WishlistInitialEvent());
    super.initState();
  }

  final HomeBloc homeBloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistBloc, WishlistState>(
      bloc: wishlistBloc,
      builder: (context, state) {
        if (state is WishListLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is WishListLoadedState) {
          var successState = state;
          return Column(
            children: [
              successState.wishlistLists.isNotEmpty
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
                        itemCount: successState.wishlistLists.length,
                        // shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ProductTile(
                            productItem: successState.wishlistLists[index],
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
          return Container();
        }
      },
    );
  }
}
