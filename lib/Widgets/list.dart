import 'package:flutter/material.dart';
import 'package:data_estructure_dart/Widgets/task_management.dart';
import 'package:data_estructure_dart/Widgets/textField.dart';

class TaskList extends StatefulWidget {
  const TaskList({Key? key}) : super(key: key);

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  final titleController = TextEditingController();
  final descriptionContorller = TextEditingController();
  List<CreateTask> manageTask = [];
  @override
  void dispose() {
    titleController.dispose();
    descriptionContorller.dispose();
    super.dispose();
  }

  void clearField() {
    titleController.clear();
    descriptionContorller.clear();
    FocusScope.of(context).unfocus();
  }

  final bool check = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 30),
        child: Column(
          children: [
            Column(
              children: [
                buildTextField(controller: titleController, hint: "Título"),
                const SizedBox(
                  height: 20.0,
                ),
                buildTextField(
                    controller: descriptionContorller, hint: "Descrição"),
                const SizedBox(
                  height: 20.0,
                ),
              ],
            ),
            SizedBox(
              height: 300,
              child: SingleChildScrollView(
                child: Column(children: <Widget>[
                  ...manageTask.map(
                    (data) => CheckboxListTile(
                        title: Text(data.title),
                        subtitle: Text(data.description),
                        value: data.isChecked,
                        onChanged: (value) {
                          setState(() {
                            data.isChecked = value!;
                          });
                        }),
                  ),
                ]),
              ),
            ),
            SizedBox(
              height: 100,
              child: SingleChildScrollView(
                child: Wrap(
                  children: [
                    ...manageTask.map((e) {
                      if (e.isChecked == true) {
                        return Card(
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                "${e.title} concluido!",
                                style: const TextStyle(color: Colors.green),
                              ),
                            ));
                      }
                      return Container();
                    }).toList(),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: const EdgeInsets.all(20.0),
                      primary: Colors.red,
                    ),
                    onPressed: () {
                      setState(() {
                        manageTask.removeWhere((e) => e.isChecked == true);
                      });
                    },
                    child: const Icon(Icons.remove),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: const EdgeInsets.all(20.0),
                    ),
                    onPressed: () {
                      if (titleController.text.isEmpty &&
                          descriptionContorller.text.isEmpty) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content:
                              Text("Por favor, preencha todos os campos ;)"),
                          duration: Duration(seconds: 3),
                        ));
                      } else {
                        setState(() {
                          manageTask.add(
                            CreateTask(
                              title: titleController.text,
                              description: descriptionContorller.text,
                              isChecked: check,
                            ),
                          );
                        });
                        clearField();
                      }
                    },
                    child: const Icon(Icons.add),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
