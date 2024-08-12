part of 'wishlist_bloc.dart';

@immutable
sealed class WishlistState {}

final class WishlistInitial extends WishlistState {}

class WishListLoadingState extends WishlistState {}

class WishListLoadedState extends WishlistState {
  final List<HomeProductModel> wishlistLists;
  WishListLoadedState({
    required this.wishlistLists,
  });
}
