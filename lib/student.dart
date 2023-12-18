import 'package:flutter_app/try/trrrrrrrry.dart';
import 'package:flutter/material.dart';
import 'second_page.dart';
void main() {
  runApp(MaterialApp(
    title: 'Hello flutter',
    home: HomePage(),
  ));
}

/// Represents Homepage for Navigation
class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  //final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: const Color(0xff2B475E),
        title: const Text('STUDNET'),
        foregroundColor: Colors.white,

        actions: <Widget>[
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.notifications_outlined)),

        ],
      ),
      drawer: const NavigationDrawer(children: [
        NavigationDrawerDestination(
            icon: Icon(Icons.home), label: Text('Home')),
        NavigationDrawerDestination(
            icon: Icon(Icons.notifications), label: Text('Notification')),
        NavigationDrawerDestination(
            icon: Icon(Icons.settings), label: Text('Settings')),
      ]),
      body: GridView.count(
        // primary: false,
        padding: const EdgeInsets.all(10),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Institution()),
              );
              // Write your code here
            },
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(18),
                ),
                color: Color.fromRGBO(230, 57, 70, 0.9),
              ),
              padding: const EdgeInsets.all(8),
              // color: Colors.teal[100],
              child: Center(
                child: const Text(
                  "DBMS",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Cost()),
              );
              // Write your code here
            },
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(18),
                ),
                color: Color.fromRGBO(8, 218, 220, 0.9),
              ),
              padding: const EdgeInsets.all(8),
              // color: Colors.teal[100],
              child: Center(
                child: const Text("COST"),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Accounting()),
              );
              // Write your code here
            },
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(18),
                ),
                color: Color.fromRGBO(20, 33, 65, 0.95),
              ),
              padding: const EdgeInsets.all(8),
              // color: Colors.teal[100],
              child: Center(
                child: const Text(
                  "ACCOUNTING",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Audit()),
              );
              // Write your code here
            },
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(18),
                ),
                color: Colors.black,
              ),
              padding: const EdgeInsets.all(8),
              // color: Colors.teal[100],
              child: Center(
                child: const Text(
                  "AUDIT",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AdLearn()),
              );
              // Write your code here
            },
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(18),
                ),
                color: Colors.lightGreenAccent,
              ),
              padding: const EdgeInsets.all(8),
              // color: Colors.teal[100],
              child: Center(
                child: const Text(
                  "SAD II",
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Aboutme()),
              );
              // Write your code here
            },
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(18),
                ),
                color: Color.fromRGBO(252, 163, 17, 1),
              ),
              padding: const EdgeInsets.all(8),
              // color: Colors.teal[100],
              child: Center(
                child: const Text(
                  "About Me",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Institution extends StatelessWidget {
  const Institution({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('DataBase'),
      ),
      body: GridView.count(
        // primary: false,
        padding: const EdgeInsets.all(12),
        childAspectRatio: (20 / 10),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 1,
        children: <Widget>[
          InkWell(
            onTap: () {
              // print("clicked 1");
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FilesPage()),
              );
              // Write your code here
            },
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(18),
                ),
                color: Colors.orange,
              ),
              padding: const EdgeInsets.all(8),
              // color: Colors.teal[100],
              child: Center(
                child: const Text("Unit 1"),
              ),
            ),
          ),
          /* Button 2*/
          InkWell(
            onTap: () {
              //print("2");
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const r4()),
              );
              // Write your code here
            },
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(18),
                ),
                color: Colors.greenAccent,
              ),
              padding: const EdgeInsets.all(8),
              // color: Colors.teal[100],
              child: Center(
                child: const Text("Unit 2"),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              //print("clicked 3");
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const r3()),
              );
              // Write your code here
            },
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(18),
                ),
                color: Colors.redAccent,
              ),
              padding: const EdgeInsets.all(8),
              // color: Colors.teal[100],
              child: Center(
                child: const Text("Unit 3"),
              ),
            ),
          ),
        ],
      ),
    );
    //);
  }
}

/* ----------------------------------------------------------------COST---------------------------------------------------*/

