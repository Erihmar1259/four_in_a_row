import 'dart:math';
import 'package:four_in_a_row/constants/image_const.dart';

class Coordinate {
  final int col;
  final int row;

  Coordinate(this.col, this.row);
}

abstract class Cpu {
  final String image;
  final Random _random = Random(DateTime.now().millisecond);

  Cpu(this.image);

  String get otherPlayer => image == greenImg ? yellowImg : greenImg;

  Future<int> chooseCol(List<List<int>> board);
}

// class DumbCpu extends Cpu {
//   DumbCpu(String player) : super(player);
//
//   @override
//   Future<int> chooseCol(List<List<int>> board) async {
//     await Future.delayed(Duration(seconds: _random.nextInt(2)));
//     int col;
//     do {
//       col = _random.nextInt(7);
//     } while (_getColumnTarget(board, col) == -1);
//     return col;
//   }
//
//   int _getColumnTarget(List<List<int>> board, int col) {
//     for (int row = 5; row >= 0; row--) {
//       if (board[row][col] == 0) {
//         return row;
//       }
//     }
//     return -1;
//   }
//
//   @override
//   String toString() => 'DUMB CPU';
// }
class DumbCpu extends Cpu {
  DumbCpu(String player) : super(player);

  @override
  Future<int> chooseCol(List<List<int>> board) async {
    await Future.delayed(Duration(seconds: _random.nextInt(2)));
    List<int> possibleCols = [];
    for (int col = 0; col < 7; col++) {
      if (_getColumnTarget(board, col) != -1) {
        possibleCols.add(col);
      }
    }
    possibleCols.shuffle(); // Add randomness
    return possibleCols.isNotEmpty ? possibleCols.first : -1;
  }

  int _getColumnTarget(List<List<int>> board, int col) {
    for (int row = 5; row >= 0; row--) {
      if (board[row][col] == 0) {
        return row;
      }
    }
    return -1;
  }

  @override
  String toString() => 'DUMB CPU';
}


class HarderCpu extends Cpu {
  // HarderCpu(String player) : super(player);
  //
  // @override
  // Future<int> chooseCol(List<List<int>> board) async {
  //   final List<double> scores = List.filled(7, 0);
  //   await Future.delayed(Duration(seconds: 1 + _random.nextInt(2)));
  //   return _compute(board, 0, 1, scores);
  // }
  //
  // int _compute(List<List<int>> board, int step, int deepness, List<double> scores) {
  //   for (var i = 0; i < 7; ++i) {
  //     final boardCopy = _cloneBoard(board);
  //     final target = _getColumnTarget(boardCopy, i);
  //     if (target == -1) {
  //       scores[i] = double.nan;
  //       continue;
  //     }
  //
  //     final coordinate = Coordinate(i, target);
  //     _setBox(boardCopy, coordinate, image);
  //     if (_checkWinner(boardCopy, coordinate, image)) {
  //       scores[i] += deepness / (step + 1);
  //       continue;
  //     }
  //
  //     for (var j = 0; j < 7; ++j) {
  //       final target = _getColumnTarget(boardCopy, j);
  //       if (target == -1) {
  //         continue;
  //       }
  //
  //       final coordinate = Coordinate(j, target);
  //       _setBox(boardCopy, coordinate, otherPlayer);
  //       if (_checkWinner(boardCopy, coordinate, otherPlayer)) {
  //         scores[i] -= deepness / (step + 1);
  //         continue;
  //       }
  //
  //       if (step + 1 < deepness) {
  //         _compute(boardCopy, step + 1, deepness, scores);
  //       }
  //     }
  //   }
  //
  //   return _getBestScoreIndex(scores);
  // }
  HarderCpu(String player) : super(player);

  @override
  Future<int> chooseCol(List<List<int>> board) async {
    final List<double> scores = List.filled(7, 0);
    await Future.delayed(Duration(seconds: 1 + _random.nextInt(2)));
    List<int> possibleCols = List.generate(7, (index) => index);
    possibleCols.shuffle(); // Add randomness
    return _compute(board, 0, 1, scores, possibleCols);
  }

