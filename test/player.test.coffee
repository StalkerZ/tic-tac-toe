Player = require '../src/Player'
Board = require '../src/Board'

exports.PlayerTest =

  setUp: (callback) ->
    @board = new Board()
    @player = new Player("o")
    callback()

  'AI should pick a winning move': (test) ->
    test_board = [
      ['o',' ',' ',' ',' ',' ',' ',' ',' ']
      [' ',' ',' ',' ',' ',' ',' ',' ',' ']
      ['o',' ','x',' ',' ',' ',' ',' ',' ']
      [' ',' ',' ',' ',' ',' ',' ',' ',' ']
      [' ',' ',' ',' ',' ',' ',' ',' ',' ']
      [' ',' ',' ',' ',' ',' ',' ',' ',' ']
      [' ',' ',' ',' ',' ',' ','x',' ',' ']
      [' ',' ',' ',' ',' ',' ',' ',' ',' ']
      [' ',' ',' ',' ',' ',' ',' ',' ',' ']
    ]
    @board.set_board(test_board)
    @board.set_at([6, 6], 'x')

    move = @player.choose_move(@board)
    expected = [1,0]
    test.equal(true, arrayEqual(expected, move))
    test.done()

  'AI should pick a winning move 2': (test) ->
    test_board = [
      [' ',' ',' ',' ',' ',' ',' ',' ',' ']
      [' ',' ',' ',' ',' ',' ',' ',' ',' ']
      [' ',' ',' ',' ',' ',' ',' ',' ',' ']
      [' ',' ',' ',' ',' ',' ',' ',' ',' ']
      [' ',' ',' ',' ',' ',' ',' ',' ',' ']
      [' ',' ',' ',' ',' ',' ',' ',' ',' ']
      [' ',' ',' ',' ',' ',' ',' ',' ',' ']
      [' ',' ',' ',' ',' ',' ',' ','o',' ']
      [' ',' ',' ',' ',' ','x',' ','o',' ']
    ]
    @board.set_board(test_board)
    @board.set_at([8, 5], 'x')

    move = @player.choose_move(@board)
    expected = [6,7]
    test.equal(true, arrayEqual(expected, move))
    test.done()

  'AI should pick a winning move 3': (test) ->
    test_board = [
      ['o',' ',' ',' ',' ',' ','x',' ','o']
      [' ',' ',' ',' ',' ',' ','x',' ',' ']
      ['o',' ','x',' ',' ',' ',' ',' ',' ']
      ['x',' ',' ',' ',' ',' ',' ',' ',' ']
      [' ',' ',' ',' ',' ',' ',' ',' ',' ']
      [' ',' ','o',' ',' ',' ',' ',' ',' ']
      [' ',' ','x',' ',' ',' ','x',' ','o']
      [' ',' ',' ',' ',' ',' ',' ',' ',' ']
      [' ',' ',' ',' ',' ',' ',' ',' ',' ']
    ]
    @board.set_board(test_board)
    @board.set_at([3, 0], 'x')

    move = @player.choose_move(@board)
    expected = [1,0]
    test.equal(true, arrayEqual(expected, move))
    test.done()

  'AI should pick a winning move 4': (test) ->
    test_board = [
      ['x',' ','o',' ',' ',' ','x',' ',' ']
      [' ',' ',' ',' ',' ',' ',' ',' ',' ']
      ['o',' ',' ',' ',' ',' ',' ',' ',' ']
      [' ',' ',' ',' ',' ',' ',' ',' ',' ']
      [' ',' ',' ',' ',' ',' ',' ',' ',' ']
      [' ',' ',' ',' ',' ',' ',' ',' ',' ']
      ['x',' ',' ',' ',' ',' ',' ',' ',' ']
      [' ',' ',' ',' ',' ',' ',' ',' ',' ']
      [' ',' ',' ',' ',' ',' ',' ',' ',' ']
    ]
    @board.set_board(test_board)
    @board.set_at([0, 6], 'x')

    move = @player.choose_move(@board)
    expected = [1,1]
    test.equal(true, arrayEqual(expected, move))
    test.done()

  'AI should not provoke opponent to win': (test) ->
    test_board = [
      [' ',' ',' ',' ',' ',' ',' ',' ',' ']
      [' ','x',' ',' ',' ',' ',' ',' ',' ']
      [' ',' ','x',' ',' ',' ',' ',' ',' ']
      [' ',' ',' ',' ',' ',' ',' ',' ',' ']
      [' ',' ',' ',' ',' ',' ',' ',' ',' ']
      [' ',' ',' ',' ',' ',' ',' ',' ',' ']
      [' ',' ',' ',' ',' ',' ','o',' ',' ']
      [' ',' ',' ',' ',' ',' ',' ',' ',' ']
      [' ',' ',' ',' ',' ',' ',' ',' ',' ']
    ]
    @board.set_board(test_board)
    @board.set_at([1, 1], 'x')

    move = @player.choose_move(@board)
    not_expected = [3,3]
    test.equal(false, arrayEqual(not_expected, move))
    test.done()

  'AI should always choose the move that wins the game': (test) ->
    test_board = [
      [' ',' ',' ','x','x',' ',' ',' ',' ']
      [' ','o',' ',' ',' ',' ',' ',' ',' ']
      [' ','o',' ',' ',' ',' ',' ',' ',' ']
      [' ',' ',' ',' ',' ','o',' ',' ',' ']
      [' ',' ',' ',' ','o',' ',' ',' ',' ']
      [' ',' ',' ','o',' ',' ',' ',' ',' ']
      [' ',' ',' ',' ',' ',' ','o',' ',' ']
      [' ','o',' ',' ','x',' ',' ','o',' ']
      [' ','o',' ',' ',' ',' ',' ',' ','o']
    ]
    @board.set_board(test_board)
    @board.set_at([7, 4], 'x')

    move = @player.choose_move(@board)
    expected = [0,1]
    test.equal(true, arrayEqual(expected, move))
    test.done()

arrayEqual = (ar1, ar2) ->
  JSON.stringify(ar1) is JSON.stringify(ar2)

