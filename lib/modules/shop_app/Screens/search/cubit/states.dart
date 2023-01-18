abstract class ShopAppSearchStates{}

class ShopAppSearchInitialStates extends ShopAppSearchStates{}

class ShopAppSearchLoadingStates extends ShopAppSearchStates{}

class ShopAppSearchSuccessStates extends ShopAppSearchStates{}

class ShopAppSearchErrorStates extends ShopAppSearchStates{

  final String error;
  ShopAppSearchErrorStates(
      this.error,
      );
}