  int _compute(List<List<int>> board, int step, int deepness, List<double> scores, List<int> possibleCols) {
    for (var i in possibleCols) {
      final boardCopy = _cloneBoard(board);
      final target = _getColumnTarget(boardCopy, i);
      if (target == -1) {
        scores[i] = double.nan;
        continue;
      }

      final coordinate = Coordinate(i, target);
      _setBox(boardCopy, coordinate, image);
      if (_checkWinner(boardCopy, coordinate, image)) {
        scores[i] += deepness / (step + 1);
        continue;
      }

      for (var j in possibleCols) {
        final target = _getColumnTarget(boardCopy, j);
        if (target == -1) {
          continue;
        }

        final coordinate = Coordinate(j, target);
        _setBox(boardCopy, coordinate, otherPlayer);
        if (_checkWinner(boardCopy, coordinate, otherPlayer)) {
          scores[i] -= deepness / (step + 1);
          continue;
        }

        if (step + 1 < deepness) {
          _compute(boardCopy, step + 1, deepness, scores, possibleCols);
        }
      }
    }

    return _getBestScoreIndex(scores);
  }

  List<List<int>> _cloneBoard(List<List<int>> board) {
    return board.map((row) => List<int>.from(row)).toList();
  }

  int _getColumnTarget(List<List<int>> board, int col) {
    for (int row = 5; row >= 0; row--) {
      if (board[row][col] == 0) {
        return row;
      }
    }
    return -1;
  }

  void _setBox(List<List<int>> board, Coordinate coordinate, String image) {
    board[coordinate.row][coordinate.col] = image == greenImg ? 1 : 2;
  }

  bool _checkWinner(List<List<int>> board, Coordinate coordinate, String image) {
    int player = image == greenImg ? 1 : 2;
    return _checkDirection(board, coordinate, player, 1, 0) || // Horizontal
        _checkDirection(board, coordinate, player, 0, 1) || // Vertical
        _checkDirection(board, coordinate, player, 1, 1) || // Diagonal /
        _checkDirection(board, coordinate, player, 1, -1);  // Diagonal \
  }

  bool _checkDirection(List<List<int>> board, Coordinate coordinate, int player, int dRow, int dCol) {
    int count = 0;
    for (int i = -3; i <= 3; i++) {
      int r = coordinate.row + i * dRow;
      int c = coordinate.col + i * dCol;
      if (r >= 0 && r < 6 && c >= 0 && c < 7 && board[r][c] == player) {
        count++;
        if (count == 4) return true;
      } else {
        count = 0;
      }
    }
    return false;
  }

  int _getBestScoreIndex(List<double> scores) {
    int bestScoreIndex = scores.indexWhere((s) => !s.isNaN);
    scores.asMap().forEach((index, score) {
      if (!score.isNaN &&
          (score > scores[bestScoreIndex] ||
              (score == scores[bestScoreIndex] && _random.nextBool()))) {
        bestScoreIndex = index;
      }
    });
    return bestScoreIndex;
  }

  @override
  String toString() => 'HARDER CPU';
}

class HardestCpu extends HarderCpu {
  // HardestCpu(String player) : super(player);
  //
  // @override
  // Future<int> chooseCol(List<List<int>> board) async {
  //   int bestCol = -1;
  //   double bestScore = double.negativeInfinity;
  //
  //   for (int col = 0; col < 7; col++) {
  //     int row = _getColumnTarget(board, col);
  //     if (row != -1) {
  //       List<List<int>> boardCopy = _cloneBoard(board);
  //       _setBox(boardCopy, Coordinate(col, row), image);
  //       double score = _minimax(boardCopy, 4, double.negativeInfinity, double.infinity, false);
  //       if (score > bestScore) {
  //         bestScore = score;
  //         bestCol = col;
  //       }
  //     }
  //   }
  //
  //   // Ensure the chosen column is within the valid range
  //   if (bestCol < 0 || bestCol >= 7) {
  //     bestCol = 0; // Default to a valid column if out of range
  //   }
  //
  //   return bestCol;
  // }
  HardestCpu(String player) : super(player);

