#  //Same as palin_finder.c, it is also modified from my word_finder.s
                .data
input:          .asciiz  "input: "           #//Store the strings need to be printed
output:         .asciiz  "output:\n"         
newline:        .asciiz  "\n"
nopalin:        .asciiz  "No palindrome found\n"
input_sentence: .space 100                   #//Allocate 100 bytes for input
word:           .space 20                    #//Allocate 20 bytes for word
revword:        .space 20                    #//Allocate space for storing the reversed word
                .text                        #//.globl doesn't work for me when I execute it in IDE so I put the is_delimiting_char function at the end.
                .globl main                  #// I leave it here just in case that the running from command line need it.
#/////////////////////////////////////////////                
main:                                        #int main (int argc, char** argv) {
                la    $s0, input_sentence    # char input_sentence[100];          //Let $s0 be the input sentence
                li    $s1, 0                 # int i=0;                           //Let $s1 be i.
                                             # char current_char                  //Let $t0 be current_char since it is temporary.
                la    $s4, word              # char word[20];                     //Let $s2,$s3 be y,x
                                             # int x, y, char_index, palin_count; //Let $s5 be char_index, $s6 be palin_count
                                             # //The original $s6, delimiting_char is not stored, but directly used in $v0
                                             # //and for the revword used later in is_palindrome let revword be $s7
                                             # //for the z used later, I use $s2 as z, since the value of y doesn't matter during the is_palin function                                
infloop:                                     #while(1) {
                li    $s1, 0                 # i=0;              
                li    $v0, 4                 # print_char('\n'); //printing the char '\n' is equivalent to printing string "\n"
                la    $a0, newline
                syscall              
                li    $v0, 4                 # print_string("input: ");
                la    $a0, input
                syscall
                                             #do{
                li    $v0, 8                 # //use syscall to read char from input
                li    $a1, 100
                la    $a0, input_sentence    # //Set buffer and length for read_string
                syscall
readchar:       lb    $t0, 0($a0)            # current_char=read_char()
                sb    $t0, 0($s0)            # input_sentence[i]=current_char;
                addi  $s0, $s0, 1            # i++  //increase the i in input_sentence[i]
                addi  $a0, $a0, 1
                add   $s1, $s1, 1            #      //increase i count
                beq   $t0, 10, endreadchar   #} while (current_char != '\n');  //Stop reading when it sees a newline
                j     readchar                
endreadchar:   
                li    $v0, 4                 # print_string("output:\n");
                la    $a0, output
                syscall
                li    $s5, 0                 #char_index = 0
                li    $s6, 0                 #palin_count = 0

                add   $s3, $0, $s1           #//Decrease the immediate of $s0 (Use $s3(k) to store i temporarily)
decreaseloop:   addi  $s0, $s0, -1           
                add   $s3, $s3, -1
                bnez  $s3, decreaseloop      #//Decrease until immediate of $s0 goes back, and also makes $s3(x)=0,ready for the next loop
                
xloop:          slt   $t1, $s3, $s1          #for(x=0;x<i;x++) {
                beqz  $t1, xloopend          
                add   $s3, $s3, 1            
                lb    $t0, 0($s0)            # current_char = input_sentence[x];
                addi  $s0, $s0, 1            #      //increase the immediate to meet x.
                
                add   $a0, $0, $t0           #      //put current char in a0 to be used in function is_delimiting_char
                jal   is_delimiting_char
                beqz  $v0, notdelimiting     # if(is_delimiting_char(current_char)) {
                blez  $s5, donothing         #  if (char_index > 0) {
                jal   is_palindrome          
                beqz  $v0, jloopend     #   if(is_palindrome(word,char_index)) {  
                li    $t0, 10                #   //load \n into t0 to add at end of the word
                sb    $t0, 0($s4)            #   word[char_index++] = '\n';
                add   $s5, $s5, 1            #   increase char_index while increase immediate of word
                addi  $s4, $s4, 1
                add   $s6, $s6, 1            #   palin_count++;
                
                add   $s2, $0, $s5           #//Decrease the immediate of $s4 (Use $s2(y) to store char_index temporarily)
decreaseloop2:  addi  $s4, $s4, -1
                add   $s2, $s2, -1
                bnez  $s2, decreaseloop2     #//Decrease until immediate of $s4 goes back, and also makes $s2(y)=0,ready for the next loop of printing
                
                li    $v0, 11                #//Get ready for printing char from word
