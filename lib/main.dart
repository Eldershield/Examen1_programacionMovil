import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Universidad App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainMenu(),
    );
  }
}

class MainMenu extends StatelessWidget {
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
                MaterialPageRoute(builder: (context) => NewsSpace()),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Noticias'),
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

  NewsCard(this.title, this.description, this.imageUrl);

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

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Tareas'),
      ),
      body: ListView(
        children: [
          TaskItem('Tarea 1'),
          TaskItem('Tarea 2'),
        ],
      ),
    );
  }
}

class TaskItem extends StatefulWidget {
  final String taskName;

  TaskItem(this.taskName);

  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.taskName),
      onTap: () {
        setState(() {
          isCompleted = !isCompleted;
        });
      },
      trailing: Icon(
        isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
        color: isCompleted ? Colors.green : null,
      ),
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
