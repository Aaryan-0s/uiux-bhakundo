import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nba_hub/features/favourite/presentation/view/Favourite.dart';
import 'package:nba_hub/features/games/presentation/view/home.dart';
import 'package:nba_hub/features/profile/presentation/view/newScreen.dart';
import 'package:nba_hub/features/profile/presentation/view/profile_screen.dart';
import 'package:nba_hub/features/standing/presentation/view/standings.dart';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
  int selectIndex = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.shortestSide >= 600;

    List<Widget> lstBottomScreen = [
      const Home(),
      const Standings(),
      const News(),
      const Favourite(),
      const ProfileScreen(),
      
    ];

    return Scaffold(
      body: lstBottomScreen[selectIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:
            isTablet ? Colors.grey[900] : const Color.fromARGB(255, 9, 8, 8),
        items: [
          BottomNavigationBarItem(
            icon: SizedBox(
                width: isTablet ? 48.0 : 32.0,
                child: const Icon(
                 Icons.sports_soccer_outlined,
                  color: Colors.grey,
                )),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
                width: isTablet ? 48.0 : 32.0,
                child: const Icon(
                  CupertinoIcons.chart_bar_square,
                  color: Colors.grey,
                )),
            label: 'standings',
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
                width: isTablet ? 48.0 : 32.0,
                child: const Icon(
                  CupertinoIcons.news,
                  color: Colors.grey,
                )),
            label: 'News',
          ),
          BottomNavigationBarItem(
            // icon: Image.asset('assets/icon/heart.png',
            //     width: isTablet ? 48.0 : 32.0),
            icon: SizedBox(
                width: isTablet ? 48.0 : 32.0,
                child: const Icon(
                  CupertinoIcons.star,
                  color: Colors.grey,
                )),
            label: 'Favourite',
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
                width: isTablet ? 48.0 : 32.0,
                child: const Icon(
                  CupertinoIcons.profile_circled,
                  color: Colors.grey,
                )),
            label: 'Profile',
          ),
        ],
        currentIndex: selectIndex,
        onTap: (index) {
          setState(
            () {
              selectIndex = index;
            },
          );
        },
      ),
    );
  }
}
