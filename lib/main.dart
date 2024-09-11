import 'package:flutter/material.dart';

import 'API.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('กรุณาเข้าสู่ระบบ'),
              TextField(
                decoration: InputDecoration(
                    labelText: "ชื่อผู้ใช้",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                    labelText: 'รหัสผ่าน',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
                obscureText: true,
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Menu()),
                  );
                },
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("สภาพอากาศทั่วไป"),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      child: Icon(Icons.map_outlined),
                    ),
                    Text("อุณหภูมิต่างประเทศ"),
                  ],
                ),
                SizedBox(height: 10),
                Column(
                  children: [
                    Container(
                      width: double.maxFinite,
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.greenAccent),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.sunny,
                            color: Colors.black,
                          ),
                          Text(
                            "โตเกียว",
                            style: TextStyle(color: Colors.black),
                          ),
                          Text(
                            "24 °C",
                            style: TextStyle(color: Colors.black),
                          ),
                          Text(
                            "Breez",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(10),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Column(
                  children: [
                    Container(
                      width: double.maxFinite,
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.lightBlueAccent),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.snowing,
                            color: Colors.black,
                          ),
                          Text(
                            "มอสโก",
                            style: TextStyle(color: Colors.black),
                          ),
                          Text(
                            "-3 °C",
                            style: TextStyle(color: Colors.black),
                          ),
                          Text(
                            "Blizzard",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(10),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Column(
                  children: [
                    Container(
                      width: double.maxFinite,
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.orange),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.cloudy_snowing,
                            color: Colors.black,
                          ),
                          Text(
                            "ฮ่องกง",
                            style: TextStyle(color: Colors.black),
                          ),
                          Text(
                            "30 °C",
                            style: TextStyle(color: Colors.black),
                          ),
                          Text(
                            "Rainning",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(10),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Column(
                  children: [
                    Container(
                      width: double.maxFinite,
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.red),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.sunny,
                            color: Colors.black,
                          ),
                          Text(
                            "มุมไบ",
                            style: TextStyle(color: Colors.black),
                          ),
                          Text(
                            "38 °C",
                            style: TextStyle(color: Colors.black),
                          ),
                          Text(
                            "Sunny",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(10),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => API()),
                    );
                  },
                  child: Text('ดูอุณหภูมิเพิ่มเติมของประเทศไทย',style: TextStyle(fontSize: 30,color: Colors.black),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class API extends StatefulWidget {
  const API({super.key});

  @override
  State<API> createState() => _MyAppState();
}

class _MyAppState extends State<API> {
  late Future<List<dynamic>> post;
  var data = [];
  var checkStatus = true;

  @override
  Widget build(BuildContext context) {
    post = apiGetData();
    post.then((value) {
      for (var item in value) {
        data.add(item);
      }
      setState(() {
        checkStatus = false;
      });
    });
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("อุณหภูมิในประเทศไทย"),
        ),
        body: Container(
          child: (checkStatus)
              ? CircularProgressIndicator()
              : ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    int th = int.parse(
                        data[index]["themp"].toString().substring(0, 3));
                    Color colorCheck = Colors.blue;
                    if (th >= 35) {
                      colorCheck = Colors.red;
                    } else if (th >= 30) {
                      colorCheck = Colors.orange;
                    } else if (th >= 25) {
                      colorCheck = Colors.yellow;
                    } else if (th >= 20) {
                      colorCheck = Colors.lightGreenAccent;
                    } else if (th >= 15) {
                      colorCheck = Colors.green;
                    } else {
                      colorCheck = Colors.lightBlue;
                    }
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: colorCheck,
                        child: Text(
                          data[index]["themp"],
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                      title: Text(data[index]["location"].toString()),
                      subtitle: Text(data[index]["weather"].toString()),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
