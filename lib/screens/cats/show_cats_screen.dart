import 'package:flutter/material.dart';
import 'package:my_super_cat_app/dao/cat_dao.dart';
import 'package:my_super_cat_app/models/cat.dart';
import 'package:my_super_cat_app/services/cats_service.dart';

class ShowCatsScreen extends StatefulWidget {
  const ShowCatsScreen({super.key});

  @override
  State<ShowCatsScreen> createState() => _ShowCatsScreenState();
}

class _ShowCatsScreenState extends State<ShowCatsScreen> {
  final catService = CatsService();
  final catDao = CatDao();
  List<Cat> cats = [];
  String randomCatImgUrl = '';

  @override
  void initState() {
    super.initState();
    _loadRandomCatImage();
  }

  Future<void> _loadRandomCatImage() async {
    final url = await catService.getRandomCatImg();
    setState(() {
      randomCatImgUrl = url;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          if (randomCatImgUrl.isNotEmpty) 
            Image.network(
              randomCatImgUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          Expanded(
            child: FutureBuilder<List<Cat>>(
              future: catService.getCats(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (snapshot.hasData) {
                  cats = snapshot.data!;
                }

                return ListView.builder(
                  itemCount: cats.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(cats[index].name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            Text('Origin: ${cats[index].origin}'),
                            Text('Intelligence: ${cats[index].intelligence}'),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.favorite
                          ),
                          onPressed: () async {
                            bool isFavorite = await catDao.isFavorite(cats[index].id);
                            if (!isFavorite) {
                              await catDao.insert(cats[index]);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('${cats[index].name} added to favorites')),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('${cats[index].name} is already in favorites')),
                              );
                            }
                          },
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CatDetails(cat: cats[index]),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CatDetails extends StatelessWidget {
  final Cat cat;

  const CatDetails({super.key, required this.cat});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(cat.name),
      ),
      body: Column(
        children: [
          Image.network(
            'https://cdn2.thecatapi.com/images/${cat.img}.jpg',
            height: 200,
            width: 200,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(cat.description),
          ),
          Slider(
            value: cat.energyLevel.toDouble(),
            min: 0,
            max: 5,
            divisions: 5,
            label: cat.energyLevel.toString(),
            onChanged: (double value) {},
          ),
        ],
      ),
    );
  }
}
