import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../models/products_model.dart';
import '../routes/app_routes.dart';
import 'network_image.dart';

class ProductTileSquare extends StatelessWidget {
   const ProductTileSquare({
    super.key,
    required this.data,
  });
  final Product data;
  // final ProductModel data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding / 2),
      child: Material(
        borderRadius: AppDefaults.borderRadius,
        color: AppColors.scaffoldBackground,
        child: InkWell(
          borderRadius: AppDefaults.borderRadius,
          onTap: () => Navigator.pushNamed(context, AppRoutes.productDetails,arguments: data), // Passing the entire product data as an argument),
          child: Container(
            width: 176,
            height: 300,
            padding: const EdgeInsets.all(AppDefaults.padding),
            decoration: BoxDecoration(
              border: Border.all(width: 0.6, color: Colors.green),
              borderRadius: AppDefaults.borderRadius,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(3),
                  child: AspectRatio(
                    aspectRatio: 1.15,
                    child: NetworkImageWithLoader(
                      data.productImg.toString(),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  data.name,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Colors.black),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                // const Spacer(),
                // Text(
                //   data.weight,
                // ),
                const SizedBox(height: 4),
                /* ---- Department and Quantity ---- */
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Department: ${data.department}', // Label for department
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey[700], // Slightly darker gray for better readability
                            ),
                            overflow: TextOverflow.ellipsis, // Ensure long department names are handled properly
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),

                    // Quantity displayed in its own Text widget without Expanded
                    Text(
                      'Quantity: ${data.quantity}', // Label for quantity
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold, // Make the quantity stand out
                        color: Colors.green[800], // Use a color that matches the theme
                      ),
                    ),
                  ],
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
