import 'package:flutter/material.dart';
import 'pedido_screen.dart';

class MenuScreen extends StatelessWidget {

  final List<String> menuItems = [
    'Café Americano - \$ 9.000',
    'Café Latte - \$ 12.000',
    'Capuchino - \$ 12.000',
    'Té Verde - \$ 6.700',
    'Pastel de Chocolate - \$ 8.000',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menú de Cafetería'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ingresa tu nombre:',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nombre',
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Menú:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(menuItems[index]),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PedidoScreen()),
                );
              },
              child: Text('Realizar Pedido'),
            ),
          ],
        ),
      ),
    );
  }
}
