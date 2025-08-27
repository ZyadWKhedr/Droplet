import 'package:droplet/core/extensions/localization_extension%20.dart';
import 'package:droplet/features/ai/presentation/pages/chat_page.dart';
import 'package:droplet/features/home/presentation/pages/profile_page.dart';
import 'package:droplet/features/home/presentation/providers/nav_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NavPage extends ConsumerWidget {
  const NavPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(navIndexProvider);

    final pages = [
      const Center(child: Text("Home Page")),
      const ChatPage(),
      const ProfilePage(),
    ];

    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.r),
            topRight: Radius.circular(12.r),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.r),
            topRight: Radius.circular(12.r),
          ),
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) {
              ref.read(navIndexProvider.notifier).toggleIndex(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: context.loc.home,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: context.loc.aiChat,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: context.loc.profile,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
