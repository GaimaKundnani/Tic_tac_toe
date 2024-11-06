import 'package:flutter/material.dart';
import 'tic_tac_toe.dart';

void main() {
  runApp(TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      home: TicTacToeScreen(),
    );
  }
}

class TicTacToeScreen extends StatefulWidget {
  @override
  _TicTacToeScreenState createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeScreen> {
  TicTacToe game = TicTacToe();
  String currentPlayer = 'X'; // 'X' starts first

  void _resetGame() {
    setState(() {
      game.resetGame();
      currentPlayer = 'X';
    });
  }

  void _makeMove(int index) {
    setState(() {
      if (game.makeMove(index, currentPlayer)) {
        if (game.checkWinner() != '') {
          // Show dialog or message for winner
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text('Winner: ${game.checkWinner()}'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _resetGame();
                  },
                  child: Text('Play Again'),
                ),
              ],
            ),
          );
        } else if (game.isBoardFull()) {
          // Show draw message
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text('It\'s a draw!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _resetGame();
                  },
                  child: Text('Play Again'),
                ),
              ],
            ),
          );
        } else {
          // Switch player
          currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
      ),
      body: GridView.builder(
        itemCount: 9,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              if (game.board[index] == '' && game.checkWinner() == '') {
                _makeMove(index);
              }
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              child: Center(
                child: Text(
                  game.board[index],
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
