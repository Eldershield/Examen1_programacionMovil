import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Universidad App',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const MainMenu(),
    );
  }
}

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App CEUTEC'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.article),
            title: const Text('Noticias'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NewsSpace()),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.format_list_bulleted),
            title: const Text('Lista de Tareas'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TaskList()),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.attach_money),
            title: const Text('Cambio de Monedas'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CurrencyConverter()),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.music_note),
            title: const Text('Podcast'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PodcastPlayer()),
              );
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}

class NewsSpace extends StatelessWidget {
  const NewsSpace({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Noticias'),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: [
          NewsCard(
              'CIERRE DE CAMPAÑA!',
              'A PRONTO LLEGA EL DÍA 💫📢\n\nNos encontramos cerca del cierre de campaña de las Elecciones Estudiantiles periodo 2024❤️\n\nApoya a los líderes de tu carrera.🫡🙌Por que recuerda:\n"Un Líder qué produce otros líderes, multiplica sus influencias"\nJohn Maxwell.\n\nTU VOTO CUENTA ✨🚩',
              'assets/images/campana.png'),
          NewsCard(
              'Aviso Institucional',
              'Les informamos que, debido a los recientes pronósticos de clima que avizoran una mejora de condiciones para la zona, según reporte de COPECO, se reactivan las actividades académicas y administrativas presenciales el día de mañana lunes 6 de noviembre en la ciudad de San Pedro Sula. \n\nFavor estar atentos a nuestros canales oficiales de comunicación para actualización sobre las disposiciones institucionales. \nAgradecemos su comprensión.',
              'assets/images/aviso_institucional.jpg'),
        ],
      ),
    );
  }
}

class NewsCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;

  NewsCard(this.title, this.description, this.imageUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.asset(
            '$imageUrl',
          ),
          ListTile(
            title: Text(title),
            subtitle: Text(description),
          ),
        ],
      ),
    );
  }
}

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  List<TaskItem> tasks = [
    TaskItem('Ejemplo de Tarea', 'Descripción de la tarea 1'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Tareas'),
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              _deleteTasks(context);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(tasks[index].taskName),
            onDismissed: (direction) {
              setState(() {
                tasks.removeAt(index);
              });
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Tarea eliminada"),
              ));
            },
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20.0),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            child: tasks[index],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addTask(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addTask(BuildContext context) async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        String newTaskTitle = '';
        String newTaskDescription = '';

        return AlertDialog(
          title: const Text('Añadir Nueva Tarea'),
          content: Column(
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Título'),
                onChanged: (value) {
                  newTaskTitle = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Descripción'),
                onChanged: (value) {
                  newTaskDescription = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(null);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(
                    {'title': newTaskTitle, 'description': newTaskDescription});
              },
              child: const Text('Agregar'),
            ),
          ],
        );
      },
    );

    if (result != null && result['title'] != null) {
      setState(() {
        tasks.add(TaskItem(result['title'], result['description']));
      });
    }
  }

  void _deleteTasks(BuildContext context) async {
    final selectedTasks = await showDialog(
      context: context,
      builder: (BuildContext context) {
        List<bool> selectedList = List.generate(tasks.length, (index) => false);

        return AlertDialog(
          title: const Text('Eliminar Tareas'),
          content: Column(
            children: List.generate(
              tasks.length,
              (index) => CheckboxListTile(
                title: Text(tasks[index].taskName),
                value: selectedList[index],
                onChanged: (value) {
                  setState(() {
                    selectedList[index] = value ?? false;
                  });
                },
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(null);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                List<TaskItem> tasksToDelete = [];
                for (int i = 0; i < tasks.length; i++) {
                  if (selectedList[i]) {
                    tasksToDelete.add(tasks[i]);
                  }
                }
                Navigator.of(context).pop(tasksToDelete);
              },
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );

    if (selectedTasks != null && selectedTasks.isNotEmpty) {
      setState(() {
        tasks.removeWhere((task) => selectedTasks.contains(task));
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Tareas eliminadas"),
      ));
    }
  }
}

class TaskItem extends StatefulWidget {
  final String taskName;
  final String taskDescription;

  TaskItem(this.taskName, this.taskDescription);

  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.taskName),
      subtitle: Text(widget.taskDescription),
      onTap: () {
        setState(() {
          isCompleted = !isCompleted;
        });
      },
      trailing: Icon(
        isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
        color: isCompleted ? Colors.green : null,
      ),
      leading: const Icon(Icons.work),
    );
  }
}

class CurrencyConverter extends StatefulWidget {
  const CurrencyConverter({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CurrencyConverterState createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  double amount = 0.0;
  String selectedCurrency = 'Lempiras';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cambio de Monedas'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            onChanged: (value) {
              setState(() {
                amount = double.parse(value);
              });
            },
            keyboardType: TextInputType.number,
            decoration:
                InputDecoration(labelText: 'Monto en $selectedCurrency'),
          ),
          DropdownButton<String>(
            value: selectedCurrency,
            items: ['Lempiras', 'Dolares', 'Euros']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedCurrency = value!;
              });
            },
          ),
          Text('El monto en Lempiras es: ${calculateConversion()}'),
        ],
      ),
    );
  }

  double calculateConversion() {
    // Realiza la conversión según la tasa de cambio

    if (selectedCurrency == 'Lempiras') {
      return amount;
    } else if (selectedCurrency == 'Dolares') {
      return amount * 24.0;
    } else {
      return amount * 28.0;
    }
  }
}

class PodcastPlayer extends StatelessWidget {
  const PodcastPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Podcast'),
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 0,
              child: Image.asset(
                'assets/images/duolingo.png',
                width: 400.0,
                height: 400.0,
              ),
            ),
            Container(
              color: Colors.black.withOpacity(0.1),
              width: double.infinity,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 140),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shuffle,
                        size: 32.0,
                      ),
                      Icon(
                        Icons.skip_previous,
                        size: 36.0,
                      ),
                      // Icono de reproducción
                      Icon(
                        Icons.play_circle_fill,
                        size: 100.0,
                      ),
                      // Icono de avance rápido (adelante)
                      Icon(
                        Icons.skip_next,
                        size: 36.0,
                      ),
                      Icon(
                        Icons.repeat,
                        size: 32.0,
                      ),
                    ],
                  ),
                  // Texto de la descripción
                  Text(
                    "Relatos en inglés con Duolingo",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black, // Color del texto
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Mejora tu inglés y tu conocimiento del mundo angloparlante gracias a fascinantes historias de la vida real, narradas en un inglés fácil de entender y con comentarios en español para ayudarte con el contexto.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black, // Color del texto
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
