import 'dart:async';
import 'package:flutter/material.dart';
import 'package:project/edit_note.dart';
import 'package:project/new_note.dart';
import 'package:project/sqldb.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SqlDb sqlDb = SqlDb();
  List notes = [];

  Future<List<Map>> readData() async {
    List<Map> response = await sqlDb.readData("SELECT * FROM notes ");
    notes = response;
    setState(() {});

    throw ('error');
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    await readData();
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 19, 33, 224),
          title: const Text('MY Notes'),
          centerTitle: true,
        ),
        body: notes.length == 0
            ? Container(
                margin: const EdgeInsets.only(bottom: 100),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 200,
                      height: 200,
                      child: Image.asset(
                        'img/img2.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 50),
                        child: Column(
                          children: const [
                            Text(
                              'No Notes :(',
                              style: TextStyle(
                                  fontSize: 24, color: Colors.deepPurple),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'you have no task to do',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                          ],
                        ))
                  ],
                ),
              )
            : ListView.builder(
                itemCount: notes.length,
                itemBuilder: (_, i) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                                builder: (_) => EditNote(
                                    notes[i]['title'],
                                    notes[i]['description'],
                                    notes[i]['color'],
                                    notes[i]['id'])))
                            .then(onGoBack);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 1,
                          child: Row(
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          bottomLeft: Radius.circular(15)),
                                      child: Container(
                                        height: 100,
                                        width: 10,
                                        color: notes[i]['color'] == 0
                                            ? const Color.fromARGB(
                                                255, 19, 33, 224)
                                            : notes[i]['color'] == 1
                                                ? const Color.fromARGB(
                                                    255, 247, 190, 2)
                                                : notes[i]['color'] == 2
                                                    ? const Color.fromARGB(
                                                        255, 242, 138, 129)
                                                    : notes[i]['color'] == 3
                                                        ? const Color.fromARGB(
                                                            255, 251, 244, 118)
                                                        : notes[i]['color'] == 4
                                                            ? const Color.fromARGB(
                                                                255, 205, 255, 144)
                                                            : notes[i]['color'] ==
                                                                    5
                                                                ? const Color.fromARGB(
                                                                    255,
                                                                    215,
                                                                    174,
                                                                    252)
                                                                : notes[i]['color'] ==
                                                                        6
                                                                    ? const Color.fromARGB(
                                                                        255,
                                                                        175,
                                                                        202,
                                                                        250)
                                                                    : const Color
                                                                            .fromARGB(
                                                                        255,
                                                                        230,
                                                                        201,
                                                                        169),
                                      ))
                                ],
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.only(left: 10, bottom: 10),
                                child: Column(
                                  children: [
                                    Container(
                                      width: 300,
                                      margin: EdgeInsets.only(bottom: 3),
                                      child: Text(
                                        '${notes[i]['title']}',
                                        overflow: TextOverflow.ellipsis,
                                      
                                        softWrap: true,
                                        style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 19, 33, 224),
                                            fontSize: 24,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Container(
                                      width: 300,
                                      margin: const EdgeInsets.only(top: 10),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        '${notes[i]['description']}',
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: true,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
        floatingActionButton: FloatingActionButton(
          child: Container(
            width: 60,
            height: 60,
            child: const Icon(
              Icons.add,
              size: 40,
            ),
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                    colors: [Color.fromARGB(255, 19, 33, 224), Colors.purple],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight)),
          ),
          onPressed: navigateSecondPage,
        ));
  }

  FutureOr onGoBack(dynamic value) {
    readData();
  }

  void navigateSecondPage() {
    Route route = MaterialPageRoute(builder: (context) => NewNote());
    Navigator.push(context, route).then(onGoBack);
  }
}
