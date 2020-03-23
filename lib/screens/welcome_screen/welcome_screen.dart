import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/home_direction_bloc.dart';
import '../../locale/app_localization.dart';
import 'widget/welcome_page_item.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final int _numPages = 2;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Theme.of(context).primaryColor : Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: <Widget>[
              Container(
                color: Colors.white,
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    WelcomePageItem(
                        title:
                            "${localizedText(context, "setHomeLocationWelcomePage")}",
                        description:
                            "${localizedText(context, "firstlyYouNeedToSetYourHome")}",
                        imageLocation: "assets/images/home_image.png"),
                    WelcomePageItem(
                        title: "${localizedText(context, "getHomeDirection")}",
                        description:
                            "${localizedText(context, "WithYourHomeLocationSet")}",
                        imageLocation: "assets/images/direction_image.png"),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _buildPageIndicator(),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomSheet: _currentPage == _numPages - 1
          ? Container(
              height: 80.0,
              width: double.infinity,
              child: FlatButton(
                onPressed: () => BlocProvider.of<HomeDirectionBloc>(context)
                    .add(HomeDirectionSetEvent()),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
                  child: Text(
                    localizedText(context, 'setHomeLocation'),
                    textAlign: TextAlign.center,
                  ),
                ),
              ))
          : Text(''),
    );
  }
}
