
type pos = int
type lexresult = Tokens.token
  
val lineNum = ErrorMsg.lineNum
val linePos = ErrorMsg.linePos
fun err(p1,p2) = ErrorMsg.error p1

val strBuf : string list ref = ref []
val stringStart = ref 0

fun addStr s = strBuf := s :: !strBuf
fun clearStr () = strBuf := []
fun getStr () = String.concat (List.rev (!strBuf))

fun eof() = let val pos = hd(!linePos) in Tokens.EOF(pos,pos) end

fun asciiString text =
    let val subStr = String.substring(text, 1, 3)
        val intVal = valOf(Int.fromString subStr)
        val charVal = chr intVal
    in Char.toString charVal end

%%
%s COMMENT STRING;
digit = [0-9];
letter = [A-Za-z];
character = [A-Za-z0-9_];
whiteSpace = [\ \t\r\n\f];
string = {character} | {whiteSpace};

%%
<INITIAL, COMMENT> "/*" => (YYBEGIN COMMENT; continue());
<COMMENT> "*/" => (YYBEGIN INITIAL; continue());
<INITIAL> "\"" => (YYBEGIN STRING; stringStart := yypos; clearStr(); continue());
<STRING> "\"" => (YYBEGIN INITIAL; Tokens.STRING(getStr(), !stringStart, yypos+1));

<STRING> \\n  => (lineNum := !lineNum+1; linePos := yypos :: !linePos; addStr "\n"; continue());
<STRING> \\t  => (addStr "\t"; continue());
<STRING> \\f  => (addStr "\012"; continue());
<STRING> \\r  => (addStr "\013"; continue());
<STRING> \\{digit}{3} => (addStr (asciiString yytext); continue());
<STRING> "\\\"" => (addStr "\\""; continue());
<STRING> {string}+   => (addStr yytext; continue());

\n	=> (lineNum := !lineNum+1; linePos := yypos :: !linePos; continue());
\t => (continue());
" "   => (continue());
","   => (Tokens.COMMA(yypos,yypos+1));
var   => (Tokens.VAR(yypos,yypos+3));
type  => (Tokens.TYPE(yypos, yypos+4));
function    => (Tokens.FUNCTION(yypos, yypos+3));
break   => (Tokens.BREAK(yypos, yypos+5));
of  => (Tokens.OF(yypos, yypos+2));
end => (Tokens.END(yypos, yypos+3));
in => (Tokens.IN(yypos, yypos+2));
nil => (Tokens.NIL(yypos, yypos+3));
let => (Tokens.LET(yypos, yypos+3));
do => (Tokens.DO(yypos, yypos+2));
to => (Tokens.TO(yypos, yypos+2));
for => (Tokens.FOR(yypos, yypos+3));
while => (Tokens.WHILE(yypos, yypos+5));
else => (Tokens.ELSE(yypos, yypos+4));
then => (Tokens.THEN(yypos, yypos+4));
if => (Tokens.IF(yypos, yypos+2));
array => (Tokens.ARRAY(yypos, yypos+3));
":" => (Tokens.COLON(yypos, yypos+1));
":=" => (Tokens.ASSIGN(yypos, yypos+2));
"|" => (Tokens.OR(yypos, yypos+1));
"&" => (Tokens.AND(yypos, yypos+1));
">=" => (Tokens.GE(yypos, yypos+2));
">" => (Tokens.GT(yypos, yypos+1));
"<=" => (Tokens.LE(yypos, yypos+2));
"<" => (Tokens.LT(yypos, yypos+1));
"=" => (Tokens.EQ(yypos, yypos+1));
"/" => (Tokens.DIVIDE(yypos,yypos+1));
"*" => (Tokens.TIMES(yypos,yypos+1));
"-" => (Tokens.MINUS(yypos,yypos+1));
"+" => (Tokens.PLUS(yypos,yypos+1));
"." => (Tokens.DOT(yypos,yypos+1));
"}" => (Tokens.RBRACE(yypos,yypos+1));
"{" => (Tokens.LBRACE(yypos,yypos+1));
"]" => (Tokens.RBRACK(yypos,yypos+1));
"[" => (Tokens.LBRACK(yypos,yypos+1));
")" => (Tokens.RPAREN(yypos,yypos+1));
"(" => (Tokens.LPAREN(yypos,yypos+1));
";" => (Tokens.SEMICOLON(yypos,yypos+1));
<INITIAL> {digit}+  => (Tokens.INT(valOf(Int.fromString yytext), yypos, yypos+size yytext));
<INITIAL> {letter}+{character}*   => (Tokens.ID(yytext, yypos, yypos+ size yytext));
<COMMENT> {string}*   => (continue());
.   => (ErrorMsg.error yypos ("illegal character " ^ yytext); continue());