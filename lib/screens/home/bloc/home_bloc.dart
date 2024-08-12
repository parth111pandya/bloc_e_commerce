import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:e_commerce/screens/home/models/home_product_model.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import '../../../data/product_data.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitinalEvent>(homeInitinalEvent);
    on<AppThemeChangeEvent>(appThemeChangeEvent);
    on<ProductiCartButtonClickedEvent>(productiCartButtonClickedEvent);
    on<ProductiWishListButtonClickedEvent>(productiWishListButtonClickedEvent);
    on<BottomButtonClickedEvent>(bottomButtonClickedEvent);
  }

  FutureOr<void> homeInitinalEvent(
      HomeInitinalEvent event, Emitter<HomeState> emit) async {
    emit(HomeLodingState());
    await Future.delayed(const Duration(seconds: 3));
    emit(
      HomeLoadedSuccessState(
        homePoductList: ProductData.productList
            .map(
              (e) => HomeProductModel(
                id: e['id'],
                category: e['category'],
                description: e['description'],
                image: e['image'],
                price: e['price'],
                title: e['title'],
                rating: Rating(
                  count: e['rating']['count'],
                  rate: e['rating']['rate'],
                ),
              ),
            )
            .toList(),
        categoriesList: ProductData.categoriesList,
      ),
    );
  }

  FutureOr<void> appThemeChangeEvent(
    AppThemeChangeEvent event,
    Emitter<HomeState> emit,
  ) {
    emit(AppThemeChangeActionState());
  }

  FutureOr<void> productiCartButtonClickedEvent(
      ProductiCartButtonClickedEvent event, Emitter<HomeState> emit) {
    print("Product add to Cart");
    ProductData.cartLists.add(event.productModel);
    emit(ProductCartActionState());
  }

  FutureOr<void> productiWishListButtonClickedEvent(
      ProductiWishListButtonClickedEvent event, Emitter<HomeState> emit) {
    ProductData.wishListLists.add(event.productModel);
    emit(ProductWishListActionState());
  }

  FutureOr<void> bottomButtonClickedEvent(
      BottomButtonClickedEvent event, Emitter<HomeState> emit) {
    emit(BottomBarActionState(
      pageIndex: event.pageIndex,
    ));
  }
}
