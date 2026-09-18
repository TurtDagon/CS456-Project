THIS CODE WAS WRITTEN IN ACCORDANCE WITH THE COLLABORATION AND AI
POLICIES FOR THIS COURSE. Abby Wylie, Anne Hu

how you handled comments and strings
• how you handled lexical errors
• how you handled end-of-file
• how you tested your lexer
• any other implementation decisions or features that you think are worth noting
• a description of any AI tools you used and how you used them

Our group's lexer follows the tiger language reference manual for reserved words and tokenized them accordingly. For comments, string and ID, we created initial states <COMMENT> and <INITIAL> as start states to define whether a line is recognized as a comment or not. Since ID and STRING are both tokenized, we separated them by declaring string being surrounded by quotations (""). ID is also separated from string by not beginning with a number.

We tested lexer by going through each of the tests cases provided, then created a new test case that contained all tokens and various 
Our group used Claude AI to determine the purpose of the lineNum and linePos the new line code (\n) provided in the skeleton code.
