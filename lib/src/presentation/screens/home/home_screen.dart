import 'package:emcare/constants.dart';
import 'package:emcare/src/presentation/screens/analysis/analysis_screen.dart';
import 'package:emcare/src/presentation/screens/chat/chat_screen.dart';
import 'package:emcare/src/presentation/screens/perfil/perfil_screen.dart';
import 'package:emcare/src/presentation/screens/stadistics/stadistics_screen.dart';
import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:hidden_drawer_menu/model/item_hidden_menu.dart';
import 'package:hidden_drawer_menu/model/screen_hidden_drawer.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<ScreenHiddenDrawer> items = [];
  final fontS = 25.0;
  @override
  void initState() {
    items.add(
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: "EmCare Bot",
          baseStyle: TextStyle(color: kBackgroundColor2, fontSize: fontS),
          colorLineSelected: kPrimaryColor,
        ),
        Chat(),
      ),
    );

    items.add(
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: "Estadísticas",
          baseStyle: TextStyle(color: kBackgroundColor2, fontSize: fontS),
          colorLineSelected: kPrimaryColor,
        ),
        Stadistics(),
      ),
    );

    items.add(
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: "Análisis",
          baseStyle: TextStyle(color: kBackgroundColor2, fontSize: fontS),
          colorLineSelected: kPrimaryColor,
        ),
        Analysis(),
      ),
    );

    items.add(
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: "Perfil",
          baseStyle: TextStyle(color: kBackgroundColor2, fontSize: fontS),
          colorLineSelected: kPrimaryColor,
        ),
        Perfil(),
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      backgroundColorMenu: kSecondColor,
      backgroundColorAppBar: kPrimaryColor,
      screens: items,
      //    typeOpen: TypeOpen.FROM_RIGHT,
      //    disableAppBarDefault: false,
      //    enableScaleAnimin: true,
      //    enableCornerAnimin: true,
      slidePercent: 60.0,
      //    verticalScalePercent: 80.0,
      //    contentCornerRadius: 10.0,
      //    iconMenuAppBar: Icon(Icons.menu),
      //    backgroundContent: DecorationImage((image: ExactAssetImage('assets/bg_news.jpg'),fit: BoxFit.cover),
      //    whithAutoTittleName: true,
      //    styleAutoTittleName: TextStyle(color: Colors.red),
      //    actionsAppBar: <Widget>[],
      //    backgroundColorContent: Colors.blue,
      //    elevationAppBar: 4.0,
      //    tittleAppBar: Center(child: Icon(Icons.ac_unit),),
      //    enableShadowItensMenu: true,
      //    backgroundMenu: DecorationImage(image: ExactAssetImage('assets/bg_news.jpg'),fit: BoxFit.cover),
    );
  }
}
