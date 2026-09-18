THIS CODE WAS WRITTEN IN ACCORDANCE WITH THE COLLABORATION AND AI
POLICIES FOR THIS COURSE. Abby Wylie, Anne Hu

Our group's lexer follows the tiger language reference manual for reserved words and tokenized them accordingly. 
For comments we created initial states <COMMENT> and <INITIAL> as start states to define whether a line is recognized as a comment or not. 
Since STRING can parse commands, we included a <STRING> state which utilizes a string buffer to buffer string after the first quotation. During <STRING> state it will check for commands like \n\t and ascii codes (\f\r) which will then return the result to the buffer. After the final qutotation is found the full string in the buffer will be tokenized to return 1 string token.
We initally tried a command line, but after the email guidance that one should not switch states to simply read commands, and have the '\' be part of the string, we switched the command state to an overall string state.

End of file was already taken care of by the provided skeleton code eof().
Illegal characters were also properly caught with the provided error msg.

We tested lexer by going through each of the tests cases provided, then created a new test case that contained all tokens and various combinations of pontetin
Our group used Claude AI to mostly to ask logistical question of how tiger language works. Such as determine the purpose of the lineNum and linePos within the new line code (\n) provided in the skeleton code. Some of our code was also made in reference to other publically posted tiger.lex projects (public githubs) which is where the idea for an ascii function and str buffer started. Though we still completely referenced the SML basis library to write said functions.
https://smlfamily.github.io/Basis/char.html
https://smlfamily.github.io/Basis/integer.html
https://smlfamily.github.io/Basis/string.html
