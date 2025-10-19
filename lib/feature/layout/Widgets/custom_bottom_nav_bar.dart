import 'package:flutter/material.dart';
import 'package:weather_app/core/utils/colors/app_colors.dart';

class CustomBottomBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;
  final VoidCallback onCenterTapped;

  const CustomBottomBar({
    required this.selectedIndex,
    required this.onItemTapped,
    required this.onCenterTapped,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
            height: 70,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 136, 161, 198),
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5,
                  spreadRadius: 1,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _barIcon(
                    icon: Icons.home,
                    isSelected: selectedIndex == 0,
                    onTap: () => onItemTapped(0),
                  ),
                  _barIcon(
                    icon: Icons.search,
                    isSelected: selectedIndex == 1,
                    onTap: () => onItemTapped(1),
                  ),

                  _barIcon(
                    icon: Icons.favorite_border,
                    isSelected: selectedIndex == 2,
                    onTap: () => onItemTapped(2),
                  ),
                  GestureDetector(
                    onTap: () => onItemTapped(3),
                    child: CircleAvatar(
                      radius: 16,
                      backgroundImage: const NetworkImage(
                        'https://cdn-front.freepik.com/images/ai/image-generator/gallery/pikaso-woman.webp',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _barIcon({
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return IconButton(
      icon: Icon(icon, color: isSelected ? AppColors.white : Colors.black26),
      onPressed: onTap,
    );
  }
}
