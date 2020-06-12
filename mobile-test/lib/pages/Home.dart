import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String imageName;
  String isActiveName;
  bool active = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getResponse();
  }

  void getResponse() async {
    AuthService authService = AuthService();

    var data = await authService.checkIsActive();

    active = data;
    setState(() {
      imageName = data
          ? 'assets/backgrounds/radar_active.png'
          : 'assets/backgrounds/radar_inactive.png';

      isActiveName = data ? "I'm active" : "I'm not active";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: active ? Colors.purple.shade50 : Colors.grey,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(imageName == null ? '' : imageName),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Aerial',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 30.0),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 170),
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.home),
                            Text(isActiveName == null ? '' : isActiveName)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return AerialCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'title',
                          style: TextStyle(
                              backgroundColor: Colors.orange,
                              color: Colors.white,
                              fontSize: 20.0),
                        ),
                        AerialH3('Content'),
                        Text('Details'),
                        Text(
                          'Link',
                          style: TextStyle(
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
