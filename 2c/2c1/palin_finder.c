// ==========================================================================
// Palindrome Finder
// ==========================================================================
// Prints the palindromes in an input sentence.
//
// Inf2C-CS Coursework 1. Task B 
// OUTLINE code, to be completed as part of coursework.

// Boris Grot, Rakesh Kumar
//  12 Oct 2015

//---------------------------------------------------------------------------
// C definitions for SPIM system calls
//---------------------------------------------------------------------------
#include <stdio.h>

int read_char() { return getchar(); }
void read_string(char* s, int size) { fgets(s, size, stdin); }

void print_char(int c)     { putchar(c); }   
void print_string(char* s) { printf("%s", s); }


//---------------------------------------------------------------------------
// Functions
//---------------------------------------------------------------------------

// TO BE COMPLETED

// I copied the is_delimiting_char function from the previous question.
// My palin_finder.c is mainly modified from the previous question.
int is_delimiting_char(char ch)
{
  if(ch == ' ')
    return 1;
  else if(ch == ',')
    return 1;
  else if(ch == '.')
    return 1;
  else if(ch == '!')
    return 1;
  else if(ch == '?')
    return 1;
  else if(ch == '_')
    return 1;
  else if(ch == '-')
    return 1;
  else if(ch == '(')
    return 1;
  else if(ch == ')')
    return 1;
  else if(ch == '\n')
    return 1;
  else
    return 0;
}

int cci(char c,char d) {//The compare two chars case insensitively/
  int C=c,D=d;
  if (C>='A' && C<='Z') {
    C = C+32;
  }
  if (D>='A' && D<='Z') {
    D = D+32;
  }
  return C!=D;
}

int is_palindrome(char *w,int size) {
  int z;
  char revword[20];
  for(z=0;z<size;z++){
    revword[z]=w[size-z-1];
  }
  if(size>=2){  //Shortest palindrome is at least 2 char long.
    for(z=0;z<size;z++){
      if(cci(w[z],revword[z])){//Compare with function utol(upper to lower)
        return 0;
      }
    }
    return 1;
  }else{
    return 0;
  }
}

//---------------------------------------------------------------------------
// MAIN function//---------------------------------------------------------------------------


int main (int argc, char** argv) {
  
  char input_sentence[100];  
  int i=0;
  char current_char;

  char word[20]; 
  int x, y, char_index, palin_count;

  /* Same as word_finder use an array word to temporarily store the current word
   * x,y are used for main loop.
   * char_index is used for preventing printing empty lines,
   * the palin_count is used for the case of no matches.
   */
    
  
  /////////////////////////////////////////////    
        

  
  /////////////////////////////////////////////
  
  /* Infinite loop 
   * Asks for input sentence and prints the palindromes in it
   * Terminated by user (e.g. CTRL+C)
   */

  while(1) {
    
    i=0;       
        
    print_char('\n'); 
    
    print_string("input: ");

    /* Read the input sentence. 
     * It is just a sequence of character terminated by a new line (\n) character.
     */
  
    do {           
      current_char=read_char();
      input_sentence[i]=current_char;
      i++;
    } while (current_char != '\n');
          
    /////////////////////////////////////////////     
    
       
    print_string("output:\n");          
      
    // TO BE COMPLETED 
    char_index = 0;
    palin_count = 0;
    for(x=0;x<i;x++) {
      current_char = input_sentence[x];
      if(is_delimiting_char(current_char)) {
        if(char_index > 0) {
          if(is_palindrome(word,char_index)) {  
            //I added this if condition to check the palindromes.
            word[char_index++] = '\n';
	    palin_count++;
            for(y=0;y<char_index;y++) {
              printf("%c", word[y]);  
              //I didn't quite understand why only printf can be used.
            }
	  }
          char_index = 0; //if it is not palindrome, ignore the word.
                          //change char_index to drop the word.
	}
      }
      else{
        word[char_index++] = current_char;
      }
    }
    if(palin_count == 0){
      printf("%s","No palindrome found\n");
    } // prints the string if no palindrome is found.
    /////////////////////////////////////////////
    
  }

  return 0;
}


//---------------------------------------------------------------------------
// End of file
//---------------------------------------------------------------------------
