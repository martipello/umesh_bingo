import 'package:flutter/material.dart';

import '../models/bingo_tile.dart' as bt;
import '../view_models/bingo_view_model.dart';
import 'bingo_tile.dart';

class BingoGrid extends StatefulWidget {

  final BingoViewModel? bingoViewModel;

  const BingoGrid({Key? key, required this.bingoViewModel}) : super(key: key);

  @override
  State<BingoGrid> createState() => _BingoGridState();
}

class _BingoGridState extends State<BingoGrid> {
  @override
  Widget build(BuildContext context) {
        return StreamBuilder<List<bt.BingoTile>>(
          stream: widget.bingoViewModel?.bingoTilesStream,
          builder: (context, snapshot) {
            final bingoTiles = snapshot.data ?? [];
            return SliverGrid.count(
              children: bingoTiles
                  .map(
                    (e) => _buildBingoTile(e),
                  )
                  .toList(),
              crossAxisCount: 3,
            );
          },
        );
  }

  Widget _buildBingoTile(
    bt.BingoTile bingoTile,
  ) {
    return BingoTile(
      bingoTile: bingoTile,
      onTap: () {
        widget.bingoViewModel?.selectBingoTile(bingoTile);
      },
    );
  }

}
