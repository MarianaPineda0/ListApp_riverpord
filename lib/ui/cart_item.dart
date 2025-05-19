import 'package:flutter/material.dart';

@immutable
class CartItem {
  // variables
  final int number;
  final bool inCart;

  // constructor
  const CartItem({required this.number, required this.inCart});

  // funcion para cambiar alguno de los parametros
  CartItem copyWith({int? number, bool? inCart}) {
    return CartItem(
        number: number ?? this.number, inCart: inCart ?? this.inCart);
  }
}

// Genera una lista de tipo CartItem del 0 al 9 todos con el valor inCart falso
var cartList =
    List<CartItem>.generate(10, (i) => CartItem(number: i++, inCart: false));