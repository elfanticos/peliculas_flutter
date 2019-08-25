import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;
  final Function siguientePagina;

  MovieHorizontal({@required this.peliculas, @required this.siguientePagina});

  final _pageController = new PageController( initialPage: 1,viewportFraction: 0.3);


  @override
  Widget build(BuildContext context) {
    
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if (_pageController.position.pixels >= _pageController.position.maxScrollExtent - 200) {
        siguientePagina();
      }
    });

    return Container(
      height: _screenSize.height * 0.2 + 20,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: peliculas.length,
        itemBuilder: (context, i) {
          return _tardjeta(context,peliculas[i]);
        },
      ),
    );
  }

  Widget _tardjeta(BuildContext context, Pelicula pelicula) {
    pelicula.uniqueId = '${pelicula.id}-postter';
    final tarjeta = Container(
        margin     : EdgeInsets.only(right: 15.0),
        child      : Column(
          children : <Widget>[
            Hero(
              tag   : pelicula.uniqueId,
              child : ClipRRect(
                borderRadius : BorderRadius.circular(20.0),
                child        : FadeInImage(
                  image       : NetworkImage(pelicula.getPosterImg()),
                  placeholder : AssetImage('assets/img/no-image.jpg'),
                  fit         : BoxFit.cover,
                  height      : 130.0,
                ),
              ),
            ),
            SizedBox(height: 5.0,),
            Text(
              pelicula.title,
              overflow : TextOverflow.ellipsis,
              style    : Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      );

    return GestureDetector(
      child: tarjeta,
      onTap: () {
        print('Titulo de la pelicula: ${pelicula.title}');
        Navigator.pushNamed(context, 'detalle', arguments: pelicula);
      },
    );
  }
}