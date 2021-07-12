
import 'package:flutter/material.dart';
import 'package:pageview/slide_tile.dart';

class BaseScreen extends StatefulWidget {
  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.8);

  int _currentPage = 0;

  var _listSlide = [
    {'id': 0, 'image': 'assets/images/img1.jpeg'},
    {'id': 1, 'image': 'assets/images/img2.jpeg'},
    {'id': 2, 'image': 'assets/images/img3.jpeg'}
  ];

  @override
  void initState() {
    _pageController.addListener(() {
      int next = _pageController.page.round();
      if (_currentPage != next) {
        setState(() {
          _currentPage = next;
        });
      }
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _listSlide.length,
                itemBuilder: (_, currentIndex) {
                  bool activePage = currentIndex == _currentPage;
                  return SlideTile(
                    activePage: activePage,
                    image: _listSlide[currentIndex]['image'],
                  );
                },
              ),
            ),
            _buildBullets(),
          ],
        ),
      ),
    );
  }

  Widget _buildBullets() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _listSlide.map(
              (i) {
            return InkWell(
              onTap: () {
                setState(() {
                  _pageController.jumpToPage(i['id']);
                  _currentPage = i['id'];
                });
              },
              child: Container(
                margin: EdgeInsets.all(10),
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: _currentPage == i['id'] ? Colors.red : Colors.grey,
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
