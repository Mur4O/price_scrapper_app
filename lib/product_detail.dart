import 'package:flutter/material.dart';
import 'package:price_scrapper_app/product.dart';
import 'package:price_scrapper_app/main.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2E),
      appBar: AppBar(
        title: Text(product.productName ?? 'Детали продукта'),
        backgroundColor: const Color(0xFF2A2A3C),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      product.imagePath != null && product.imagePath!.isNotEmpty
                          ? "${HomeState.serverAddress}/$product.imagePath" // This might need adjustment based on how imagePath is stored
                          : "${HomeState.serverAddress}/assets/1.png", 
                      // Note: I'm using a fallback because the current implementation seems to use a hardcoded path.
                      // In a real scenario, we'd check if product.imagePath is a full URL or just a path relative to serverAddress.
                      // For now, let's stick to what works in the list view if imagePath isn't provided correctly.
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Icon(Icons.broken_image, size: 100, color: Colors.grey),
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Наименование:',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              Text(
                product.productName ?? 'Нет названия',
                style: const TextStyle(fontSize: 18, color: Colors.white70),
              ),
              const SizedBox(height: 16),
              const Text(
                'Цена:',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              Text(
                product.price ?? 'Нет цены',
                style: const TextStyle(fontSize: 18, color: Colors.white70),
              ),
              const SizedBox(height: 24),
              // Add more info here if needed in the future
            ],
          ),
        ),
      ),
    );
  }
}