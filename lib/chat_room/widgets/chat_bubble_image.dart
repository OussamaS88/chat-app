import 'package:flutter/material.dart';

class Img extends StatelessWidget {
  final String imgUrl;
  const Img({Key? key, required this.imgUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final image = Image.network(
      imgUrl,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
    );
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return DetailScreen(
            image: image,
          );
        }));
      },
      child: Hero(
        tag: 'imageHero',
        child: image,
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final Image image;
  const DetailScreen({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: image,
          ),
        ),
      ),
    );
  }
}
