parser grammar csce322a1p2;

tokens {
	BEGIN_SECTION, END_SECTION, LEVEL, SCORE, MAP, LIVES,
	WALL, FOOD, POWER, EMPTY, BORDER, GHOST, PACMAN, ASSIGNMENT,
	QUOTES, NUMBER, ROW_SEPARATOR, MAP_TERMINATOR, WHITESPACE
}

// If an error is encountered, set the corresponding element to true.
// Length of 6, so we can 1 index the array for clarity
program
locals [
	boolean[] errors = new boolean[6]
] : structure;

structure : 
	((levelSection scoreSection) | (scoreSection levelSection)) mapSection livesSection;

levelSection :
	BEGIN_SECTION LEVEL ASSIGNMENT QUOTES NUMBER {
		int n = Integer.parseInt($NUMBER.getText());
		if(n < 0 || n > 255) {
			$program::errors[4] = true;
		}
	} QUOTES END_SECTION;
	
scoreSection :
	BEGIN_SECTION SCORE ASSIGNMENT QUOTES NUMBER QUOTES END_SECTION;

mapSection :
	BEGIN_SECTION MAP ASSIGNMENT QUOTES map QUOTES END_SECTION;

livesSection :
	BEGIN_SECTION LIVES ASSIGNMENT QUOTES NUMBER {
		int n = Integer.parseInt($NUMBER.getText());
		if(n < 1 || n > 3) {
			$program::errors[5] = true;
		}
	} QUOTES END_SECTION;

// map and the variables for keeping track of various cells/other violations

map
locals [
	// Keep track of the various limited cells in the map
	int totalPacmans = 0,
	int totalGhosts = 0,
	int totalFood = 0,
	
	// Keep a count of the rows and columns in the map
	int rows = 0,
	int columns = 0,
	
	// Keep track of the current width of the map (on a particular row)
	int maxColumns = 0,
	boolean initialColumns = true
] : beginningRow pelletRow innerRow* pelletRow (endingRow {
		// If there is not exactly 1 pac man...
		if($map::totalPacmans != 1) {
			$program::errors[1] = true;
		}
		// If there are not exactly 4 ghosts...
		if($map::totalGhosts != 4) {
			$program::errors[2] = true;
		}
		// If the map is not square at the end of the map...
		if($map::rows != $columns) {
			$program::errors[3] = true;
		}
	});
	
borderRow :
	(borderPlus)* {
		// Going to next row, so increment number of rows
		$map::rows++;	
		// Get the initial number of columns
		if($map::initialColumns) {
			$map::columns = $map::maxColumns;
			$map::initialColumns = false;
		}
		// If the columns do not stay consistent between rows...
		if($map::maxColumns != $map::columns) {
			$program::errors[3] = true;
		}
		// Reset the column counter for the next pass
		$map::maxColumns = 0;
	};

// Beginning and ending rows to make the map structure easier
beginningRow :
	borderRow ROW_SEPARATOR;
		
endingRow :
	borderRow MAP_TERMINATOR;
	
innerRow :
	row ROW_SEPARATOR;		
	
pelletRow :
	borderPlus pelletCell cell* pelletCell endOfRow ROW_SEPARATOR;
	
// The one pellet cell + any overlapping with regular cells	
pelletCell :
	(POWER {$map::maxColumns++;}| bothCells);

// The two regular cells + any overlapping with corner cells
cell :
	((FOOD {$map::totalFood++;} | WALL ){$map::maxColumns++;}) | bothCells;	
	
// Overlap between both corner/regular cells
bothCells :
	(GHOST {$map::totalGhosts++;} | PACMAN {$map::totalPacmans++;} | EMPTY) {$map::maxColumns++;};

row :
	borderPlus cell* endOfRow;

borderPlus :
	(BORDER {$map::maxColumns++;});
	
endOfRow :
	(borderPlus {
		// Going to next row, so increment number of rows
		$map::rows++;
		
		// If the columns do not stay consistent between rows...
		if($map::maxColumns != $map::columns) {
			$program::errors[3] = true;
		}
		// Reset the column counter for the next pass
		$map::maxColumns = 0;
	});