jloop:          ble   $s5, $s2, jloopend     #   for(y=0;y<char_index;y++) {
                lb    $a0, 0($s4)            #    printf("%c", word[y]);
                syscall                      
                addi  $s4, $s4, 1
                add   $s2, $s2, 1            #    //increase j in the for loop
                j     jloop
jloopend:                                    #    }
                                             #   }
                addi  $s4, $s4, -1           #   char_index = 0;
                add   $s5, $s5, -1
                bnez  $s5, jloopend          #//Decrease until immediate of $s4 goes back, and also makes char_index=0
                
donothing:      j     xloop                  # }
notdelimiting:  sb    $t0, 0($s4)            # else {                              //Store the byte into the word
                add   $s5, $s5, 1            #  word[char_index++] = current_char; //increase char_index
                addi  $s4, $s4, 1            #                                     //increase immediate of word
                j     xloop                  # }
xloopend:                                    #}
                bnez  $s6, foundpalin        #if(palin_count == 0){
                li    $v0, 4                 # printf("%s","No palindrome found\n");
                la    $a0, nopalin
                syscall
foundpalin:                                  #}

decreaseloops0: addi  $s0, $s0, -1           #Set the immediate of s0 and i to zero
                add   $s1, $s1, -1
                bnez  $s1, decreaseloops0 
                
                j     infloop                #           //The program itself have a infinite loop.
main_end:       li    $v0, 10                #return 0;  // i didn't remove the return 0 to keep correspondence
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
                add   $v0, $0, 0             # else                //If it is none of above, return 0
                jr    $ra                    #  return 0;          //Return 0 in $v0
ret1:           add   $v0, $0, 1             # //If it is delimiting character then return 1
		jr    $ra                    # //Return 1 in $v0
		                             #}
#/////////////////////////////////////////////
cci:                                         #int cci(char c,char d) { //compare c and d, return 0 if c==d, c,d is $a1,$a2
                add   $t1, $a1, $0           #int C=c,D=d;             //Use $t1,$t2 to store C,D
                add   $t2, $a2, $0
                blt   $t1, 65, cnu           # if (C>='A' && C<='Z') {
                bgt   $t1, 90, cnu
                add   $t1, $t1, 32           #  C = C+32;}
cnu:            blt   $t2, 65, dnu           # if (D>='A' && D<='Z') {
                bgt   $t2, 90, dnu
                add   $t2, $t2, 32           #  D = D+32;}
dnu:            beq   $t1, $t2, same         # return C!=D;
                li    $v0, 1
                jr    $ra
same:           li    $v0, 0                 
                jr    $ra                    #}
#/////////////////////////////////////////////
is_palindrome:                               #int is_palindrome(char *w,int size) {  //size here would be the char_index, $s5
                                             # int z;                                //Use $s2(y) as z.
                la    $s7, revword           # char revword[20];
                add   $s2, $s5, $0
decreaseloop3:  add   $s2, $s2, -1           # make the immediate of word,and value of z to zero.
                addi  $s4, $s4, -1
                bnez  $s2, decreaseloop3    
rev:                                         # for(z=0;z<size;z++){
                lb    $t1, 0($s4)            #  revword[z]=w[size-z-1];  //Store the revword reversely to match with word
                sb    $t1, 0($s7)          
                add   $s2, $s2, 1            # //z++ part
                addi  $s4, $s4, 1
                addi  $s7, $s7, 1
                blt   $s2, $s5, rev          # } //z<size part
                
                addi  $s7, $s7, -1           #  Make immediate of revword point to the last byte
                
decreaseloop4:  add   $s2, $s2, -1           # make the immediate of word,and value of z to zero.
                addi  $s4, $s4, -1
                bnez  $s2, decreaseloop4
                                
                blt   $s5, 2, ret0           # if(size>=2){
checksame:                                   #   for(z=0;z<size;z++){
                lb    $a1, 0($s4)            #    if(cci(w[z],revword[z]))
                lb    $a2, 0($s7)
                add   $a3, $0, $ra           #  //Store the previous address before jumping
                jal   cci
                add   $ra, $0, $a3
                
                bnez  $v0, ret0              #     return 0;
                add   $s2, $s2, 1            #    } //z++ part
                addi  $s4, $s4, 1           
                addi  $s7, $s7, -1
                blt   $s2, $s5, checksame    #   } //z<size part
                
                addi  $s7, $s7, 1            #  Make immediate of revword point to the first byte
                
                li    $v0, 1                 #  return 1;
                jr    $ra

ret0:                                        # }else{
                li    $v0, 0                 #  return 0;
                jr    $ra                    # }
                                             #}
