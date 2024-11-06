class TicTacToe {
  List<String> board = List.filled(9, ''); // Represents the game board

  // Define winning combinations (indexes of board)
  static const List<List<int>> winCombinations = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8], // Rows
    [0, 3, 6], [1, 4, 7], [2, 5, 8], // Columns
    [0, 4, 8], [2, 4, 6]              // Diagonals
  ];

  bool isBoardFull() {
    return !board.contains('');
  }

  String checkWinner() {
    for (var combo in winCombinations) {
      if (board[combo[0]] != '' &&
          board[combo[0]] == board[combo[1]] &&
          board[combo[1]] == board[combo[2]]) {
        return board[combo[0]]; // Return 'X' or 'O' as winner
      }
    }
    return ''; // No winner yet
  }

  bool makeMove(int index, String player) {
    if (board[index] == '') {
      board[index] = player;
      return true; // Valid move
    }
    return false; // Invalid move
  }

  void resetGame() {
    board = List.filled(9, ''); // Reset the board
  }
}