class Cost extends StatelessWidget {
  const Cost({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('COST'),
      ),
      body: GridView.count(
        // primary: false,
        padding: const EdgeInsets.all(12),
        childAspectRatio: (20 / 10),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 1,
        children: <Widget>[
          InkWell(
            onTap: () {
              print("clicked 1");
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const n1()),
              );
              // Write your code here
            },
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(18),
                ),
                color: Colors.deepPurpleAccent,
              ),
              padding: const EdgeInsets.all(8),
              // color: Colors.teal[100],
              child: Center(
                child: const Text("Unit 1"),
              ),
            ),
          ),
          /* Button 2*/
          InkWell(
            onTap: () {
              print("2");
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const n2()),
              );
              // Write your code here
            },
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(18),
                ),
                color: Colors.greenAccent,
              ),
              padding: const EdgeInsets.all(8),
              // color: Colors.teal[100],
              child: Center(
                child: const Text("Unit 2"),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              print("clicked 3");
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const n3()),
              );
              // Write your code here
            },
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(18),
                ),
                color: Colors.redAccent,
              ),
              padding: const EdgeInsets.all(8),
              // color: Colors.teal[100],
              child: Center(
                child: const Text("Unit 3"),
              ),
            ),
          ),
        ],
      ),
    );
    //);
  }
}
/*---------------------------------------------------------------ACCOUNTING---------------------------------------*/

class Accounting extends StatelessWidget {
  const Accounting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ACCOUNTING'),
      ),
      body: GridView.count(
        // primary: false,
        padding: const EdgeInsets.all(12),
        childAspectRatio: (20 / 10),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 1,
        children: <Widget>[
          InkWell(
            onTap: () {
              print("clicked 1");
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SE1()),
              );
              // Write your code here
            },
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(18),
                ),
                color: Colors.amber,
              ),
              padding: const EdgeInsets.all(8),
              // color: Colors.teal[100],
              child: Center(
                child: const Text("Unit 1"),
              ),
            ),
          ),
          /* Button 2*/
          InkWell(
            onTap: () {
              print("2");
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SE2()),
              );
              // Write your code here
            },
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(18),
                ),
                color: Colors.greenAccent,
              ),
              padding: const EdgeInsets.all(8),
              // color: Colors.teal[100],
              child: Center(
                child: const Text("Unit 2"),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              print("clicked 3");
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SE3()),
              );
              // Write your code here
            },
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(18),
                ),
                color: Colors.purpleAccent,
              ),
              padding: const EdgeInsets.all(8),
              // color: Colors.teal[100],
              child: Center(
                child: const Text("Unit 3"),
              ),
            ),
          ),
        ],
      ),
    );
    //);
  }
}

/*---------------------------------------------------------------AUDIT--------------------------------------- */

class Audit extends StatelessWidget {
  const Audit({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AUDIT'),
      ),
      body: GridView.count(
        // primary: false,
        padding: const EdgeInsets.all(12),
        childAspectRatio: (20 / 10),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 1,
        children: <Widget>[
          InkWell(
            onTap: () {
              print("clicked 1");
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PHP1()),
              );
              // Write your code here
            },
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(18),
                ),
                color: Colors.teal,
              ),
              padding: const EdgeInsets.all(8),
              // color: Colors.teal[100],
              child: Center(
                child: const Text("Unit 1"),
              ),
            ),
          ),
          /* Button 2*/
          InkWell(
            onTap: () {
              print("2");
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PHP2()),
              );
              // Write your code here
            },
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(18),
                ),
                color: Colors.yellow,
              ),
              padding: const EdgeInsets.all(8),
              // color: Colors.teal[100],
              child: Center(
                child: const Text("Unit 2"),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              print("clicked 3");
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PHP3()),
              );
              // Write your code here
            },
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(18),
                ),
                color: Colors.redAccent,
              ),
              padding: const EdgeInsets.all(8),
              // color: Colors.teal[100],
              child: Center(
                child: const Text("Unit 3"),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              print("clicked 3");
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PHP3()),
              );
              // Write your code here
            },
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(18),
                ),
                color: Colors.lightBlue,
              ),
              padding: const EdgeInsets.all(8),
              // color: Colors.teal[100],
              child: Center(
                child: const Text("Unit 4"),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              print("clicked 3");
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PHP4()),
              );
              // Write your code here
            },
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(18),
                ),
                color: Colors.purpleAccent,
              ),
              padding: const EdgeInsets.all(8),
              // color: Colors.teal[100],
              child: Center(
                child: const Text("Unit 5"),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
