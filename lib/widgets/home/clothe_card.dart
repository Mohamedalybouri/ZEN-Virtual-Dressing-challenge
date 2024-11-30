import 'package:flutter/material.dart';
import 'package:zen_virtual_dressing/pages/home/try_on_page.dart';
import 'package:get/get.dart';

class ClotheCard extends StatelessWidget {
  final String imgPath;
  const ClotheCard({
    super.key, required this.imgPath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
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
              content: const Text("Are you sure you want to try the clothes on your picture?", style: TextStyle(fontSize: 16), textAlign: TextAlign.center,),
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
                        Get.to(const TryOnPage());
                      },
                      child: const Text("Try", style: TextStyle(color: Colors.white, fontSize: 16),),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: Image.asset(
                imgPath,
                height: 150,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
            const Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4
              ),
              child: Text(
                "T-Shirt",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
            const Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4
              ),
              child: Text(
                '140 TND',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}