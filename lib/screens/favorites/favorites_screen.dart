import 'package:flutter/material.dart';
import 'package:my_super_cat_app/dao/cat_dao.dart';
import 'package:my_super_cat_app/models/cat.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final CatDao _catDao = CatDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: FutureBuilder<List<FavoriteCats>>(
        future: _catDao.fetchAll(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No favorites yet'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final cat = snapshot.data![index];
                return Card(
                  child: ListTile(
                    title: Text(cat.name),
                    subtitle: Text(
                        'Temperament: ${cat.temperament}\nIntelligence: ${cat.intelligence}'),
                    leading: Image.network(
                      'https://cdn2.thecatapi.com/images/${cat.img}.jpg',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        _catDao.delete(cat.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${cat.name} removed from favorites')),
                        );
                        // Optionally update UI to reflect deletion
                        setState(() {
                          snapshot.data!.removeAt(index);
                        });
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
