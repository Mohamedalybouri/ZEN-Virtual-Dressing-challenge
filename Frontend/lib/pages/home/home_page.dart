import 'package:flutter/material.dart';
import 'package:zen_virtual_dressing/pages/authentication/login_page.dart';
import 'package:zen_virtual_dressing/widgets/home/categories_section.dart';
import 'package:zen_virtual_dressing/widgets/home/search_container.dart';
import '../../widgets/home/clothe_card.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> categories = [
      "Tops", "Bottoms", "Dresses", "Outerwear",
      "Ethnic & Cultural Wear", "Activewear",
      "Intimates & Loungewear", "Footwear",
      "Accessories", "Occasion-Based Clothing"
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF666AEC),
        title: const Text(
          "ZEN Virtual Dressing",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),
        ),
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: Colors.white,
                    title: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check_circle_outline, color: Colors.green, size: 70,),
                        SizedBox(height: 10,),
                        Text("Confirm", style: TextStyle(fontWeight: FontWeight.w500),),
                      ],
                    ),
                    content: const Text("Are you sure you want to logout?", style: TextStyle(fontSize: 16), textAlign: TextAlign.center,),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.grey,
                              padding:const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            ),
                            onPressed: () => Navigator.of(context).pop(false), // Cancel
                            child: const Text("Cancel", style: TextStyle(color: Colors.white, fontSize: 16),),
                          ),
                          const SizedBox(width: 15,),
                          TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            ),
                            onPressed: () async {
                              Navigator.of(context).pop();
                              Get.offAll(const LoginPage());
                            },
                            child: const Text("Logout", style: TextStyle(color: Colors.white, fontSize: 16),),
                          ),
                        ],
                      ),
                    ],
                  );
                }
              );
            }, icon: const Icon(Icons.logout, color: Colors.white, size: 29)),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SearchContainer(),
              const SizedBox(height: 20),
              CategoriesSection(categories: categories),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.8, // Adjust this to control card height
                  ),
                  itemCount: 2, // Number of items you want to display
                  itemBuilder: (context, index) {
                    return ClotheCard(
                      imgPath: index == 0 ? "assets/clothes/robe.jpg" : "assets/clothes/tshirt1.jpg", // Example image paths
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}