  @override
  Future<int> chooseCol(List<List<int>> board) async {
    int bestCol = -1;
    double bestScore = double.negativeInfinity;
    List<int> possibleCols = List.generate(7, (index) => index);
    possibleCols.shuffle(); // Add randomness

    for (int col in possibleCols) {
      int row = _getColumnTarget(board, col);
      if (row != -1) {
        List<List<int>> boardCopy = _cloneBoard(board);
        _setBox(boardCopy, Coordinate(col, row), image);
        double score = _minimax(boardCopy, 4, double.negativeInfinity, double.infinity, false);
        if (score > bestScore) {
          bestScore = score;
          bestCol = col;
        }
      }
    }

    // Ensure the chosen column is within the valid range
    if (bestCol < 0 || bestCol >= 7) {
      bestCol = 0; // Default to a valid column if out of range
    }

    return bestCol;
  }
  double _minimax(List<List<int>> board, int depth, double alpha, double beta, bool isMaximizing) {
    if (depth == 0 || _isTerminalNode(board)) {
      return _evaluateBoard(board);
    }

    if (isMaximizing) {
      double maxEval = double.negativeInfinity;
      for (int col = 0; col < 7; col++) {
        int row = _getColumnTarget(board, col);
        if (row != -1) {
          List<List<int>> boardCopy = _cloneBoard(board);
          _setBox(boardCopy, Coordinate(col, row), image);
          double eval = _minimax(boardCopy, depth - 1, alpha, beta, false);
          maxEval = max(maxEval, eval);
          alpha = max(alpha, eval);
          if (beta <= alpha) {
            break;
          }
        }
      }
      return maxEval;
    } else {
      double minEval = double.infinity;
      for (int col = 0; col < 7; col++) {
        int row = _getColumnTarget(board, col);
        if (row != -1) {
          List<List<int>> boardCopy = _cloneBoard(board);
          _setBox(boardCopy, Coordinate(col, row), otherPlayer);
          double eval = _minimax(boardCopy, depth - 1, alpha, beta, true);
          minEval = min(minEval, eval);
          beta = min(beta, eval);
          if (beta <= alpha) {
            break;
          }
        }
      }
      return minEval;
    }
  }

  bool _isTerminalNode(List<List<int>> board) {
    // Check for a win or a full board
    for (int col = 0; col < 7; col++) {
      if (_getColumnTarget(board, col) != -1) {
        return false;
      }
    }
    return true;
  }

  double _evaluateBoard(List<List<int>> board) {
    double score = 0.0;

    // Evaluate center column
    int centerCount = 0;
    for (int row = 0; row < 6; row++) {
      if (board[row][3] == (image == greenImg ? 1 : 2)) {
        centerCount++;
      }
    }
    score += centerCount * 3;

    // Evaluate horizontal lines
    for (int row = 0; row < 6; row++) {
      for (int col = 0; col < 4; col++) {
        List<int> window = board[row].sublist(col, col + 4);
        score += _evaluateWindow(window);
      }
    }

    // Evaluate vertical lines
    for (int col = 0; col < 7; col++) {
      for (int row = 0; row < 3; row++) {
        List<int> window = [
          board[row][col],
          board[row + 1][col],
          board[row + 2][col],
          board[row + 3][col]
        ];
        score += _evaluateWindow(window);
      }
    }

    // Evaluate positive diagonal lines
    for (int row = 0; row < 3; row++) {
      for (int col = 0; col < 4; col++) {
        List<int> window = [
          board[row][col],
          board[row + 1][col + 1],
          board[row + 2][col + 2],
          board[row + 3][col + 3]
        ];
        score += _evaluateWindow(window);
      }
    }

    // Evaluate negative diagonal lines
    for (int row = 3; row < 6; row++) {
      for (int col = 0; col < 4; col++) {
        List<int> window = [
          board[row][col],
          board[row - 1][col + 1],
          board[row - 2][col + 2],
          board[row - 3][col + 3]
        ];
        score += _evaluateWindow(window);
      }
    }

    return score;
  }

  double _evaluateWindow(List<int> window) {
    double score = 0.0;
    int player = image == greenImg ? 1 : 2;
    int opponent = player == 1 ? 2 : 1;

    int playerCount = window.where((cell) => cell == player).length;
    int emptyCount = window.where((cell) => cell == 0).length;
    int opponentCount = window.where((cell) => cell == opponent).length;

    if (playerCount == 4) {
      score += 100;
    } else if (playerCount == 3 && emptyCount == 1) {
      score += 5;
    } else if (playerCount == 2 && emptyCount == 2) {
      score += 2;
    }

    if (opponentCount == 3 && emptyCount == 1) {
      score -= 4;
    }

    return score;
  }
}