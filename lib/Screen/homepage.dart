import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crud1/models/classes.dart' as ima;
import 'package:crud1/widget/input.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("คนในครอบครัวของฉัน"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, InputScreen.routeName);
        },
        child: Icon(Icons.add_circle_outline_outlined),
      ),
      body: Consumer<ima.ImageFile>(
        builder: (context, imageFile, _) {
          return FutureBuilder(
            future: imageFile.fetchImage(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (imageFile.items.isEmpty) {
                  return Center(child: Text('เริ่มเพิ่มเรื่องราวของคุณ'));
                } else {
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: imageFile.items.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        print(imageFile.items[index].title);
                      },
                      child: GridTile(
                        footer: GridTileBar(
                          backgroundColor: Colors.black45,
                          title: Text(
                            imageFile.items[index].title,
                            style: TextStyle(fontSize: 18),
                          ),
                          trailing: Text(
                            imageFile.items[index].id,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.file(
                            imageFile.items[index].image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  );
                }
              }
            },
          );
        },
      ),
    );
  }
}
