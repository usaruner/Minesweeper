int stop = 10;
import de.bezier.guido.*;
public final static int NUM_ROWS = 10;
public final static int NUM_COLS = 10;//Declare and initialize NUM_ROWS and NUM_COLS = 20
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs; //ArrayList of just the minesweeper buttons that are mined
public final static int NUM_BOOM = 25;
void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
     for(int r = 0; r < NUM_ROWS;r++){
       for(int c = 0; c < NUM_COLS;c++){
       buttons[r][c]  = new MSButton(r,c);
         }
       }//declare and initialize buttons
      bombs = new ArrayList();
      for (int i = 0; i<20; i ++){
    setBombs();
      }
}
public void setBombs()
{
int ran1 = (int)(Math.random()*10);
int ran2 = (int)(Math.random()*10);

      if (!bombs.contains(buttons[ran1][ran2]))
      bombs.add(buttons[ran1][ran2]);
      else 
      setBombs();
   
        
  
}

public void draw ()
{
      
       
    background( 0 );
     System.out.println(buttons[0][0].isClicked());
  
     
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    return false;
}
public void displayLosingMessage()
{
    //your code here
}
public void displayWinningMessage()
{
    //your code here
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
    
    public void mousePressed () 
    {
        clicked = true;
        if (!bombs.contains(this))
     fill(255,255,255);
     if(marked == true){
          marked = false;
if(isValid(r,c-1) && buttons[r][c-1].isMarked()== true){
            buttons[r][c-1].mousePressed();
}
if(isValid(r,c+1) && buttons[r][c+1].isMarked()== true){
            buttons[r][c+1].mousePressed();
}
if(isValid(r-1,c) && buttons[r-1][c].isMarked()== true){
            buttons[r-1][c].mousePressed();
}            
if(isValid(r+1,c) && buttons[r+1][c].isMarked()== true){
            buttons[r+1][c].mousePressed();
}            
     }
     //your code here
    }

    public void draw () 
    {    
        if (marked)
            fill(123,5,2);
         else if( clicked && bombs.contains(this) ) 
          displayLosingMessage();
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
              if(r <= 9 && r >= 0 && c <= 9 && c >= 0)
        return true;
      
        return false;
       
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 1;
        //your code here
        return numBombs;
    }
}
