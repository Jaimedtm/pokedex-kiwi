import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/src/models/PokemonModel.dart';
import 'package:pokedex/src/services/DatabaseEmule.dart';

class FavoriteButton extends StatefulWidget {
  final PokemonModel pokemon;
  final Color color;
  FavoriteButton({Key key, @required this.pokemon, @required this.color})
      : super(key: key);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Color> _color;
  bool isInFavs = false;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    _color = new ColorTween(begin: Colors.grey[350], end: widget.color)
        .animate(CurvedAnimation(parent: _controller, curve: Interval(0, .5)));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final db = DatabaseEmule();
    isInFavs = db.favorites.contains(widget.pokemon);
    if (isInFavs) {
      _controller.forward();
      setState(() {});
    }
    return GestureDetector(
        onTap: () {
          if (isInFavs) {
            setState(() {
              _controller.reverse();
              db.deleteFavorite(widget.pokemon);
            });
          } else {
            setState(() {
              _controller.forward();
              db.addFavorite(widget.pokemon);
            });
          }
        },
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.white,
            ),
            height: 40,
            width: 150,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                Icon(Icons.favorite, color: _color.value),
                Text(
                  isInFavs ? 'Remove' : 'Add to Favs',
                  style: _fontStyle(color: Colors.black87, size: 14),
                )
              ],
            ),
          ),
        ));
  }

  TextStyle _fontStyle(
      {Color color = Colors.white, double size = 18, bool bold = false}) {
    return GoogleFonts.montserrat(
        color: color,
        fontSize: size,
        fontWeight: bold ? FontWeight.w500 : FontWeight.normal);
  }
}
