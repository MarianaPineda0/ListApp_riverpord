// Provider de la lista de compras
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tutorial/controller/cart_notifer.dart';
import 'package:riverpod_tutorial/ui/cart_item.dart';

final cartListProvider =
    StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});
