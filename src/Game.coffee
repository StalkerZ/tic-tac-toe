class Game
  self = []

  constructor: ->
    self = @
    @board = new Board()
    @player = new Player "x"
    @opponent = new Player "o"
    @auto_play = false
    @display_board()
    @start_game()

  display_board: ->
    board = document.createElement "table"
    [0...9].map ->
        row = board.insertRow -1
        [0...9].map ->
          row.appendChild(document.createElement "td")
    (document.getElementById "gameContainer").appendChild board
 
  start_game: ->
    if @auto_play then @create_computer_vs_computer() else @create_human_vs_computer()

  create_computer_vs_computer: ->
    @play_computer_vs_computer()

  create_human_vs_computer: ->
    for cell in document.getElementsByTagName "td"
      cell.onclick = -> self.play_human_vs_computer [@parentNode.rowIndex,@cellIndex]

  play_computer_vs_computer: ->
    for i in [0...81] 
      timeout = i * 200
      if (i % 2 is 0) then wait timeout, => @display_move(@player.choose_move(@board), @player.player)
      else wait timeout, => @display_move(@opponent.choose_move(@board), @opponent.player)

  play_human_vs_computer: (coord) ->
    for move in @board.possible_moves()
      if JSON.stringify(move) is JSON.stringify(coord) and (not @board.game_over())
        @display_move move, @player.player
        wait 200, => @display_move(@opponent.choose_move(@board), @opponent.player)

  display_move: (coord, sign) ->
    if coord?
      @board.set_at coord, sign
      @get_cell(coord).className = if sign is 'x' then "red" else "black"
      @highlight_possible_moves()
      if @board.game_over()
        winner = @board.get_board_winner()
        if winner is ' '
          text = "It's a tie!" 
        else if winner is 'o'
          text = "Black has won!"
        else if winner is 'x'
          text = "Red has won!"
        (document.getElementById "gameOver").innerHTML = text

  highlight_possible_moves: ->
    [0...9].map (row) =>
      [0...9].map (col) =>
        cell = @get_cell [row,col]  
        cell.className = cell.className.replace "dimmed", ""

    for move in @board.possible_moves()
      @get_cell(move).className += "dimmed"

  get_cell: (coord) ->
    [row, col] = coord
    document.getElementsByTagName("table")[0].children[0].children[row].children[col]

@start = -> new Game()

@wait = (milliseconds, func) -> setTimeout func, milliseconds
