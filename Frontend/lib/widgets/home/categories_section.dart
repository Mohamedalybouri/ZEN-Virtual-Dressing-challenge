import 'package:flutter/material.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({
    super.key,
    required this.categories,
  });

  final List<String> categories;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index){
          return InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Chip(
                backgroundColor: Colors.white,
                label: Text(
                  categories[index],
                  style: const TextStyle(
                      color: Color(0xFF9598A6),
                    fontSize: 18
                  ),
                ),
                side: const BorderSide(
                  color: Color(0xFF9598A6), // Border color (adjust as needed)
                  width: 1.5, // Border width (adjust as needed)
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Optional: for rounded corners
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}