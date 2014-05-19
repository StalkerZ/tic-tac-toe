Board = require '../src/Board'

exports.BoardTest =

  setUp: (callback) ->
    @board = new Board()
    callback()

  'Created board should have 81 cells and be filled with empty values': (test) ->
    new_board = [
      [' ',' ',' ',' ',' ',' ',' ',' ',' ']
      [' ',' ',' ',' ',' ',' ',' ',' ',' ']
      [' ',' ',' ',' ',' ',' ',' ',' ',' ']
      [' ',' ',' ',' ',' ',' ',' ',' ',' ']
      [' ',' ',' ',' ',' ',' ',' ',' ',' ']
      [' ',' ',' ',' ',' ',' ',' ',' ',' ']
      [' ',' ',' ',' ',' ',' ',' ',' ',' ']
      [' ',' ',' ',' ',' ',' ',' ',' ',' ']
      [' ',' ',' ',' ',' ',' ',' ',' ',' ']
    ]

    test.equal(true, arrayEqual(@board.board, new_board))
    test.done()

  'Board should report amount of blocks won by player': (test) ->
    test_board = [
      ['x',' ',' ',' ','x','x','x',' ','o']
      ['o','x',' ','o','o','o',' ','o',' ']
      ['o',' ','x','x','x',' ','o','x',' ']
      ['o',' ',' ',' ',' ',' ',' ',' ',' ']
      [' ','o','o','x','x','x',' ',' ',' ']
      ['o',' ','x',' ',' ',' ',' ',' ',' ']
      [' ','x',' ',' ','o',' ','o',' ',' ']
      ['x','x','x','x',' ',' ','x','x','x']
      [' ','x',' ',' ',' ',' ',' ',' ',' ']
    ]
    @board.set_board(test_board)
    test.equal(4, @board.blocks_won('x'))
    test.done()

  'Board should report empty coords in the next block as possible moves': (test) ->
    test_board = [
      ['x',' ',' ',' ','x','x','x',' ','o']
      ['o','x',' ','o','o','o',' ','o',' ']
      ['o',' ','x','x','x',' ','o','x',' ']
      ['o',' ',' ',' ',' ',' ',' ',' ',' ']
      [' ','o','o','x','x','x',' ',' ',' ']
      ['o',' ','x',' ',' ',' ',' ',' ',' ']
      [' ','x',' ',' ','o',' ','o',' ',' ']
      ['x','x','x','x',' ',' ','x','x','x']
      [' ','x',' ',' ',' ',' ',' ',' ',' ']
    ]
    @board.set_board(test_board)
    @board.set_at([2, 4], 'x')

    expected = [[6,3], [8,3], [7,4], [8,4], [6,5], [7,5], [8,5]]
    test.equal(true, arrayEqual(expected, @board.possible_moves()))
    test.done()

  'Board should report empty coords as possible moves for all the non resolved blocks if the next block is resolved': (test) ->
    test_board = [
      ['x',' ',' ',' ','x','x','x',' ','o']
      ['o','x',' ','o','o','o',' ','o',' ']
      ['o',' ','x','x','x',' ','o','x',' ']
      ['o',' ',' ',' ',' ',' ',' ',' ',' ']
      [' ','o','o','x','x','x',' ',' ',' ']
      ['o',' ','x',' ',' ',' ',' ',' ',' ']
      [' ','x',' ',' ','o',' ','o',' ',' ']
      ['x','x','x','x',' ',' ','x','x','x']
      [' ','x',' ',' ',' ',' ',' ',' ',' ']
    ]
    @board.set_board(test_board)
    @board.set_at([2, 2], 'x')

    expected = [[4, 0], [3, 1], [5, 1], [3, 2], [6, 3], [8, 3], [7, 4], [8, 4], [6, 5], [7, 5], [8, 5], [3, 6], [4, 6], [5, 6], [3, 7], [4, 7], [5, 7], [3, 8], [4, 8], [5, 8]]
    test.equal(true, arrayEqual(expected, @board.possible_moves()))
    test.done()

arrayEqual = (ar1, ar2) ->
  JSON.stringify(ar1) is JSON.stringify(ar2)


