import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Native Code',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int? _batteryLevel ;
  bool _show = false;

  Future<void> _getBatteryLevel() async{
    const platform = MethodChannel("course.flutter.dev/battery");
    try{
      final batteryLevel = await platform.invokeMethod("getBatteryLevel");
      setState(() {
        _batteryLevel = batteryLevel;
      });
    }on PlatformException catch (err){
      setState(() {
        _batteryLevel = null;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getBatteryLevel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Native Code'),
        backgroundColor: Colors.lightGreen,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if(_show)Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: Colors.deepPurple,width: 5),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Text(
                'Battery Level: $_batteryLevel',
                style: const TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 26,
                ),
              ),
            ),
            const SizedBox(height: 50,),
            ElevatedButton(
              onPressed: (){
                setState(() {
                  _show = !_show;
                });
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
                padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                )),
              ),
              child: Text(
                _show ? "HIDE Battery Percentage" : "SHOW Battery Percentage",
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


}
