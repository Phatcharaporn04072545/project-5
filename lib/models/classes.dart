import 'dart:io';
import 'package:flutter/widgets.dart';
import 'database.dart';

class ImageItem {
  final String id;
  final String title;
  final File image;

  ImageItem({required this.image, required this.title, required this.id});
}

class ImageFile with ChangeNotifier {
  List<ImageItem> _items = [];
  List<ImageItem> get items {
    return [..._items];
  }

  Future<void> addImagePlace(String title, File image) async {
    final newImage =
        ImageItem(image: image, title: title, id: DateTime.now().toString());
    _items.add(newImage);
    notifyListeners();
    

    DataHelper.insert('user_image', {
      'id': newImage.id,
      'image': newImage.image.path,
      'title': newImage.title,
    });

    

    print('Insert complete');
  }

  ImageItem findImage(String imageId) {
    return _items.firstWhere((imageItem) => imageItem.id == imageId);
  }

  Future<void> fetchImage() async {
    final list = await DataHelper.getData('user_image');
    _items = list.map((item) {
      return ImageItem(
        image: File(item['image']),
        title: item['title'],
        id: item['id'],
      );
    }).toList();
    notifyListeners();
  }
}
