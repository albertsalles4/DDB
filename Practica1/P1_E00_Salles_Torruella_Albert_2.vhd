-- Inversor
ENTITY inversor IS
PORT (a : IN BIT;
z : OUT BIT);
END inversor;
ARCHITECTURE logica OF inversor IS
BEGIN
z <= not a;
END logica;
ARCHITECTURE logicaretard of inversor IS
BEGIN
z <= not a AFTER 2 ns;
END logicaretard;

-- And2
ENTITY and2 IS
PORT (a, b: IN BIT; z: OUT BIT);
END and2;
ARCHITECTURE logica of and2 IS
BEGIN
z <= a and b;
END logica;
ARCHITECTURE logicaretard of and2 IS
BEGIN
z <= (a and b) AFTER 2 ns;
END logicaretard;

--And3
ENTITY and3 IS
PORT (a, b, c: IN BIT; z: OUT BIT);
END and3;
ARCHITECTURE logica of and3 IS
BEGIN
z <= a and b and c;
END logica;
ARCHITECTURE logicaretard of and3 IS
BEGIN
z <= (a and b and c) AFTER 2 ns;
END logicaretard;

--And4
ENTITY and4 IS
PORT (a, b, c, d: IN BIT; z: OUT BIT);
END and4;
ARCHITECTURE logica of and4 IS
BEGIN
z <= a and b and c and d;
END logica;
ARCHITECTURE logicaretard of and4 IS
BEGIN
z <= (a and b and c and d) AFTER 2 ns;
END logicaretard;

-- Or2
ENTITY or2 IS
PORT (a, b: IN BIT; z: OUT BIT);
END or2;
ARCHITECTURE logica of or2 IS
BEGIN
z <= a or b;
END logica;
ARCHITECTURE logicaretard of or2 IS
BEGIN
z <= (a or b) AFTER 2 ns;
END logicaretard;


--Or3
ENTITY or3 IS
PORT (a, b, c: IN BIT; z: OUT BIT);
END or3;
ARCHITECTURE logica of or3 IS
BEGIN
z <= a or b or c;
END logica;
ARCHITECTURE logicaretard of or3 IS
BEGIN
z <= (a or b or c) AFTER 2 ns;
END logicaretard;

--Or4
ENTITY or4 IS
PORT (a, b, c, d: IN BIT; z: OUT BIT);
END or4;
ARCHITECTURE logica of or4 IS
BEGIN
z <= a or b or c or d;
END logica;
ARCHITECTURE logicaretard of or4 IS
BEGIN
z <= (a or b or c or d) AFTER 2 ns;
END logicaretard;

--Xor2
ENTITY xor2 IS
PORT (a, b: IN BIT; z: OUT BIT);
END xor2;
ARCHITECTURE logica of xor2 IS
BEGIN
z <= a xor b;
END logica;
ARCHITECTURE logicaretard of xor2 IS
BEGIN
z <= (a xor b) AFTER 2 ns;
END logicaretard;
