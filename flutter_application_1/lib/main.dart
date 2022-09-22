import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/notifier.dart';
import 'package:provider/provider.dart';

import 'themes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => NotifierSnabbsaldo())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: LoginPage(),
          theme: themeData(),
        ));
  }

  ThemeData themeData() {
    return ThemeData();
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: stackBuild(context),
    );
  }

  Widget stackBuild(context) {
    return Stack(
      children: [
        backgroundImage(),
        backgroundFilter(),
        contentView(context),
        Consumer<NotifierSnabbsaldo>(
            builder: (context, notifierSnabbsaldo, child) =>
                backgroundBlur(context)),
        Consumer<NotifierSnabbsaldo>(
            builder: (context, notifierSnabbsaldo, child) =>
                snabbsaldoField(context))
      ],
    );
  }

  Container backgroundImage() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/backgroundimage2.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Container backgroundFilter() {
    return Container(
      decoration: BoxDecoration(color: Color.fromARGB(40, 37, 37, 37)),
    );
  }

  Widget backgroundBlur(context) {
    if (Provider.of<NotifierSnabbsaldo>(context, listen: false).getBlured ==
        true) {
      return GestureDetector(
        onTap: () {
          Provider.of<NotifierSnabbsaldo>(context, listen: false)
              .buttonPressed();
        },
        child: Container(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: Colors.grey.withOpacity(0.1),
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget snabbsaldoField(context) {
    if (Provider.of<NotifierSnabbsaldo>(context, listen: false).getBlured ==
        true) {
      return Center(
          child: Container(
              decoration: BoxDecoration(
                  color: themeColors.darkGrey,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              width: 300,
              height: 110,
              child: Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '3 Gemensamt Allkort',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        '15203,38',
                        style: TextStyle(color: themeColors.blue, fontSize: 30),
                      )
                    ],
                  ))));
    } else {
      return Container();
    }
  }

  Widget contentView(context) {
    return Column(
      children: [
        Container(
          height: 50,
        ),
        textHandelsbanken(),
        Container(
          height: 10,
        ),
        buttonSnabbsaldo(context),
        Expanded(
          child: Container(),
        ),
        loggaInField(context)
      ],
    );
  }

  Widget textHandelsbanken() {
    return Text('Handelsbanken',
        style: TextStyle(
            fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white));
  }

  Widget buttonSnabbsaldo(context) {
    return SizedBox(
      height: 28,
      child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
              ),
              primary: themeColors.darkGrey),
          label: Text(
            'Visa snabbsaldo',
            style: TextStyle(
                color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            Provider.of<NotifierSnabbsaldo>(context, listen: false)
                .buttonPressed();
          },
          icon: Icon(
            Icons.arrow_drop_down_circle,
            color: Colors.white,
            size: 15,
          )),
    );
  }

  Container loggaInField(context) {
    return Container(
      height: 170,
      decoration: BoxDecoration(
          color: themeColors.darkGrey,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
        child: Column(
          children: [
            buttonLoggaIn(),
            Container(height: 5),
            Row(
              children: [
                buttonBytInloggning(),
                Expanded(child: Container()),
                menyButton(context)
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buttonLoggaIn() {
    return SizedBox(
      height: 40,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(primary: themeColors.blue),
          onPressed: () {},
          child: Row(
            children: [
              Container(width: 15),
              Text(
                'Logga in',
                style: TextStyle(color: themeColors.darkGrey, fontSize: 17),
              ),
              Expanded(child: Container()),
              SizedBox(
                  width: 20,
                  height: 20,
                  child: Image.asset('assets/bankid.png')),
              Container(width: 15),
            ],
          )),
    );
  }

  Widget buttonBytInloggning() {
    return TextButton(
      onPressed: () {},
      child: Text('Byt inloggningssätt',
          style: TextStyle(color: Colors.white, fontSize: 12)),
    );
  }

  Widget menyButton(context) {
    return SizedBox(
      height: 60,
      width: 55,
      child: PopupMenuButton(
          color: themeColors.darkGrey,
          constraints: BoxConstraints(
            maxWidth: 1000,
          ),
          icon: Column(
            children: [
              Icon(
                Icons.menu,
                color: Colors.white,
              ),
              Text('Meny', style: TextStyle(color: Colors.white))
            ],
          ),
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Icon(Icons.headphones_outlined, color: Colors.white),
                        Container(width: 10),
                        textMeny('Kontakta oss')
                      ],
                    )),
              ),
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(Icons.map_outlined, color: Colors.white),
                    Container(width: 10),
                    textMeny('Kontor och automater')
                  ],
                ),
              ),
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(Icons.lock_outline, color: Colors.white),
                    Container(width: 10),
                    textMeny('Säkerhet')
                  ],
                ),
              ),
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(Icons.tv_outlined, color: Colors.white),
                    Container(width: 10),
                    textMeny('Ekonomikanalen')
                  ],
                ),
              ),
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(Icons.mobile_screen_share_outlined,
                        color: Colors.white),
                    Container(width: 10),
                    textMeny('Om appen')
                  ],
                ),
              ),
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(Icons.language, color: Colors.white),
                    Container(width: 10),
                    textMeny('In English')
                  ],
                ),
              ),
            ];
          }),
    );
  }

  Widget textMeny(text) {
    return Text(text, style: TextStyle(color: Colors.white));
  }
}
