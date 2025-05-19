// Lista del menu desplegable
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tutorial/provider/cart_provider.dart';
import 'package:riverpod_tutorial/ui/cart_item.dart';


var menuItems = [
  'En el carrito',
  'Por comprar',
  'Completa',
];

// Provider para saber el estado del menu, por defecto inicia con la lista completa
final menuProvider = StateProvider<String>((ref) {
  return 'Completa';
});

// Provider para retornar la lista filtrada segun los items del menu
final filteredCartListProvider = Provider<List<CartItem>>((ref) {
  final filter = ref.watch(menuProvider);
  final cartList = ref.watch(cartListProvider);
  switch (filter) {
    case 'Completa':
      return cartList;
    case 'En el carrito':
      return cartList.where((item) => item.inCart).toList();
    case 'Por comprar':
      return cartList.where((item) => !item.inCart).toList();
  }
  throw {};
});