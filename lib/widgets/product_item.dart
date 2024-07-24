import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import '../models/product/product.dart';
import '../models/cart.dart';
import '../screens/product_detail.dart';
import 'package:flutter_rating/flutter_rating.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final quantity = cart.getQuantity(product);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: product),
          ),
        );
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 0.8,
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(15)),
                child: CachedNetworkImage(
                  imageUrl: product.image!,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text('\$${product.price}',
                      style: TextStyle(color: Colors.grey[700], fontSize: 14)),
                  Row(
                    children: [
                      StarRating(
                        rating: product.rating!.rate!,
                        color: Colors.yellow[700],
                        borderColor: Colors.grey,
                        starCount: 5,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '(${product.rating!.rate})',
                        style: TextStyle(color: Colors.grey[700], fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  quantity == 0
                      ? ElevatedButton(
                          onPressed: () {
                            cart.addItem(product: product);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                          child: const Text('ADD',
                              style: TextStyle(color: Colors.white)),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconTheme(
                              data: const IconThemeData(
                                color: Colors.red, // Example: Change icon color
                                size: 24, // Example: Change icon size
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  cart.reduceQuantity(product:product);
                                },
                              ),
                            ),
                            Text(
                              '$quantity',
                              style: const TextStyle(
                                fontSize: 20, // Example: Change font size
                                fontWeight:
                                    FontWeight.bold, // Example: Make text bold
                                color:
                                    Colors.blue, // Example: Change text color
                              ),
                            ),
                            IconTheme(
                              data: const IconThemeData(
                                color:
                                    Colors.green, // Example: Change icon color
                                size: 24, // Example: Change icon size
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  cart.addItem(product: product);
                                },
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
