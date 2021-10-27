import 'package:carrot_market/page/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  late int _currentPageIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentPageIndex = 0;
  }

  Widget _bodyWidget() {
    switch (_currentPageIndex) {
      case 0:
        return Home();
        break;
      case 1:
        return Container();
        break;
      case 2:
        return Container();
        break;
      case 3:
        return Container();
        break;
      case 4:
        return Container();
        break;
    }
    return Container();
  }

  BottomNavigationBarItem _BottomNavigationBarItem(
      String iconName, String label) {
    return BottomNavigationBarItem(
        icon: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: SvgPicture.asset("assets/svg/${iconName}_off.svg", width: 22),
        ),
        activeIcon: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: SvgPicture.asset("assets/svg/${iconName}_on.svg", width: 22),
        ),
        label: label);
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        currentIndex: _currentPageIndex,
        selectedFontSize: 12,
        selectedItemColor: Colors.black,
        selectedLabelStyle: TextStyle(color: Colors.black),
        items: [
          _BottomNavigationBarItem("home", "홈"),
          _BottomNavigationBarItem("notes", "동네생활"),
          _BottomNavigationBarItem("location", "내근처"),
          _BottomNavigationBarItem("chat", "채팅"),
          _BottomNavigationBarItem("user", "나의 당근"),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyWidget(),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }
}
