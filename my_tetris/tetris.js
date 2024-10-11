function steve_tet(lowest_P, highest_x) {
    lowest_P = Math.ceil(lowest_P);
    highest_x = Math.floor(highest_x);

    return Math.floor(Math.random() * (highest_x - lowest_P + 1)) + lowest_P;
  }

  // generate a new tetris menu

  function d_menu() {
    const menu = ['I', 'J', 'L', 'O', 'S', 'T', 'Z'];

    while (menu.length) {
      const rand = steve_tet(0, menu.length - 1);
      const piece_shape= menu.splice(rand, 1)[0];
      jet_tetrimino_Menu.push(piece_shape);
    }
  }

  // get next tetris in the menu
  function jet_tetrimino() {
    if (jet_tetrimino_Menu.length === 0) {
      d_menu();
    }

    const piece_shape= jet_tetrimino_Menu.pop();
    const matrix = tetriss[piece_shape];

    // I and O start centered, all others start in left-middle
    const col = grid_box[0].length / 2 - Math.ceil(matrix[0].length / 2);

    // I starts on row 21 (-1), all others start on row 22 (-2)
    const row = piece_shape=== 'I' ? -1 : -2;

    return {
      piece_shape: piece_shape,
      matrix: matrix, 
      row: row,        
      col: col         
    };
  }

  // Rotate an KxK matrix 90deg
  function my_tet_rotation(matrix) {
    const K = matrix.length - 1;
    const res = matrix.map((row, i) =>
      row.map((val, j) => matrix[K - j][i])
    );

    return res;
  }

  // check that new matrix/row/col is valid
  function d_correctsmovement(matrix, mtxRow, mtxCol) {
    for (let row = 0; row < matrix.length; row++) {
      for (let col = 0; col < matrix[row].length; col++) {
        if (matrix[row][col] && (
            // outside the game bounds
            mtxCol + col < 0 ||
            mtxCol + col >= grid_box[0].length ||
            mtxRow + row >= grid_box.length ||
            // collides with another piece
            grid_box[mtxRow + row][mtxCol + col])
          ) {
          return false;
        }
      }
    }

    return true;
  }

  // place the tetris on the playField
  function in_placetetrimino() {
    for (let row = 0; row < tetris.matrix.length; row++) {
      for (let col = 0; col < tetris.matrix[row].length; col++) {
        if (tetris.matrix[row][col]) {

          // game over if piece has any part offscreen
          if (tetris.row + row < 0) {
            return displayGameover();
          }

          grid_box[tetris.row + row][tetris.col + col] = tetris.piece_shape;
        }
      }
    }

    // check line clears starting from the bottom and working our way up
    let droppedRows = 0;
    let lines = 0;
    for (let row = grid_box.length - 1; row >= 0; ) {
      if (grid_box[row].every(cell => !!cell)) {
        droppedRows++;
        lines++;

        // drop rows above this line
        for (let r = row; r >= 0; r--) {
          for (let c = 0; c < grid_box[r].length; c++) {
            grid_box[r][c] = grid_box[r-1][c];

          }
        }
      }
      else {
        row--;
      }

    }

    tetris = jet_tetrimino();
    if (droppedRows > 0 && lines > 0) {
        update_D_Score(droppedRows);
        dropline_updates(lines);
    }

  }

  function dropline_updates() {
    document.getElementById("dropping_line").innerHTML = d_Drop;
  }


  //Creating line/row cleared function
  function d_drop_row(){
    for (let row = grid_box.length - 1; row >= 0; ) {
      if (grid_box[row].every(cell => !!cell)) {

        // drop every row above this one
        for (let r = row; r >= 0; r--) {
          for (let c = 0; c < grid_box[r].length; c++) {
            grid_box[r][c] = grid_box[r-1][c];
          }
        }
      }
      else {
        row--;
      }

    }
  }



  function dropping_rows(){
    for (let row = grid_box.length - 1; row >= 0; ) {
      if (grid_box[row].every(cell => !!cell)) {

        // drop every row above this one
        for (let r = row; r >= 0; r--) {
          for (let c = 0; c < grid_box[r].length; c++) {
            grid_box[r][c] = grid_box[r-1][c];
          }
        }
      }
      else {
        row--;
      }
    }
  }


  let score = 0;
  let d_Drop = 0;
  function update_D_Score(droppedRows) {
    switch(droppedRows) {
        case 1:
            score += 100
            break;
        case 2:
            score += 300
            break;
        case 3:
            score += 500
            break;
        case 4:
            score += 800
            break;
        default:
            score = 0
    }

	// update score display
	const score_output = document.getElementById('score');
	score_output.innerHTML = score;

	let lines = Math.floor(score/100);
	if(lines > d_Drop){
		d_Drop = lines;
		dropline_updates();
	}
  }

  //Pause game
  let paused = false;

  function paused_playing() {
   if (!paused) {
     // pause the game
     removeInterval(dropInterval);
     paused = true;
   } else {
     // resume the game
     dropInterval = setInterval(moveDown, speed);
     paused = false;
   }
  }


  // show the game over screen
  function displayGameover() {
    cancelAnimationFrame(reqAF);
    gameOver = true;

    context.fillStyle = 'black';
    context.globalAlpha = 0.75;
    context.fillRect(0, canvas.height / 2 - 30, canvas.width, 60);

    context.globalAlpha = 1;
    context.fillStyle = 'white';
    context.font = '36px monospace';
    context.textAlign = 'center';
    context.textBaseline = 'middle';
    context.fillText("GAME OVER!", canvas.width / 2, canvas.height / 2);
  }

  const canvas = document.getElementById('newGame');
  const context = canvas.getContext('2d');
  const grid = 32;
  const jet_tetrimino_Menu = [];

  // Tetris playField is 10x20, with a few rows offscreen
  const grid_box = [];

  // populate empty state
  for (let row = -2; row < 20; row++) {
    grid_box[row] = [];

    for (let col = 0; col < 10; col++) {
      grid_box[row][col] = 0;
    }
  }

  // draw tetriss
  const tetriss = {
    'I': [
      [0,0,0,0],
      [1,1,1,1],
      [0,0,0,0],
      [0,0,0,0]
    ],
    'J': [
      [1,0,0],
      [1,1,1],
      [0,0,0],
    ],
    'L': [
      [0,0,1],
      [1,1,1],
      [0,0,0],
    ],
    'O': [
      [1,1],
      [1,1],
    ],
    'S': [
      [0,1,1],
      [1,1,0],
      [0,0,0],
    ],
    'Z': [
      [1,1,0],
      [0,1,1],
      [0,0,0],
    ],
    'T': [
      [0,1,0],
      [1,1,1],
      [0,0,0],
    ]
  };

  // tetris color
  const tetColors = {
    'I': 'cyan',
    'O': 'yellow',
    'T': 'purple',
    'S': 'green',
    'Z': 'red',
    'J': 'blue',
    'L': 'orange'
  };

  let count = 0;
  let tetris = jet_tetrimino();
  let reqAF = null;  // keep track of the animation frame so we can cancel it
  let gameOver = false;


  // game draw
  function game_draw() {
    reqAF = requestAnimationFrame(game_draw);
    context.clearRect(0,0,canvas.width,canvas.height);

    // draw the playField
    for (let row = 0; row < 20; row++) {
      for (let col = 0; col < 10; col++) {
        if (grid_box[row][col]) {
          const piece_shape= grid_box[row][col];
          context.fillStyle = tetColors[piece_shape];

          // looping 1 px smaller than the grid creates a grid effect
          context.fillRect(col * grid, row * grid, grid-1, grid-1);
        }
      }
    }

    // draw the active tetris
    if (tetris) {

      // tetris falls every 35 frames
      if (++count > 35) {
        tetris.row++;
        count = 0;

        // place piece if it runs into anything
        if (!d_correctsmovement(tetris.matrix, tetris.row, tetris.col)) {
          tetris.row--;
          in_placetetrimino();
        }
      }

      // context.fillStyle = tetColors[tetris.piece];
      context.fillStyle = tetColors[tetris.piece_shape];

      for (let row = 0; row < tetris.matrix.length; row++) {
        for (let col = 0; col < tetris.matrix[row].length; col++) {
          if (tetris.matrix[row][col]) {

            // looping 1 px smaller than the grid creates a grid effect
            context.fillRect((tetris.col + col) * grid, (tetris.row + row) * grid, grid-1, grid-1);
          }
        }
      }
    }

  }



  // listen to keyboard events to move the active tetris
  document.addEventListener('keydown', function(e) {
    if (gameOver) return;
   // if(pausePlay) return;

    // left and right arrow keys (move)
    if (e.keyCode === 37 || e.keyCode === 39 || e.keyCode === 100 || e.keyCode === 102) {
      const col = e.keyCode === 37 ? tetris.col - 1 : tetris.col + 1;

      if (d_correctsmovement(tetris.matrix, tetris.row, col)) {
        tetris.col = col;
      }
    }

    // up arrow key (playRotate)
    if (e.keyCode === 38 || e.keyCode === 65 || e.keyCode === 66) {
      const matrix = my_tet_rotation(tetris.matrix);
      if (d_correctsmovement(matrix, tetris.row, tetris.col)) {
        tetris.matrix = matrix;
      }
    }

    // down arrow key (drop)
    if(e.keyCode === 40 || e.keyCode === 98) {
      const row = tetris.row + 1;

      if (!d_correctsmovement(tetris.matrix, row, tetris.col)) {
        tetris.row = row - 1;

        in_placetetrimino();
        return;
      }

      tetris.row = row;
    }

    // spacebar key (Hard drop)
    if(e.keyCode === 32 || e.keyCode === 104) {
      while(d_correctsmovement){
        const row = tetris.row + 1;
        if (!d_correctsmovement(tetris.matrix, row, tetris.col)) {
          tetris.row = row - 1;

          in_placetetrimino();
          return;
        }

        tetris.row = row;
      }

    }

  });

  window.addEventListener("DOMContentLoaded", function(e){
    const audio = document.querySelector("audio");
    audio.volume = 0.2;
    audio.play();
  });

  function my_music_Stop(){
    let audio = new Audio('Spook.mp3');
    if(audio.paused){
      // audio.currentTime = 0;
      audio.play();
    }else{
      audio.pause();
    }
  }

  // start the game
  reqAF = requestAnimationFrame(game_draw);
  my_music_Stop();


  function next_move(){
    if(!paused){
      gameStarted();
    }
  }

  //stop the game
  function the_endGame(){

    let gameOver = true;
    displayGameover();
    my_music_Stop();
    //return;
  }

  //button used to stop the game.
  let btnStop = document.getElementById('btnStop');
    btnStop.addEventListener('click', event =>{
    the_endGame();
  });
