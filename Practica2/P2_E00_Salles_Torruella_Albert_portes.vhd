-- INVERSOR  -----------------------------------------
ENTITY inv IS 
	PORT(a:IN BIT; z:OUT BIT);
END inv;


ARCHITECTURE logica OF inv IS
BEGIN
	z<= NOT a;
END logica;


ARCHITECTURE logicaretard OF inv IS
BEGIN
	z<= NOT a AFTER 5 ns;
END logicaretard;


-- AND2 -----------------------------------------
ENTITY and2 IS
	PORT(a,b:IN BIT; z: OUT BIT);
END and2;


ARCHITECTURE logica OF and2 IS
BEGIN
	z<= a AND b;
END logica;

ARCHITECTURE logicaretard OF and2 IS
BEGIN
	z<= a AND b  AFTER 5 ns;
END logicaretard;

-- OR2 -----------------------------------------
ENTITY or2 IS
	PORT(a,b:IN BIT; z: OUT BIT);
END or2;


ARCHITECTURE logica OF or2 IS
BEGIN
	z<= a OR b;
END logica;

ARCHITECTURE logicaretard OF or2 IS
BEGIN
	z<= a OR b  AFTER 5 ns;
END logicaretard;

-- XOR2 -----------------------------------------
ENTITY xor2 IS
	PORT(a,b:IN BIT; z: OUT BIT);
END xor2;


ARCHITECTURE logica OF xor2 IS
BEGIN
	z<= (NOT a AND b) OR (a AND NOT b);
END logica;

ARCHITECTURE logicaretard OF xor2 IS
BEGIN
	z<= (NOT a AND b) OR (a AND NOT b) AFTER 5 ns;
END logicaretard;

-- AND3 -----------------------------------------
ENTITY and3 IS
	PORT(a,b,c:IN BIT; z: OUT BIT);
END and3;


ARCHITECTURE logica OF and3 IS
BEGIN
	z<= a AND b AND c;
END logica;

ARCHITECTURE logicaretard OF and3 IS
BEGIN
	z<= a AND b AND c AFTER 5 ns;
END logicaretard;


-- OR3 -----------------------------------------
ENTITY or3 IS
	PORT(a,b,c:IN BIT; z: OUT BIT);
END or3;


ARCHITECTURE logica OF or3 IS
BEGIN
	z<= a OR b OR c;
END logica;

ARCHITECTURE logicaretard OF or3 IS
BEGIN
	z<= a OR b OR c AFTER 5 ns;
END logicaretard;

-- OR4 -----------------------------------------
ENTITY or4 IS
	PORT(a,b,c,d:IN BIT; z: OUT BIT);
END or4;


ARCHITECTURE logica OF or4 IS
BEGIN
	z<= a OR b OR c OR d;
END logica;

ARCHITECTURE logicaretard OF or4 IS
BEGIN
	z<= a OR b OR c OR d AFTER 5 ns;
END logicaretard;

--Aqui comença la definicio de la funcio logica que volem implementar
ENTITY funcio_2 IS
PORT (a,b,c,d: IN BIT; f: OUT BIT);
END funcio_2;


--Definim l'arquitectura logica de la funcio
ARCHITECTURE logica OF funcio_2 IS
BEGIN
f <= (NOT (((NOT a) AND b AND (NOT c)) OR (b AND (NOT d)) OR (a AND c AND d) OR (a AND (NOT d))) AND (a OR (NOT d))) OR ((((NOT a) AND b AND (NOT c)) OR (b AND (NOT d)) OR (a AND c AND d) OR (a AND (NOT d))) AND (NOT (a OR (NOT d))));
END logica;

--Definim l'arquitectura logicaretard de la funcio
ARCHITECTURE logicaretard OF funcio_2 IS
BEGIN
f <= (NOT (((NOT a) AND b AND (NOT c)) OR (b AND (NOT d)) OR (a AND c AND d) OR (a AND (NOT d))) AND (a OR (NOT d))) OR ((((NOT a) AND b AND (NOT c)) OR (b AND (NOT d)) OR (a AND c AND d) OR (a AND (NOT d))) AND (NOT (a OR (NOT d)))) AFTER 5ns;
END logicaretard;

--Definim l'arquitectura estructural de l'entitat
ARCHITECTURE estructural OF funcio_2 IS
COMPONENT portaand2 IS
PORT (a,b: IN BIT; z: OUT BIT);
END COMPONENT;

COMPONENT portaor2 IS
PORT(a,b: IN BIT; z: OUT BIT);
END COMPONENT;

