import 'package:flutter/material.dart';

class SearchContainer extends StatelessWidget {
  const SearchContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(width: 2, color: Color(0xFF9598A6))
      ),
      child: const Row(
        children: [
          Icon(Icons.search_outlined, color: Color(0xFF9598A6)),
          SizedBox(width: 24.0,),
          Text(
            "Search Clothes",
            style: TextStyle(
                color: Color(0xFF9598A6),
                fontSize: 16,
                fontWeight: FontWeight.w500
            ),
          )
        ],
      ),
    );
  }
}