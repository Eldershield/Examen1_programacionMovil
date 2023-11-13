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
          NewsCard('Noticia 1', 'Descripción de la noticia 1',
              'assets/images/chocque.jpg'),
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
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.play_circle_fill, size: 120.0),
          Text('titulo de podcast'),
        ],
      ),
    );
  }
}
