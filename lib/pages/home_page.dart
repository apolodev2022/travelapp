import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travelapp/pages/favorites_page.dart';
import 'package:travelapp/pages/login_page.dart';
import 'package:travelapp/pages/place_page.dart';
import 'package:travelapp/pages/places_store_page.dart';
import 'package:travelapp/pages/search_place_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentPage = 0;
  late List<Widget> pages;

  @override
  void initState() {
    _loadPage();
    super.initState();
  }

  void _loadPage() {
    pages = [];
    pages.add(PlacePage());
    pages.add(SearchPlacePage());
    pages.add(FavoritesPage());
    pages.add(PlacesStorePage());
  }

  void _onItemTapped(int page) {
    setState(() {
      currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TravelApp"),
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
              const PopupMenuItem(
                  value: Menu.logOut, child: Text('Cerrar sesión'))
            ],
            onSelected: (Menu item) {
              setState(() {
                if (item == Menu.logOut) {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                }
              });
            },
          )
        ],
      ),
      body: IndexedStack(
        index: currentPage,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        type: BottomNavigationBarType.fixed,
        onTap: (page) {
          _onItemTapped(page);
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.locationArrow, size: 20),
              label: 'Mis lugares'),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.searchengin, size: 20),
              label: 'Buscar'),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.heart, size: 20), label: 'Favoritos'),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.locationDot, size: 20), label: 'Recomendados'),
        ],
      ),
    );
  }
}
