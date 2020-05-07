// Flutter code sample for material.Scaffold.1

// This example shows a [Scaffold] with an [AppBar], a [BottomAppBar] and a
// [FloatingActionButton]. The [body] is a [Text] placed in a [Center] in order
// to center the text within the [Scaffold] and the [FloatingActionButton] is
// centered and docked within the [BottomAppBar] using
// [FloatingActionButtonLocation.centerDocked]. The [FloatingActionButton] is
// connected to a callback that increments a counter.

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  static const String _title = 'Test App';
  static const PrimaryColor = const Color(0xFF107090);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        primaryColor: PrimaryColor,
      ),
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}
class ClicksPerYear {
  final String year;
  final int clicks;
  final charts.Color color;

  ClicksPerYear(this.year, this.clicks, Color color)
      : this.color = charts.Color(
      r: color.red, g: color.green, b: color.blue, a: color.alpha);
}
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _count = 0;
  int _acases = 0;
  int _rcases = 0;
  int _totcases = 0;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  @override
  void initState(){

    getData();
    super.initState();
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = new IOSInitializationSettings();
    var initSettings = new InitializationSettings(android, iOS);
    flutterLocalNotificationsPlugin.initialize(initSettings,onSelectNotification: selectNotification);

  }
  Future selectNotification(String payload){
    debugPrint("payload : $payload");
    showDialog(context: context,builder: (_)=> new AlertDialog(
      title: new Text('Notification'),
      content: new Text('$payload'),
    ));
  }


  @override
  Widget build(BuildContext context) {
    var data = [
      ClicksPerYear('Active Cases:$_acases', _acases, Colors.red),
      ClicksPerYear('Recovered:$_rcases', _rcases, Colors.green),
    ];

    var series = [
      charts.Series(
        domainFn: (ClicksPerYear clickData, _) => clickData.year,
        measureFn: (ClicksPerYear clickData, _) => clickData.clicks,
        colorFn: (ClicksPerYear clickData, _) => clickData.color,
        id: 'Clicks',
        data: data,
      ),
    ];

    var chart = charts.BarChart(
      series,
      animate: true,
    );

    var chartWidget = Padding(
      padding: EdgeInsets.all(32.0),
      child: SizedBox(
        height: 200.0,
        child: chart,
      ),
    );
    return Scaffold(
      drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.grey,
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            )
          ])),
      appBar: AppBar(
        title: Text('Test App'),
      ),
      body: Column(children: <Widget>[
        /*
        Row(
          children: <Widget>[
            Expanded(
          child: Container(
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text('SUBJECT NAME', textAlign: TextAlign.center),
                ),
                Expanded(
                  child: Text('Attendance:', textAlign: TextAlign.center),
                ),
                IconButton(
                  icon: Icon(Icons.add_circle_outline),
                  color: Colors.black,
                  onPressed: () {
                    _count++;
                    _save('test',_count);
                    _read('test');
                  },
                ),
              ],
            ),

            constraints: BoxConstraints.expand(height: 70.0),
            margin: EdgeInsets.all(12),

            decoration: BoxDecoration(
              color: Colors.black26,
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(12),
            ),

          ),
        ),
          ],
        ),
         */
        Row(
          children:<Widget>[
            Expanded(
              child: chartWidget,
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Center(
                child: Text("Total No. Of Cases: $_totcases",style: TextStyle(fontWeight: FontWeight.bold)),
              ),

            ),
    ],
        ),
      ],

      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50.0,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showNotification,
        tooltip: 'Increment Counter',
        child: Icon(Icons.refresh),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Future getData() async{
    var url1 = 'https://henpecked-fourths.000webhostapp.com/getdata1.php';
    var url2 = 'https://henpecked-fourths.000webhostapp.com/getdata2.php';
    http.Response response1 = await http.get(url1);
    http.Response response2 = await http.get(url2);
    var data1 = jsonDecode(response1.body);
    var data2 = jsonDecode(response2.body);
    print((response1.body).toString());
    print((response2.body).toString());
    _acases = data1.toInt();
    _rcases = data2.toInt();
    _totcases = _acases + _rcases;
  }

  showNotification() async {
    setState(() {
      _count++;
    });
    getData();
    print('not');
    var android = new AndroidNotificationDetails('channel id1', 'channel NAME', 'CHANNEL DESCRIPTION',importance: Importance.Max,priority: Priority.High);
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android, iOS);
    var scheduledNotificationDateTime =
    DateTime.now().add(Duration(seconds: 5));
    print(scheduledNotificationDateTime);
    await flutterLocalNotificationsPlugin.schedule(0, 'Test Notification', 'Activated Post 5 Seconds on Button Click',scheduledNotificationDateTime, platform,androidAllowWhileIdle: true);

    //await flutterLocalNotificationsPlugin.show(0, 'Test Notif', 'Flutter Local Notification', platform);
  }
  _read(final key) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getInt(key) ?? 0;
    print('read: $value');
  }

  _save(final key, final value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
    print('saved $value');
  }

}
