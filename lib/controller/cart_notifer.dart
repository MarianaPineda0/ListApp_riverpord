import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tutorial/ui/cart_item.dart';


// Notifier del estado de la lista de items de compra

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super(cartList);

  // añade un nuevo item, reemplazando la lista anterior, porque state es immutable
  void add(CartItem item) {
    state = [...state, item];
  }

  // cambia el estado de inCart al valor contrario, falso -> verdadero y viceversa
  void toggle(int itemNumber) {
    state = [
      for (final item in state)
        if (item.number == itemNumber)
          item.copyWith(inCart: !item.inCart)
        else
          item,
    ];
  }

  // retorna un entero para saber el total de items en la lista completa
  int countTotalItems() {
    return state.length;
  }
}