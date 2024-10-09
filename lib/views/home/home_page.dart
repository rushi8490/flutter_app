import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';
import '../../core/components/app_back_button.dart';
import '../../core/components/product_tile_square.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_icons.dart';
import 'package:http/http.dart' as http;
import '../../core/constants/app_defaults.dart';
import '../../core/constants/dummy_data.dart';
import '../../core/models/products_model.dart';
import '../../core/routes/app_routes.dart';
import '../../core/utils/ui_util.dart';
import 'components/ad_space.dart';
import 'components/our_new_item.dart';
import 'components/popular_packs.dart';
import 'dialogs/product_filters_dialog.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Vegetables'),
//         leading: const AppBackButton(),
//       ),
//       body: GridView.builder(
//         padding: const EdgeInsets.only(top: AppDefaults.padding),
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           mainAxisSpacing: 16,
//           childAspectRatio: 0.66,
//         ),
//         itemCount: 16,
//         itemBuilder: (context, index) {
//           return ProductTileSquare(
//             data: Dummy.products.first,
//           );
//         },
//       ),
//     );
//     // return Scaffold(
//     //   body: SafeArea(
//     //     child: CustomScrollView(
//     //       slivers: [
//     //         SliverAppBar(
//     //           leading: Padding(
//     //             padding: const EdgeInsets.only(left: 8),
//     //             child: ElevatedButton(
//     //               onPressed: () {
//     //                 Navigator.pushNamed(context, AppRoutes.drawerPage);
//     //               },
//     //               style: ElevatedButton.styleFrom(
//     //                 backgroundColor: const Color(0xFFF2F6F3),
//     //                 shape: const CircleBorder(),
//     //               ),
//     //               child: SvgPicture.asset(AppIcons.sidebarIcon),
//     //             ),
//     //           ),
//     //           floating: true,
//     //           title: SvgPicture.asset(
//     //             "assets/images/app_logo.svg",
//     //             height: 32,
//     //           ),
//     //           actions: [
//     //             Padding(
//     //               padding: const EdgeInsets.only(right: 8, top: 4, bottom: 4),
//     //               child: ElevatedButton(
//     //                 onPressed: () {
//     //                   Navigator.pushNamed(context, AppRoutes.search);
//     //                 },
//     //                 style: ElevatedButton.styleFrom(
//     //                   backgroundColor: const Color(0xFFF2F6F3),
//     //                   shape: const CircleBorder(),
//     //                 ),
//     //                 child: SvgPicture.asset(AppIcons.search),
//     //               ),
//     //             ),
//     //           ],
//     //         ),
//     //         const SliverToBoxAdapter(
//     //           child: AdSpace(),
//     //         ),
//     //         const SliverToBoxAdapter(
//     //           child: PopularPacks(),
//     //         ),
//     //         const SliverPadding(
//     //           padding: EdgeInsets.symmetric(vertical: AppDefaults.padding),
//     //           sliver: SliverToBoxAdapter(
//     //             child: OurNewItem(),
//     //           ),
//     //         ),
//     //       ],
//     //     ),
//     //   ),
//     // );
//   }
// }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> products = []; // List to store the products
  final storage = GetStorage(); // Get GetStorage instance
  int currentPage = 1; // Track the current page for pagination
  final int itemsPerPage = 10;
  ScrollController scrollController = ScrollController();
  bool isLoadingMore = false;
  bool hasMoreItems = true;
  String searchQuery = ''; // Store search query
  bool isSearching = false; // Initially, no searching is happening
  bool isLoading = false;  // To manage the loading state

  @override
  void initState() {
    fetchItems();

    scrollController.addListener(() {
      // Check if scrolled to bottom
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent && hasMoreItems && !isLoadingMore) {
        // Trigger next page load
        fetchMoreItems();
      }
    });
    super.initState();
  }


  Future<void> fetchItems() async {
    setState(() {
      isLoading = true;
    });
    const String apiUrl = 'https://avd-assests.uc.r.appspot.com/api/v1/products';
    String? cookie = storage.read('cookie');
    if (cookie == null) {
      print('No cookie found');
      return;
    }

    try {
      // Make a GET request to fetch items for the current page
      final response = await http.get(
        Uri.parse('$apiUrl?page=$currentPage'),
        headers: {
          'Content-Type': 'application/json',
          'cookie': cookie,
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        List<dynamic> productsJson = jsonResponse['products'];

        setState(() {
          products.addAll(
              productsJson.map((productJson) => Product.fromJson(productJson)).toList());

          // Check if more items are available
          hasMoreItems = productsJson.length == itemsPerPage;
          isLoading = true;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        print('Failed to load items: ${response.body}');
      }
    } catch (e) {
      setState(() {
        isLoading = true;
      });
      print('Error: $e');
    }
  }

  Future<void> fetchMoreItems() async {
    setState(() {
      isLoadingMore = true;
    });

    currentPage++; // Increment the page number
    await fetchItems(); // Fetch the next page of items

    setState(() {
      isLoadingMore = false;
    });
  }
  Future<void> searchProduct(String searchProduct) async {
    debugPrint('Searching for: $searchProduct');
    const String apiUrl = 'https://avd-assests.uc.r.appspot.com/api/v1/products';
    String? cookie = storage.read('cookie');
    if (cookie == null) {
      print('No cookie found');
      return;
    }

    try {
      // Make a GET request to fetch items for the current search query
      final response = await http.get(
        Uri.parse('$apiUrl?search=$searchProduct&productStatus=all&productWarranty=all&Sort=newest'),
        headers: {
          'Content-Type': 'application/json',
          'cookie': cookie,
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        List<dynamic> productsJson = jsonResponse['products'];

        setState(() {
          products.clear(); // Clear existing products before adding new ones
          products.addAll(
              productsJson.map((productJson) => Product.fromJson(productJson)).toList());
        });
      } else {
        debugPrint('Failed to load items: ${response.body}');
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  void onSearchChanged(String query) {
    // Set search query and reset product list
    setState(() {
      // isLoading = true;
      print(query);
      searchQuery = query;
      products.clear(); // Clear product list before new search
    });
    if (query.isNotEmpty) {
       searchProduct(searchQuery); // Trigger new search API call if the query is not empty
    }
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Products'),
    //     leading: const AppBackButton(),
    //   ),
    //   body:Column(
    //     children: [
    //       SliverToBoxAdapter(
    //         child: Padding(
    //           padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: [
    //                   Text(
    //                     '${products.length} product${products.length == 1 ? '' : 's'} found',
    //                     style: const TextStyle(
    //                       fontSize: 18,
    //                       fontWeight: FontWeight.bold,
    //                       color: Colors.black, // Ensure good contrast
    //                     ),
    //                   ),
    //                   const Icon(
    //                     Icons.check_circle,
    //                     color: Color(0xFF9B7A5E), // Use a contrasting color
    //                   ),
    //                 ],
    //               ),
    //               const SizedBox(height: 4), // Space between text and line
    //               Container(
    //                 height: 2, // Height of the line
    //                 color: Color(0xFF9B7A5E), // Divider color
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //      Expanded(
    //          child: GridView.builder(
    //            controller:scrollController ,
    //            padding: const EdgeInsets.only(top: AppDefaults.padding),
    //            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //              crossAxisCount: 2,
    //              mainAxisSpacing: 16,
    //              childAspectRatio: 0.66,
    //            ),
    //            itemCount: products.length,
    //            itemBuilder: (context, index) {
    //              return ProductTileSquare(
    //                data:  products[index],
    //              );
    //            },
    //          ),
    //      ),
    //       if (isLoadingMore)
    //         const Padding(
    //           padding: EdgeInsets.all(8.0),
    //           child: CircularProgressIndicator(),
    //         ), // Show loading indicator when fetching more items
    //     ],
    //   )
    // );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        leading: null,
      ),
      body: CustomScrollView(
        controller: scrollController, // Use the scroll controller for pagination
        slivers: [
          // SliverAppBar(
          //   leading: Padding(
          //     padding: const EdgeInsets.only(left: 8),
          //     child: ElevatedButton(
          //       onPressed: () {
          //         Navigator.pushNamed(context, AppRoutes.drawerPage);
          //       },
          //       style: ElevatedButton.styleFrom(
          //         backgroundColor: const Color(0xFFF2F6F3),
          //         shape: const CircleBorder(),
          //       ),
          //       child: SvgPicture.asset(AppIcons.sidebarIcon),
          //     ),
          //   ),
          //   floating: true,
          //   title: SvgPicture.asset(
          //     "assets/images/app_logo.svg",
          //     height: 32,
          //   ),
          //   actions: [
          //     Padding(
          //       padding: const EdgeInsets.only(right: 8, top: 4, bottom: 4),
          //       child: ElevatedButton(
          //         onPressed: () {
          //           Navigator.pushNamed(context, AppRoutes.search);
          //         },
          //         style: ElevatedButton.styleFrom(
          //           backgroundColor: const Color(0xFFF2F6F3),
          //           shape: const CircleBorder(),
          //         ),
          //         child: SvgPicture.asset(AppIcons.search),
          //       ),
          //     ),
          //   ],
          // ),
          // Sliver to display the search header
          SliverToBoxAdapter(
            child: _SearchPageHeader(
              onSearchChanged: onSearchChanged, // Pass the callback function to the search box
            ),
          ),
          // Sliver to display the header with product count
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${products.length} product${products.length == 1 ? '' : 's'} found',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green, // Use a contrasting color
                      ),
                    ],
                  ),
                  const SizedBox(height: 4), // Space between text and line
                  Container(
                    height: 2, // Height of the line
                    color: Colors.green.withOpacity(0.5), // Divider color
                  ),
                ],
              ),
            ),
          ),
          // Sliver to display the product grid
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of items per row
                mainAxisSpacing: 16, // Space between rows
                crossAxisSpacing: 16, // Space between columns
                childAspectRatio: 0.66, // Aspect ratio of each grid item
              ),
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return ProductTileSquare(
                    data: products[index], // Pass the product data
                  );
                },
                childCount: products.length, // Total number of products
              ),
            ),
          ),
          // Sliver to show a loading indicator when fetching more items
          if (isLoadingMore)
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: CircularProgressIndicator(), // Show loading spinner
                ),
              ),
            ),
        ],
      )
    );

  }
  @override
  void dispose() {
    scrollController.dispose();
    // searchController.dispose();
    super.dispose();
  }
}

class _SearchPageHeader extends StatelessWidget {

  final Function(String) onSearchChanged; // Callback function to handle search input

  const _SearchPageHeader({required this.onSearchChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDefaults.padding),
      child: Row(
        children: [
          const SizedBox(width: 16),
          Expanded(
            child: Stack(
              children: [
                /// Search Box
                Form(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(AppDefaults.padding),
                        child: SvgPicture.asset(
                          AppIcons.search,
                          colorFilter: const ColorFilter.mode(
                            AppColors.primary,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      prefixIconConstraints: const BoxConstraints(),
                      contentPadding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    textInputAction: TextInputAction.search,
                    autofocus: false,
                    onChanged: (String value) {
                      onSearchChanged(value); // Trigger the callback on search input change
                    },

                    // onFieldSubmitted: (v) {
                    //   Navigator.pushNamed(context, AppRoutes.searchResult);
                    // },
                  ),
                ),
                Positioned(
                  right: 0,
                  height: 56,
                  child: SizedBox(
                    width: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        UiUtil.openBottomSheet(
                          context: context,
                          widget: const ProductFiltersDialog(),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: SvgPicture.asset(AppIcons.filter),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

