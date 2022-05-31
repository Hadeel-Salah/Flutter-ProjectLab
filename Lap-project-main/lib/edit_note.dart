import 'package:flutter/material.dart';
import 'package:project/home_page.dart';
import 'package:project/sqldb.dart';

class EditNote extends StatefulWidget {
  final title;
  final description;
  final color;
  final id;

  EditNote(this.title, this.description, this.color, this.id);

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  SqlDb sqlDb = SqlDb();
  List notes = [];
  GlobalKey<FormState> key = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  int? color;

  @override
  void initState() {
    title.text = widget.title;
    description.text = widget.description;
    color = widget.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color == 0
            ? const Color.fromARGB(255, 19, 33, 224)
            : color == 1
                ? const Color.fromARGB(255, 247, 190, 2)
                : color == 2
                    ? const Color.fromARGB(255, 242, 138, 129)
                    : color == 3
                        ? const Color.fromARGB(255, 251, 244, 118)
                        : color == 4
                            ? const Color.fromARGB(255, 205, 255, 144)
                            : color == 5
                                ? const Color.fromARGB(255, 215, 174, 252)
                                : color == 6
                                    ? const Color.fromARGB(255, 175, 202, 250)
                                    : const Color.fromARGB(255, 230, 201, 169),
        title: const Text('Edit Note'),
        actions: [
          IconButton(
              onPressed: () async {
                Future buildbottom = await buildbottomsheet(context);
              },
              icon: const Icon(Icons.more_vert)),
          IconButton(
              onPressed: () async {
                int response = await sqlDb.updateData('''
                      UPDATE notes SET 
                       title = "${title.text}" ,
                        description = "${description.text}" ,
                        color = ${color}
                         WHERE id = ${widget.id}

                        ''');
                if (response > 0) {
                  Navigator.of(context).pop();
                }
              },
              icon: const Icon(Icons.done_rounded)),
        ],
      ),
      body: Form(
        key: key,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(30, 30, 30, 2),
              child: TextFormField(
                controller: title,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Type Something...',
                    hintStyle: TextStyle(
                        fontSize: 22, color: Color.fromARGB(255, 19, 33, 224))),
                style: const TextStyle(
                    color: Color.fromARGB(255, 19, 33, 224), fontSize: 22),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                controller: description,
                decoration: const InputDecoration(
                    hintText: 'Type Something...',
                    hintStyle: TextStyle(fontSize: 18, color: Colors.grey),
                    border: InputBorder.none),
                style: const TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildbottomsheet(BuildContext context) async {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return Container(
            color: color == 0
                ? const Color.fromARGB(255, 19, 33, 224)
                : color == 1
                    ? const Color.fromARGB(255, 247, 190, 2)
                    : color == 2
                        ? const Color.fromARGB(255, 242, 138, 129)
                        : color == 3
                            ? const Color.fromARGB(255, 251, 244, 118)
                            : color == 4
                                ? const Color.fromARGB(255, 205, 255, 144)
                                : color == 5
                                    ? const Color.fromARGB(255, 215, 174, 252)
                                    : color == 6
                                        ? const Color.fromARGB(
                                            255, 175, 202, 250)
                                        : const Color.fromARGB(
                                            255, 230, 201, 169),
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Container(
              margin: const EdgeInsets.fromLTRB(20, 50, 0, 0),
              child: Column(
                children: [
                  Row1(
                    'Share with your frinds',
                    const Icon(
                      Icons.share,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 22,
                          child: IconButton(
                              onPressed: () async {
                                int count = 0;
                                int response = await sqlDb.deleteData(
                                    "DELETE FROM notes WHERE id = ${widget.id} ");
                                if (response > 0) {
                                  setState(() {});
                                  Navigator.of(context)
                                      .popUntil((_) => count++ >= 2);
                                }
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.black,
                              )),
                        ),
                      ),
                      const Text(
                        'Delete',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: () async {
                      var title = widget.title;
                      var description = widget.description;
                      var color = widget.color;

                      int response = await sqlDb.insertData('''
                          INSERT INTO notes ( title , description , color  )
                         VALUES("${title}","${description}" , "${color}")
                         ''');
                      print('response ===================');
                      if (response > 0) {
                        Navigator.of(context).pop();
                      }
                    },
                    child: Row1(
                      'Duplicade',
                      const Icon(
                        Icons.copy_rounded,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _colorPalette(),
                ],
              ),
            ),
          );
        });
  }

  Container Row1(String t, Icon i) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 22,
              child: i,
            ),
          ),
          Text(
            t,
            style: const TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }

  Widget _colorPalette() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Wrap(
          children: List<Widget>.generate(
        7,
        (index) => InkWell(
          onTap: () {
            setState(() {
              color = index;
            });
            Navigator.of(context).pop();
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: CircleAvatar(
              radius: 23,
              backgroundColor: Colors.grey,
              child: CircleAvatar(
                child: color == index
                    ? const Icon(
                        Icons.done,
                        size: 16,
                        color: Colors.black,
                      )
                    : null,
                backgroundColor: index == 0
                    ? const Color.fromARGB(255, 19, 33, 224)
                    : index == 1
                        ? const Color.fromARGB(255, 247, 190, 2)
                        : index == 2
                            ? const Color.fromARGB(255, 242, 138, 129)
                            : index == 3
                                ? const Color.fromARGB(255, 251, 244, 118)
                                : index == 4
                                    ? const Color.fromARGB(255, 205, 255, 144)
                                    : index == 5
                                        ? const Color.fromARGB(
                                            255, 215, 174, 252)
                                        : index == 6
                                            ? const Color.fromARGB(
                                                255, 175, 202, 250)
                                            : const Color.fromARGB(
                                                255, 230, 201, 169),
                radius: 22,
              ),
            ),
          ),
        ),
      )),
    );
  }
}
