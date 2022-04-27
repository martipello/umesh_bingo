import 'package:flutter/material.dart';
import 'package:umesh_bingo/models/bingo_tile.dart' as bt;


class BingoTile extends StatelessWidget {
  const BingoTile({
    Key? key,
    required this.bingoTile, required this.onTap,
  }) : super(key: key);

  final bt.BingoTile bingoTile;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1 / 1,
      child: Card(
        clipBehavior: Clip.hardEdge,
        elevation: bingoTile.isSelected ? 0 : 2,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: bingoTile.isSelected ? Colors.black.withOpacity(0.1) : Colors.white,
          ),
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              onTap: onTap,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    bingoTile.title,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
