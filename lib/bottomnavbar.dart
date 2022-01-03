import 'package:flutter/material.dart';
import 'package:vlossom/Pages/explore.dart';
import 'package:vlossom/Pages/homepage.dart';
import 'package:vlossom/Pages/search.dart';
import 'package:page_transition/page_transition.dart';

class BottomNav extends StatefulWidget {
  late var index;
  BottomNav({@required this.index});

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter, end: Alignment.bottomCenter,
                // stops: [0.0, 0.8],
                // tileMode: TileMode.clamp,
                colors: [Color(0xff070919), Color(0xff191b29)])),
        child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            // elevation: 0,
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            unselectedItemColor: Colors.white,
            currentIndex: widget.index,
            selectedItemColor: Colors.blue,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.explore),
                label: 'Explore',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Find',
              ),
            ],
            // initialActiveIndex: 3,
            onTap: (int i) {
              setState(() {
                if (i == 0) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade, child: HomePage()),
                    (Route<dynamic> route) => false,
                  );
                } else if (i == 1) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade, child: ExplorePage()),
                    (Route<dynamic> route) => false,
                  );
                } else if (i == 2) {
                  // Navigator.push(context, ScaleRoute(page: SearchPage()));
                  Navigator.pushAndRemoveUntil(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade, child: SearchPage()),
                    (Route<dynamic> route) => false,
                  );
                }
              });
            }));
  }
}

// class ScaleRoute extends PageRouteBuilder {
//   final Widget page;
//   ScaleRoute({required this.page})
//       : super(
//           pageBuilder: (
//             BuildContext context,
//             Animation<double> animation,
//             Animation<double> secondaryAnimation,
//           ) =>
//               page,
//           transitionsBuilder: (
//             BuildContext context,
//             Animation<double> animation,
//             Animation<double> secondaryAnimation,
//             Widget child,
//           ) =>
//               SlideTransition(
//             position: Tween<Offset>(
//               begin: const Offset(-1, 0),
//               end: Offset.zero,
//             ).animate(animation),
//             child: child,
//           ),
//         );
// }
