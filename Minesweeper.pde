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
  background(0);
  if (isWon())
    displayWinningMessage();
}
public boolean isWon()
{
  for (int i =0; i< bombs.size (); i++) {
    if (bombs.get(i).isMarked() == false) {
      return false;
    }
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

  for (int i =0; i < bombs.size (); i++) {
    bombs.get(i).marked = false;
    bombs.get(i).clicked = true;
  }
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
  private float x, y, width, height;
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

  public void mousePressed () 
  {
    
    if (mouseButton == LEFT)
        {
            if (!clicked)
                clicked = true;
            if (keyPressed)
                marked = !marked;
            else if (bombs.contains(this))
                displayLosingMessage();
            else if (countBombs(r, c) > 0)
                setLabel(str(countBombs(r, c)));
            else
            {
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
        if (mouseButton == RIGHT)
        {
            if (clicked == false)
                marked = !marked;
        }
    }


  public void draw () 
  { 
     
      
   if (marked){
      fill(150);
      rect(x,y,width,height);
      fill(255,0,0);
      noStroke();
      triangle(x+15,y+6,x+15,y+22,x+33,y+14);
      stroke(120);
      strokeWeight(1.5);
      line(x+15,y+6,x+15,y+40); 
      fill(255,255,255);
        }else if( clicked && bombs.contains(this) && !marked ){ 
          displayLosingMessage();
          fill(0,255,0);
          
          stroke(0);
          fill(255,200,0);
          ellipse(x+20,y+20,30,30);
          fill(0);
          ellipse(x+14,y+15,5,5);
          ellipse(x+26,y+15,5,5);
          fill(255,255,255);
        }else if(clicked){
            fill(200);
        rect(x, y, width, height);
        }else {
        fill( 100 );
}

    text(label, x+width/2, y+height/2-1.5);
    rect(x, y, width, height);
  }
  public void setLabel(String newLabel)
  {

    label = newLabel;
  }
  public boolean isValid(int r, int c)
  {
    return (r>=0 && r<NUM_ROWS) && (c>=0 && c<NUM_COLS);
  }
  public int countBombs(int row, int col)
  {
    int numBombs = 0;
    if (isValid(r-1, c) && bombs.contains(buttons[r-1][c])) {
      numBombs++;
    }
    if (isValid(r, c-1) && bombs.contains(buttons[r][c-1])) {
      numBombs++;
    }
    if (isValid(r, c+1) && bombs.contains(buttons[r][c+1])) {
      numBombs++;
    }
    if (isValid(r-1, c-1) && bombs.contains(buttons[r-1][c-1])) {
      numBombs++;
    }
    if (isValid(r-1, c+1) && bombs.contains(buttons[r-1][c+1])) {
      numBombs++;
    }
    if (isValid(r+1, c) && bombs.contains(buttons[r+1][c])) {
      numBombs++;
    }
    if (isValid(r+1, c+1) && bombs.contains(buttons[r+1][c+1])) {
      numBombs++;
    }
    if (isValid(r+1, c-1) && bombs.contains(buttons[r+1][c-1])) {
      numBombs++;
    }
    return numBombs;
  }
 
}
