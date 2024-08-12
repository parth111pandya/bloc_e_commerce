import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_commerce/data/product_data.dart';
import 'package:e_commerce/screens/home/models/home_product_model.dart';
import 'package:meta/meta.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial()) {
    on<WishlistInitialEvent>(wishlistInitialEvent);
  }

  FutureOr<void> wishlistInitialEvent(
      WishlistInitialEvent event, Emitter<WishlistState> emit) async {
    emit(WishListLoadingState());
    await Future.delayed(Duration(seconds: 3));
    emit(WishListLoadedState(
      wishlistLists: ProductData.wishListLists,
    ));
  }
}
