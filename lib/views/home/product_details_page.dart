import 'package:flutter/material.dart';

import '../../core/components/app_back_button.dart';
import '../../core/components/buy_now_row_button.dart';
import '../../core/components/price_and_quantity.dart';
import '../../core/components/product_images_slider.dart';
import '../../core/components/review_row_button.dart';
import '../../core/constants/app_defaults.dart';
import '../../core/models/products_model.dart';

class ProductDetailsPage extends StatelessWidget {
  final Product product; // Product data passed from the previous page
  const ProductDetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: const AppBackButton(),
        title: Text(product.name.toString()),
      ),
      // bottomNavigationBar: SafeArea(
      //   child: Padding(
      //     padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
      //     child: BuyNowRow(
      //       onBuyButtonTap: () {},
      //       onCartButtonTap: () {},
      //     ),
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
             ProductImagesSlider(
              images: [
                product.productImg.toString()
                // 'https://i.imgur.com/3o6ons9.png',
                // 'https://i.imgur.com/3o6ons9.png',
                // 'https://i.imgur.com/3o6ons9.png',
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(AppDefaults.padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    // const SizedBox(height: 8),
                    // const Text('\${product.quantity}'),
                  ],
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
            //   child: PriceAndQuantityRow(
            //     currentPrice: 20,
            //     orginalPrice: 30,
            //     quantity: product.quantity,
            //   ),
            // ),
            // const SizedBox(height: 8),

            /// Product Details
            Padding(
              padding: const EdgeInsets.all(AppDefaults.padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildProductInfo(context),   // Display the product info details here
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  /// Function to build the additional product info details
  Widget buildProductInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildInfoRow(context, 'Department:', '${product.department}'),
        buildInfoRow(context, 'Quantity:', '${product.quantity}'),
        buildInfoRow(context, 'Assigned To:', '${product.assignedTo}'),
        buildInfoRow(context, 'Status:', '${product.status}'),
        buildInfoRow(context, 'Created By:', '${product.createdBy}'),
        buildInfoRow(context, 'Warranty:', '${product.warranty}'),
        buildInfoRow(context, 'Company:', '${product.company}'),
        buildInfoRow(context, 'Purchase Date:', '${product.purchaseDate}'),// Conditional color
      ],
    );
  }

  /// Function to create a row for each product detail
  Widget buildInfoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: label == 'Quantity:'
                    ? Colors.green[800] // Green color for quantity
                    : Colors.grey[700],  // Default grey for other values,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: label == 'Quantity:'
                    ? Colors.green[800] // Green color for quantity
                    : Colors.grey[700],  // Default grey for other values
              ),
            ),
          ),
        ],
      ),
    );
  }
}
