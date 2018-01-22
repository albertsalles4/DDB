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

-- XNOR2 -----------------------------------------
ENTITY xnor2 IS
	PORT(a,b:IN BIT; z: OUT BIT);
END xnor2;


ARCHITECTURE logica OF xnor2 IS
BEGIN
	z<= NOT ((NOT a AND b) OR (a AND NOT b));
END logica;

ARCHITECTURE logicaretard OF xnor2 IS
BEGIN
	z<= NOT ((NOT a AND b) OR (a AND NOT b)) AFTER 5 ns;
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

-- COMP2 ---------------------------------------
ENTITY comp2 IS
  PORT(a,b: IN BIT; z: OUT BIT);
END comp2;

ARCHITECTURE logica OF comp2 IS
BEGIN
  z<= (a OR b) AND (NOT b);
END logica;

ARCHITECTURE logicaretard OF comp2 IS
BEGIN
  z<= (a OR b) AND (NOT b) AFTER 5 ns;
END logicaretard;

--Aqui comen�a la definicio de la funcio logica que volem implementar
ENTITY funcio_2 IS
PORT (enable: IN BIT; a1,a0,b1,b0: IN BIT; z2,z1,z0: OUT BIT);
END funcio_2;

--Aqui definim una funcio auxiliar
ENTITY funcio_aux IS
PORT (enable: IN BIT; f2,f1,f0,g2,g1,g0: IN BIT; z2,z1,z0: OUT BIT);
END funcio_aux;

--Definim l'arquitectura ifthen
ARCHITECTURE ifthen OF funcio_2 IS
BEGIN

PROCESS(a1,a0,b1,b0,enable)
BEGIN
  IF enable = '1' THEN z2 <= '0'; z1 <= '0'; z0 <= '0';
  ELSE
    IF a1 = '1' AND b1 = '0' THEN z2 <= '1'; z1 <= '0'; z0 <= '0';
      ELSIF a1 = '0' AND b1 = '1' THEN z2 <= '0'; z1 <= '1'; z0 <= '0';
        ELSIF a1 = b1 THEN
          IF a0 = '1' AND b0 = '0' THEN z2 <= '1'; z1 <= '0'; z0 <= '0';
          ELSIF a0 = '0' AND b0 = '1' THEN z2 <= '0'; z1 <= '0'; z0 <= '1';
          ELSE z2 <= '0'; z1 <= '1'; z0 <= '0';
          END IF;
    END IF;
  END IF;
END PROCESS;

END ifthen;

--Definim l'arquitectura ifthen de la funcio auxiliar
ARCHITECTURE ifthen OF funcio_aux IS
BEGIN

PROCESS(f2,f1,f0,g2,g1,g0,enable)
BEGIN
IF enable = '1' THEN z2 <= '0'; z1 <= '0'; z0 <= '0';
ELSE
  IF f2 = '1' THEN z2 <= '1';
  ELSIF f1 = '1' AND g2 <= '1' THEN z2 <= '1';
  ELSE z2 <= '0';
  END IF;

  IF f1 = '1' AND g1 = '1' THEN z1 <= '1';
  ELSE z1 <= '0';
  END IF;
  
  IF f0 = '1' THEN z0 <= '1';
  ELSIF f1 = '1' AND g0 = '1' THEN z0 <= '1';
  ELSE z0 <= '0';
  END IF;
END IF;
END PROCESS;

END ifthen;
