import 'dart:developer';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/screens/cart/ui/cart_ui.dart';
import 'package:e_commerce/screens/home/bloc/home_bloc.dart';
import 'package:e_commerce/screens/home/ui/product_tile.dart';
import 'package:e_commerce/screens/wishlist/ui/wishlist_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeUi extends StatefulWidget {
  const HomeUi({super.key});

  @override
  State<HomeUi> createState() => _HomeUiState();
}

class _HomeUiState extends State<HomeUi> {
  int activeIndex = 0;
  int productIndex = 0;

  @override
  void initState() {
    homeBloc.add(HomeInitinalEvent());
    super.initState();
  }

  final NotchBottomBarController _controller =
      NotchBottomBarController(index: 1);
  final _pageController = PageController(initialPage: 1);

  final HomeBloc homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is AppThemeChangeActionState) {
          AdaptiveTheme.of(context).mode.isLight
              ? AdaptiveTheme.of(context).setDark()
              : AdaptiveTheme.of(context).setLight();
        } else if (state is ProductCartActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Product Added to cart"),
            ),
          );
        } else if (state is ProductWishListActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Product Added to WishList")));
        } else if (state is BottomBarActionState) {
          _pageController.jumpToPage(state.pageIndex);
        }
      },
      builder: (context, state) {
        if (state is HomeLodingState) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state is HomeLoadedSuccessState) {
          final successState = state;
          return Scaffold(
              appBar: AppBar(
                title: const Text(
                  "E-Commerce",
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      homeBloc.add(AppThemeChangeEvent());
                    },
                    icon: Icon(
                      AdaptiveTheme.of(context).mode.isLight
                          ? Icons.dark_mode
                          : Icons.light_mode,
                      size: 25,
                    ),
                  ),
                ],
              ),
              body: PageView(
                controller: _pageController,
                children: [
                  WishlistUi(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 60,
                        child: ListView.builder(
                          itemCount: successState.categoriesList.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  activeIndex = index;
                                });
                              },
                              overlayColor:
                                  WidgetStateProperty.all(Colors.transparent),
                              child: Chip(
                                label: Text(
                                  "${successState.categoriesList[index]}",
                                  style: TextStyle(
                                    color: activeIndex != index
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ),
                                elevation: 5,
                                backgroundColor: activeIndex == index
                                    ? Colors.black
                                    : Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                    side: BorderSide(
                                      color: activeIndex == index
                                          ? Colors.black
                                          : Colors.white,
                                    )),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: .8,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                          ),
                          itemCount: successState.homePoductList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ProductTile(
                              productItem: successState.homePoductList[index],
                              homeBloc: homeBloc,
                            );
                          },
                        ),
                      )
                    ],
                  ),
                  CartUi(),
                ],
              ),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: AnimatedNotchBottomBar(
                  /// Provide NotchBottomBarController
                  notchBottomBarController: _controller,
                  color: Colors.white,
                  showLabel: true,
                  textOverflow: TextOverflow.visible,
                  maxLine: 1,
                  shadowElevation: 5,
                  kBottomRadius: 28.0,
                  notchColor: Colors.black87,

                  /// restart app if you change removeMargins
                  removeMargins: false,
                  showShadow: false,
                  durationInMilliSeconds: 300,
                  itemLabelStyle: const TextStyle(fontSize: 10),
                  elevation: 1,
                  bottomBarItems: const [
                    BottomBarItem(
                      inActiveItem: Icon(
                        Icons.favorite,
                        color: Colors.blueGrey,
                      ),
                      activeItem: Icon(
                        Icons.favorite,
                        color: Colors.blueAccent,
                      ),
                      itemLabel: 'Wishlist',
                    ),
                    BottomBarItem(
                      inActiveItem: Icon(
                        Icons.home,
                        color: Colors.blueGrey,
                      ),
                      activeItem: Icon(
                        Icons.home,
                        color: Colors.blueAccent,
                      ),
                      itemLabel: 'Home',
                    ),
                    BottomBarItem(
                      inActiveItem: Icon(
                        Icons.shopping_cart,
                        color: Colors.blueGrey,
                      ),
                      activeItem: Icon(
                        Icons.shopping_cart,
                        color: Colors.pink,
                      ),
                      itemLabel: 'Cart',
                    ),
                  ],
                  onTap: (index) {
                    homeBloc.add(BottomButtonClickedEvent(
                      pageIndex: index,
                    ));
                  },
                  kIconSize: 18,
                ),
              ));
        } else if (state is HomeErrorState) {
          return const Scaffold(
            body: Center(
              child: Text("Error"),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: Text("Default"),
            ),
          );
        }
      },
    );
  }
}
