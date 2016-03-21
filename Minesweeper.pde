import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 10;
public final static int NUM_COLS = 10;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs; //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
  size(400, 400);
  textAlign(CENTER, CENTER);

  

  // make the manager
  Interactive.make( this );

  //declare and initialize buttons
  buttons = new MSButton [NUM_ROWS][NUM_COLS];
  for (int i =0; i < NUM_ROWS; i++) {
    for (int j=0; j< NUM_COLS; j++) {
      buttons[i][j] = new MSButton(i, j);
    }
  }
  bombs = new ArrayList <MSButton>();
  //setting the number of bombs
  int i=0;
  while (i<10) {
    setBombs();
    i++;
  }
}

public void setBombs()
{
  int randomRow= (int)(Math.random()*10);
  int randomColumn= (int)(Math.random()*10);
  if (!bombs.contains(buttons[randomRow][randomColumn])) {
    bombs.add(buttons[randomRow][randomColumn]);
  }
}

 public void keyPressed(){
    if(key == 'r')
      setup();
  }

public void draw ()
{
background( 0 );
  if (isWon())
    displayWinningMessage();
}
public boolean isWon()
{
   for (int i = 0; i < bombs.size(); i++)
    {
        if (!bombs.get(i).isMarked())
            return false;
    }
    return true;
}
public void displayLosingMessage()
{ 
  buttons[4][1].setLabel("Y");
  buttons[4][2].setLabel("O");
  buttons[4][3].setLabel("U");
  buttons[4][4].setLabel(" ");
  buttons[4][5].setLabel("L");
  buttons[4][6].setLabel("O");
  buttons[4][7].setLabel("S");
  buttons[4][8].setLabel("E");

  
}
public void displayWinningMessage()
{

  buttons[4][2].setLabel("Y");
  buttons[4][3].setLabel("O");
  buttons[4][4].setLabel("U");
  buttons[4][5].setLabel(" ");
  buttons[4][6].setLabel("W");
  buttons[4][7].setLabel("I");
  buttons[4][8].setLabel("N");
}
public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
      public void mousePressed()
    {
        if(mouseButton == LEFT && !marked)
            clicked = true;
        if(mouseButton == RIGHT && !clicked)
            marked = !marked;
        else if(bombs.contains(this) && !marked)
            displayLosingMessage();
        else if(countBombs(r,c) > 0 && !bombs.contains(this))
            label = "" + countBombs(r,c);
        else {
                if (isValid(r, c+1) && !buttons[r][c+1].isClicked())
                    buttons[r][c+1].mousePressed();
                if (isValid(r, c-1) && !buttons[r][c-1].isClicked())
                    buttons[r][c-1].mousePressed();
                if (isValid(r-1, c) && !buttons[r-1][c].isClicked())
                    buttons[r-1][c].mousePressed();            
                if (isValid(r+1, c) && !buttons[r+1][c].isClicked())
                    buttons[r+1][c].mousePressed();
                if (isValid(r-1, c-1) && !buttons[r-1][c-1].isClicked())
                    buttons[r-1][c-1].mousePressed();
                if (isValid(r-1, c+1) && !buttons[r-1][c+1].isClicked())
                    buttons[r-1][c+1].mousePressed();
                if (isValid(r+1, c+1) && !buttons[r+1][c+1].isClicked())
                    buttons[r+1][c+1].mousePressed();
                if (isValid(r+1, c-1) && !buttons[r+1][c-1].isClicked())
                    buttons[r+1][c-1].mousePressed();
    }
    }
    public void draw () 
    {    
        if (marked){          
      fill(0);
    } else if( clicked && bombs.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        //your code here
        return r >= 0 && r < NUM_ROWS && c >= 0 && c < NUM_COLS;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        //your code here
        if (isValid(r, c+1) && bombs.contains(buttons[r][c+1]))
            numBombs++;
        if (isValid(r, c-1) && bombs.contains(buttons[r][c-1]))
            numBombs++;
        if (isValid(r+1, c) && bombs.contains(buttons[r+1][c]))
            numBombs++;
        if (isValid(r-1, c) && bombs.contains(buttons[r-1][c]))
            numBombs++;
        if (isValid(r+1, c+1) && bombs.contains(buttons[r+1][c+1]))
            numBombs++;
        if (isValid(r+1, c-1) && bombs.contains(buttons[r+1][c-1]))
            numBombs++;
        if (isValid(r-1, c+1) && bombs.contains(buttons[r-1][c+1]))
            numBombs++;
        if (isValid(r-1, c-1) && bombs.contains(buttons[r-1][c-1]))
            numBombs++;
        return numBombs;
    }
}