COMPONENT portainv IS
PORT(a: IN BIT; z: OUT BIT);
END COMPONENT;

COMPONENT portaand3 IS
PORT (a,b,c: IN BIT; z: OUT BIT);
END COMPONENT;

COMPONENT portaor3 IS
PORT (a,b,c: IN BIT; z: OUT BIT);
END COMPONENT;

COMPONENT portaor4 IS
PORT (a,b,c,d: IN BIT; z: OUT BIT);
END COMPONENT;

COMPONENT portaxor2 IS
PORT (a,b: IN BIT; z: OUT BIT);
END COMPONENT;

--Definim els senyals interns
SIGNAL inva, invc, invd, alpha1, alpha2, alpha3, alpha4, beta1, beta2: BIT;

FOR dut1: portainv USE ENTITY WORK.inv(logicaretard);
FOR dut2: portainv USE ENTITY WORK.inv(logicaretard);
FOR dut3: portainv USE ENTITY WORK.inv(logicaretard);
FOR dut4: portaand3 USE ENTITY WORK.and3(logicaretard);
FOR dut5: portaand2 USE ENTITY WORK.and2(logicaretard);
FOR dut6: portaand3 USE ENTITY WORK.and3(logicaretard);
FOR dut7: portaand2 USE ENTITY WORK.and2(logicaretard);
FOR dut8: portaor4 USE ENTITY WORK.or4(logicaretard);
FOR dut9: portaor2 USE ENTITY WORK.or2(logicaretard);
FOR dut10: portaxor2 USE ENTITY WORK.xor2(logicaretard);


--Definim el cos de l'arquitectura
BEGIN
dut1: portainv PORT MAP(A, inva);
dut2: portainv PORT MAP(C, invc);
dut3: portainv PORT MAP(D, invd);
dut4: portaand3 PORT MAP(inva, B, invc, alpha1);
dut5: portaand2 PORT MAP(B, invd, alpha2);
dut6: portaand3 PORT MAP(A, C, D, alpha3);
dut7: portaand2 PORT MAP(A, invd, alpha4);
dut8: portaor4 PORT MAP(alpha1, alpha2, alpha3, alpha4, beta1);
dut9: portaor2 PORT MAP(A, invd, beta2);
dut10: portaxor2 PORT MAP(beta1, beta2, f);
END estructural;

--Definim l'arquitectura ifthen
ARCHITECTURE ifthen OF funcio_2 IS
BEGIN

PROCESS(a,b,c,d)
BEGIN
IF a = '0' AND b = '0' AND c = '0' AND d = '0' THEN f <= '1' AFTER 5ns;
ELSIF a = '0' AND b = '0' AND c = '0' AND d = '1' THEN f <= '0' AFTER 5ns;
ELSIF a = '0' AND b = '0' AND c = '1' AND d = '0' THEN f <= '1' AFTER 5ns;
ELSIF a = '0' AND b = '0' AND c = '1' AND d = '1' THEN f <= '0' AFTER 5ns;
ELSIF a = '0' AND b = '1' AND c = '0' AND d = '0' THEN f <= '0' AFTER 5ns;
ELSIF a = '0' AND b = '1' AND c = '0' AND d = '1' THEN f <= '1' AFTER 5ns;
ELSIF a = '0' AND b = '1' AND c = '1' AND d = '0' THEN f <= '0' AFTER 5ns;
ELSIF a = '0' AND b = '1' AND c = '1' AND d = '1' THEN f <= '0' AFTER 5ns;
ELSIF a = '1' AND b = '0' AND c = '0' AND d = '0' THEN f <= '0' AFTER 5ns;
ELSIF a = '1' AND b = '0' AND c = '0' AND d = '1' THEN f <= '1' AFTER 5ns;
ELSIF a = '1' AND b = '0' AND c = '1' AND d = '0' THEN f <= '0' AFTER 5ns;
ELSIF a = '1' AND b = '0' AND c = '1' AND d = '1' THEN f <= '0' AFTER 5ns;
ELSIF a = '1' AND b = '1' AND c = '0' AND d = '0' THEN f <= '0' AFTER 5ns;
ELSIF a = '1' AND b = '1' AND c = '0' AND d = '1' THEN f <= '1' AFTER 5ns;
ELSIF a = '1' AND b = '1' AND c = '1' AND d = '0' THEN f <= '0' AFTER 5ns;
ELSIF a = '1' AND b = '1' AND c = '1' AND d = '1' THEN f <= '0' AFTER 5ns;
END IF;
END PROCESS;

END ifthen;
