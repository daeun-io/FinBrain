import 'package:finbrain/ui/screen/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:finbrain/themes/colors.dart';

class MainScreen extends StatefulWidget{
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin{

  int _currentIndex = 0;
  
  // todo: 추후 수정
  final List<Widget> _pages = [
    ProductScreen(),
    ProductScreen(),
    ProductScreen(),
    ProductScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70.0),
          child: Padding(
            padding: const EdgeInsets.only(top:20.0),
            child: AppBar(
              backgroundColor: white,
              leading: Image.asset("assets/images/icon.png"),
              title: const Text(
                  "FinBrain", 
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900
                  ),
                ),
              titleSpacing: -8,
              actions: [
                OutlinedButton(
                  onPressed: (){},
                  style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
                  side: BorderSide(
                    color: textPrimary,
                    width: 1
                    ),
                  ),
                  // 추후 수정
                  child: const Text(
                    "큰 글씨",
                    style: TextStyle(
                      color: textPrimary,
                      fontSize: 14.0,
                    ),
                  ),
                ),
                SizedBox(width: 20, height: 60,)
              ],
            ),
          ),
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
        bottomNavigationBar: Container(
          height: 70,
          decoration: const BoxDecoration(
            color: primary100,
            border: Border(
              top: BorderSide(
                color: primary300,
                width: 1.0
              )
            )
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              splashFactory: NoSplash.splashFactory,
              highlightColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              onTap: (value){
                setState(() {
                  _currentIndex = value;
                });
              },
              currentIndex: _currentIndex,
              elevation: 0,
              enableFeedback: false,
              backgroundColor: Colors.transparent,
              selectedItemColor: textPrimary,
              unselectedItemColor: textSecondary,
              selectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14
              ),
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14
              ),
              type: BottomNavigationBarType.fixed,
              items: [
                const BottomNavigationBarItem(icon: Icon(Icons.savings, size: 28,), label: "예적금"),
                const BottomNavigationBarItem(icon: Icon(Icons.paid, size: 28), label: "대출"),
                const BottomNavigationBarItem(icon: Icon(Icons.money, size: 28), label: "연금저축"),
                const BottomNavigationBarItem(icon: Icon(Icons.favorite, size: 28), label: "관심"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}