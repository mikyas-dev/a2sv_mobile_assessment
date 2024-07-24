import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product/product.dart';
import '../models/cart.dart';
import 'package:flutter_rating/flutter_rating.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: product.image!,
              fit: BoxFit.cover,
              height: 400, // Adjusted height for better appearance
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Chip(
                        label: Text(
                          '\$${product.price}',
                          style: const TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.green,
                      ),
                      const SizedBox(width: 8),
                      // Chip(
                      //   avatar: Icon(Icons.star, color: Colors.yellow[600], size: 14),
                      //   label: Text(
                      //     '${product.rating?.rate}',
                      //     style: const TextStyle(fontSize: 14),
                      //   ),
                      //   backgroundColor: Colors.grey[200],
                      // ),

                      StarRating(
                        rating: product.rating!.rate!,
                        color: Colors.yellow[700],
                        borderColor: Colors.grey[500]!,
                        starCount: 5,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '(${product.rating!.rate})',
                        style: const TextStyle(fontSize: 14),
                      ),
                      
                      Text(
                        '(${product.rating!.count})',
                        style: const TextStyle(fontSize: 14),
                      ),

                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    product.description!,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          cart.addItem(product:product);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green, // Button color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 24,
                          ),
                        ),
                        child: const Text(
                          'Add to Cart',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Text(
                        'Quantity: ${cart.getQuantity(product)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
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
