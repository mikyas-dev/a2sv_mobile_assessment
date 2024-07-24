import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../models/cart.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;
  final Function(String) removeItem;

  const CartItemWidget({
    required this.cartItem,
    required this.removeItem,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ListTile(
          leading: CachedNetworkImage(
            imageUrl: cartItem.imageUrl,
            fit: BoxFit.cover,
            width: 50,
            height: 50,
          ),
          title: Text(cartItem.title),
          subtitle: Text('Total: \$${(cartItem.price * cartItem.quantity)}'),
          trailing: Text('${cartItem.quantity} x'),
        ),
      ),
    );
  }
}
