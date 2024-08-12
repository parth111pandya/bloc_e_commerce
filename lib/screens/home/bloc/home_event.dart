part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeInitinalEvent extends HomeEvent {}

class AppThemeChangeEvent extends HomeEvent {}

class ProductiWishlistButtonClickedEvent extends HomeEvent {}

class ProductiCartButtonClickedEvent extends HomeEvent {
  final HomeProductModel productModel;
  ProductiCartButtonClickedEvent({
    required this.productModel,
  });
}

class ProductiWishListButtonClickedEvent extends HomeEvent {
  final HomeProductModel productModel;
  ProductiWishListButtonClickedEvent({
    required this.productModel,
  });
}

class BottomButtonClickedEvent extends HomeEvent {
  final int pageIndex;
  BottomButtonClickedEvent({
    required this.pageIndex,
  });
}
