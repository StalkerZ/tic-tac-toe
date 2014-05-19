class @Board

  constructor: ->
    @board = [0...9].map -> [0...9].map -> ' '
    @block_coords = @get_blocks()
    @move_history = []
    @lines = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]

  get_in: (coord) ->
    [row, col] = coord
    @board[row][col]

  set_at: (coord, sign) ->
    [row, col] = coord
    @move_history.push coord unless sign is ' '
    @board[row][col] = sign

  set_board: (board) ->       
    @board = board

  undo: ->
    coord = @move_history.pop()
    @set_at coord, ' '

  get_blocks: ->
    @flatten(@get_block [x, y] for x in [0...3] for y in [0...3])

  get_block: (coord) ->
    [x,y] = coord
    top_left_x = (x % 3) * 3
    top_left_y = (y % 3) * 3
    block_range_x = [top_left_x...top_left_x+3]
    block_range_y = [top_left_y...top_left_y+3]
    @flatten(@cross block_range_x, block_range_y) 

  possible_moves: ->
    if @move_history.length
      block = @next_block()
      if @complete block
        non_resolved_block_coords = @flatten(@block_coords.filter (b) => not @complete b)
        non_resolved_block_coords.filter (c) => not @has_value c
      else 
        block.filter (c) => not @has_value c
    else @flatten(@cross [0...9], [0...9])

  next_block: ->
    last_move = @move_history[@move_history.length-1]
    @get_block last_move

  complete: (block) ->
    (@block_winner(@get_block_values block) isnt ' ') or (block.every (coord) => @has_value coord)   

  block_winner: (block) ->
    for [a,b,c] in @lines
      if (block[a] isnt ' ') and (block[a] is block[b]) and (block[b] is block[c])
        return block[a]
    ' '

  get_block_values: (block) ->
    (block.map (cell) => @get_in cell)

  game_over: ->
    (@get_board_winner() isnt ' ') or (@block_coords.every (block) => @complete block)

  get_board_winner: ->
    @block_winner (@block_winner(@get_block_values b) for b in @block_coords)

  blocks_won: (player) ->
    ((@block_winner(@get_block_values b) for b in @block_coords).filter (w) -> w is player).length

  corners_marked: (player) ->
    corner_coords = [0,2,3,5,6,8]
    (@flatten(@cross corner_coords,corner_coords).filter (coord) => (@get_in coord) is player).length

  has_value: (coord) ->
    (@get_in coord) isnt ' '

  get_blocked_lines: (player, opponent) ->
    blocked_player = 0
    blocked_opponent = 0
    for block_c in @block_coords
      block = @get_block_values(block_c)
      for line in @lines
        player_count = (line.filter (c) -> block[c] is player).length
        opponent_count = (line.filter (c) -> block[c] is opponent).length
        if (player_count is 2) and (opponent_count is 1)
          blocked_player += 1
        else if (player_count is 1) and (opponent_count is 2)
          blocked_opponent += 1
    [blocked_player, blocked_opponent]

  cross: (A, B) ->
    ([a,b] for a in A for b in B)

  flatten: (A) ->
    if A.length
      A.reduce (a1, a2) -> a1.concat a2  
    else 
      A