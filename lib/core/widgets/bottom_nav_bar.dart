import 'package:UpDown/core/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        padding: const EdgeInsets.all(0),
        shape: const CircularNotchedRectangle(),
        height: 60,
        color: Colors.white,
        shadowColor: Colors.black,
        elevation: 20,
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                child: IconButton(
                  icon: Icon(
                    Icons.home,
                    color: Color.fromARGB(221, 34, 34, 34),
                  ),
                  onPressed: () {
                    GoRouter.of(context).go(AppRouter.khomeView);
                  },
                ),
              ),
              Expanded(
                child: IconButton(
                  icon: Icon(
                    Icons.person,
                    color: Color.fromARGB(221, 34, 34, 34),
                  ),
                  onPressed: () {},
                ),
              ),
            ]));
  }
}
