program game;

uses crt, sysutils;
	

type position = record
  x: SmallInt;
  y: SmallInt;
end;

type obstacle = record
	h: SmallInt;
	shape: string;
end;


function genObstacle(): obstacle;

var l: string;
	i: integer;
	o: obstacle;
	
begin
	l:= '';
	Randomize;
	for i:= 1 to 10 do
		begin
			if random()>0.5 then
				l:= l + ' '
			else 
				l:= l + '_';
		end;
	o.h:= 0;
	o.shape:= l;
	genObstacle:= o;
end;

function initialize(): position;

var s: string;
	p: position;
	i: integer;

begin
	s:= '          ';
	randomize;
	for i:= 1 to 9 do
		writeln(s);
	p.y:= 10;
	p.x:= SmallInt(random(10));
	delete(s, p.x, 1);
	insert('o', s, p.x);
	writeln(s);
	initialize:= p;
end;


procedure updatescr(c: position; o: obstacle);
var i: integer;
	l, t: string;

begin
	t:= 'o';
	clrscr();
	for i:= 1 to 10 do
	begin
	l:= '          ';
		if i = o.h then
			l:= o.shape
		else if i = c.y then
			begin
				delete(l, c.x, 1);
				insert(l, t, c.x)
			end;
		writeln(l);
	end;
end;

var cursor: position;
	ob: obstacle;
	ch: char;

begin
	cursor:= initialize();
	writeln(cursor.x);
	writeln(cursor.y);
	ob:= genObstacle();
	repeat
		ch:= ReadKey;
		case ch of
			#75 : if cursor.x > 0 then 
			 		cursor.x:= cursor.x - 1;
        	#77 : if cursor.x < 10 then
        			cursor.x:= cursor.x + 1;
        	#72 : if cursor.y < 10 then
        			cursor.y:= cursor.y + 1;
        	#80 : if cursor.y > 0 then
        			cursor.y:= cursor.y - 1;
		end;
		updatescr(cursor, ob);
		ob.h:= ob.h +1;
		if ob.h > 10 then
			ob:= genObstacle;
	until (ReadKey = char(27));
end.
