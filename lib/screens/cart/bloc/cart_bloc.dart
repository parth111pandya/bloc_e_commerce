import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:e_commerce/data/product_data.dart';
import 'package:e_commerce/screens/home/models/home_product_model.dart';
import 'package:meta/meta.dart';
part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartIntialEvent>(cartIntialEvent);
  }
  FutureOr<void> cartIntialEvent(
      CartIntialEvent event, Emitter<CartState> emit) async {
    print("cartIntialEvent");
    emit(CartLoadingState());
    await Future.delayed(Duration(seconds: 3));
    emit(CartLoadedState(
      cartList: ProductData.cartLists,
    ));
  }
}
