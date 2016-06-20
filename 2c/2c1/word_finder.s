                .data
input:          .asciiz  "input: "           #//Store the strings need to be printed
output:         .asciiz  "output:\n"         
input_sentence: .space 100                   #//Allocate 100 bytes for input
word:           .space 20                    #//Allocate 20 bytes for word
                .text                        #//.globl doesn't work for me when I execute it in IDE so I put the is_delimiting_char function at the end.
                .globl main                  #// I leave it here just in case that the running from command line need it.
#/////////////////////////////////////////////                                
main:                                        #int main (void){
                la    $s0, input_sentence    # char input_sentence[100]; //Let $s0 be the input sentence
                li    $s1, 0                 # int i=0,j,k;              //Let $s1 be i,$s2 be j, $s3 be k.
                                             # char current_char         //Let $t0 be current_char since it is temporary.
                la    $s4, word              # char word[20];
                                             # int char_index, delimiting_char; //Let $s5 be char_index, $s6 be delimiting_char
                li    $v0, 4                 # print_string("input: ");
                la    $a0, input
                syscall
                                             #do{
                li    $v0, 8                 # //use syscall to read char from input
                li    $a1, 100
                la    $a0, input_sentence    # //Set buffer and length for read_string
                syscall
readchar:       lb    $t0, 0($a0)            # current_char=read_char() //Read the first byte of the input string
                sb    $t0, 0($s0)            # input_sentence[i]=current_char;
                addi  $s0, $s0, 1            # i++  //increase the i in input_sentence[i]
                addi  $a0, $a0, 1
                add   $s1, $s1, 1            #      //increase i count
                beq   $t0, 10, endreadchar   #} while (current_char != '\n');  //Stop reading when it sees a newline
                j    readchar                
endreadchar:     
     
                li    $v0, 4                 # print_string("output:\n");
                la    $a0, output
                syscall
                li    $s5, 0                 #char_index = 0
                
                add   $s3, $0, $s1           #//Decrease the immediate of $s0 (Use $s3(k) to store i temporarily)
decreaseloop:   addi  $s0, $s0, -1           
                add   $s3, $s3, -1
                bnez  $s3, decreaseloop      #//Decrease until immediate of $s0 goes back, and also makes $s3(k)=0,ready for the next loop
                
kloop:          slt   $t1, $s3, $s1          #for(k=0; k<i; k++)
                beqz  $t1, kloopend          
                add   $s3, $s3, 1            #{
                lb    $t0, 0($s0)            # current_char = input_sentence[k];
                addi  $s0, $s0, 1            #      //increase the immediate to meet k.
                add   $a0, $0, $t0           #      //put current char in a0 to be used in function is_delimiting_char
                jal   is_delimiting_char
                add   $s6, $0, $v0           # delimiting_char = is_delimiting_char(current_char);
                
                beqz  $s6, notdelimiting     # if(delimiting_char) {
                blez  $s5, donothing         #  if (char_index > 0) {
                li    $t0, 10                #   //load \n into t0 to add at end of the word
                sb    $t0, 0($s4)            #   word[char_index++] = '\n';
                add   $s5, $s5, 1            #   increase char_index while increase immediate of word
                addi  $s4, $s4, 1
                
                add   $s2, $0, $s5           #//Decrease the immediate of $s4 (Use $s2(j) to store char_index temporarily)
decreaseloop2:  addi  $s4, $s4, -1
                add   $s2, $s2, -1
                bnez  $s2, decreaseloop2     #//Decrease until immediate of $s4 goes back, and also makes $s2(j)=0,ready for the next loop
                
                li    $v0, 11                #//Get ready for printing char from word
jloop:          ble   $s5, $s2, jloopend     #   for(j=0; j<char_index; j++)  {
                lb    $a0, 0($s4)            #    print_char(word[j]);
                syscall                      
                addi  $s4, $s4, 1
                add   $s2, $s2, 1            #    //increase j in the for loop
                j     jloop
jloopend:                                    #   }

decreaseloop3:  addi  $s4, $s4, -1           #   char_index = 0;
                add   $s5, $s5, -1
                bnez  $s5, decreaseloop3     #//Decrease until immediate of $s4 goes back, and also makes char_index=0
                
donothing:      j     kloop                  #  }
notdelimiting:  sb    $t0, 0($s4)            # else {                              //Store the byte into the word
                add   $s5, $s5, 1            #  word[char_index++] = current_char; //increase char_index
                addi  $s4, $s4, 1            #                                     //increase immediate of word
                j     kloop                  # }
kloopend:                                    #}
                
main_end:       li    $v0, 10                 #return 0;
                syscall       
#/////////////////////////////////////////////              
is_delimiting_char:                          #int is_delimiting_char(char ch){    //ch in $a0
                                             #        //I found the ascii values of these characters on http://ascii.cl/
                beq   $a0, 32, ret1          #if(ch == ' ')        //Jump to ret1 if it is White space
                                             #  return 1;
                beq   $a0, 44, ret1          # else if(ch == ',')  //Jump to ret1 if it is Comma
                                             #  return 1;
                beq   $a0, 46, ret1          # else if(ch == '.')  //Jump to ret1 if it is Period
                                             #  return 1;
                beq   $a0, 33, ret1          # else if(ch == '!')  //Jump to ret1 if it is Exclamation
                                             #  return 1;
                beq   $a0, 63, ret1          # else if(ch == '?')  //Jump to ret1 if it is Question mark
                                             #  return 1;
                beq   $a0, 95, ret1          # else if(ch == '_')  //Jump to ret1 if it is Underscore
                                             #  return 1;
                beq   $a0, 45, ret1          # else if(ch == '-')  //Jump to ret1 if it is Hyphen
                                             #  return 1;
                beq   $a0, 40, ret1          # else if(ch == '(')  //Jump to ret1 if it is Opening parentheses
                                             #  return 1;
                beq   $a0, 41, ret1          # else if(ch == ')')  //Jump to ret1 if it is Closing parentheses
                                             #  return 1;                
                beq   $a0, 10, ret1          # else if(ch == '\n') //Jump to ret1 if it is Newline
                                             #  return 1;
                add   $v0, $0, 0            # else                //If it is none of above, return 0
                jr    $ra                    #  return 0;          //Return 0 in $v0
ret1:           add   $v0, $0, 1             # //If it is delimiting character then return 1
		jr    $ra                    # //Return 1 in $v0
		                             #}
