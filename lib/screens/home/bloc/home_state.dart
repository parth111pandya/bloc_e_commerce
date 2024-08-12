part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

sealed class HomeActionState extends HomeState {}

class HomeInitial extends HomeState {}

class HomeLodingState extends HomeState {}

class HomeLoadedSuccessState extends HomeState {
  final List<HomeProductModel> homePoductList;
  final List<String> categoriesList;

  HomeLoadedSuccessState({
    required this.homePoductList,
    required this.categoriesList,
  });
}

class HomeErrorState extends HomeState {}

class AppThemeChangeActionState extends HomeActionState {}

class ProductWishListActionState extends HomeActionState {}

class ProductCartActionState extends HomeActionState {}

class BottomBarActionState extends HomeActionState {
  final int pageIndex;
  BottomBarActionState({
    required this.pageIndex,
  });
}
