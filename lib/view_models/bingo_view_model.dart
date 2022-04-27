import 'package:rxdart/rxdart.dart';
import 'package:umesh_bingo/extensions/iterable_extension.dart';

import '../models/bingo_tile.dart';

class BingoViewModel {
  final bingoStream = BehaviorSubject<bool>();

  final bingoTilesStream = BehaviorSubject<List<BingoTile>>.seeded(
    bingoTileList,
  );

  static List<BingoTile> get bingoTileList => <BingoTile>[
      BingoTile(
        'Correct me if i\'m wrong... (Sentence Beginning and end)',
        false,
        1,
      ),
      BingoTile(
        'Kung-Fu Umesh',
        false,
        2,
      ),
      BingoTile(
        'Leave it with me',
        false,
        3,
      ),
      BingoTile(
        'Correct me if i\'m wrong... (Sentence end)',
        false,
        4,
      ),
      BingoTile(
        'Just to confirm...',
        false,
        5,
      ),
      BingoTile(
        'Correct me if i\'m wrong... (Middle of Sentence)',
        false,
        6,
      ),
      BingoTile(
        'Confused the xxx out of me!',
        false,
        7,
      ),
      BingoTile(
        'Do you think so?',
        false,
        8,
      ),
      BingoTile(
        'Hey Martin,',
        false,
        9,
      ),
      BingoTile(
        'Correct me if i\'m wrong... (Sentence beginning)',
        false,
        10,
      ),
      BingoTile(
        'Interpretator',
        false,
        11,
      ),
      BingoTile(
        'Just so i\'m clear...',
        false,
        12,
      ),
    ];


  void selectBingoTile(BingoTile bingoTile) {
    final tiles = bingoTilesStream.value;
    if (tiles != null) {
      tiles[bingoTile.index - 1] = BingoTile(
        bingoTile.title,
        !bingoTile.isSelected,
        bingoTile.index,
      );
      bingoTilesStream.add(tiles);
      bingoStream.add(checkForBingo());
    }
  }

  bool checkForBingo() {
    final tiles = bingoTilesStream.value;
    if (tiles != null) {
      final isBingoFirstRow = tiles
          .sublist(
            0,
            3,
          )
          .all((element) => element.isSelected);

      final isBingoSecondRow = tiles
          .sublist(
            3,
            6,
          )
          .all((element) => element.isSelected);

      final isBingoThirdRow = tiles
          .sublist(
            6,
            9,
          )
          .all((element) => element.isSelected);

      final isBingoFourthRow = tiles
          .sublist(
            9,
            12,
          )
          .all((element) => element.isSelected);

      final isBingoFirstColumn = <BingoTile>[
        tiles[0],
        tiles[3],
        tiles[6],
        tiles[9],
      ].all((element) => element.isSelected);

      final isBingoSecondColumn = <BingoTile>[
        tiles[1],
        tiles[4],
        tiles[7],
        tiles[10],
      ].all((element) => element.isSelected);

      final isBingoThirdColumn = <BingoTile>[
        tiles[2],
        tiles[5],
        tiles[8],
        tiles[11],
      ].all((element) => element.isSelected);

      return isBingoFirstRow ||
          isBingoSecondRow ||
          isBingoThirdRow ||
          isBingoFourthRow ||
          isBingoFirstColumn ||
          isBingoSecondColumn ||
          isBingoThirdColumn;
    } else {
      return false;
    }
  }

  void dispose() {
    bingoTilesStream.close();
    bingoStream.close();
  }

  void reset() {
    bingoStream.add(false);
    bingoTilesStream.add(bingoTileList);
  }
}
