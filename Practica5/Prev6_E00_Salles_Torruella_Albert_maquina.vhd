--FF_JK_PUJADA ---------------------------
ENTITY FF_JK_Pujada IS
PORT(J,K,Clk: IN BIT; Q: OUT BIT);
END FF_JK_Pujada;

ARCHITECTURE ifthen OF FF_JK_Pujada IS
SIGNAL qint: BIT;
-- Aquesta és la forma de definir sortides que es realimenten
-- a l?entrada.
BEGIN

PROCESS (J,K,Clk)
BEGIN
IF Clk'EVENT AND Clk = '1' THEN
	IF J = '0' THEN
		IF K = '0' THEN qint <= qint AFTER 4 ns;
		ELSIF K = '1' THEN qint <= '0' AFTER 4 ns;
		END IF;
	ELSIF J = '1' THEN
		IF K = '0' THEN qint <= '1' AFTER 4 ns;
		ELSIF K = '1' THEN qint <= NOT qint AFTER 4 ns;
		END IF;
	END IF;
END IF;
END PROCESS;
Q<=qint;
-- Aquí es on es fa l'assignació de les variables
-- internes a les variables de sortida
END ifthen;

-- XNOR ---------------------------
ENTITY xnor2 IS
PORT(a, b: IN BIT; z: OUT BIT);
END xnor2;

ARCHITECTURE logica_retard OF xnor2 IS
BEGIN
z <= (a AND b) OR ((NOT a) AND (NOT b)) AFTER 4 ns;
END logica_retard;

-- AND2 ---------------------------
ENTITY and2 IS
PORT(a, b: IN BIT; z: OUT BIT);
END and2;

ARCHITECTURE logica_retard OF and2 IS
BEGIN
z <= a AND b AFTER 4 ns;
END logica_retard;

-- circuit ---------------------------
ENTITY circuit IS
PORT(X, Clk: IN BIT; Z2, Z1, Z0: OUT BIT);
END circuit;

ARCHITECTURE estructural OF circuit IS
COMPONENT FF_JK_Pujada IS
PORT(J, K, Clk: IN BIT; Q: OUT BIT);
END COMPONENT;

COMPONENT xnor2 IS
PORT(a, b: IN BIT; z: OUT BIT);
END COMPONENT;

COMPONENT and2 IS
PORT(a, b: IN BIT; z: OUT BIT);
END COMPONENT;

SIGNAL Q0int, Q1int, aux0, aux1: BIT;

FOR DUT1: xnor2 USE ENTITY WORK.xnor2(logica_retard);
FOR DUT2: and2 USE ENTITY WORK.and2(logica_retard);
FOR DUT3: FF_JK_Pujada USE ENTITY WORK.FF_JK_Pujada(ifthen);
FOR DUT4: FF_JK_Pujada USE ENTITY WORK.FF_JK_Pujada(ifthen);
FOR DUT5: FF_JK_Pujada USE ENTITY WORK.FF_JK_Pujada(ifthen);

BEGIN
DUT1: xnor2 PORT MAP (X, Q0int, aux0);
DUT2: and2 PORT MAP (aux0, Q1int, aux1);
DUT3: FF_JK_Pujada PORT MAP (aux1, aux1, Clk, Z2);
DUT4: FF_JK_Pujada PORT MAP (aux0, aux0, Clk, Q1int);
DUT5: FF_JK_Pujada PORT MAP (X, '1', Clk, Q0int);
Z1 <= Q1int;
Z0 <= Q0int;

END estructural;

-- BANC DE PROVES ---------------------------
ENTITY banc_de_proves IS
END banc_de_proves;

ARCHITECTURE test OF banc_de_proves IS
COMPONENT circuit IS
PORT(X, Clk: IN BIT; Z2, Z1, Z0: OUT BIT);
END COMPONENT;

SIGNAL Clk, X, Z2, Z1, Z0: BIT;

FOR DUT1: circuit USE ENTITY WORK.circuit(estructural);

BEGIN
DUT1: circuit PORT MAP(X, Clk, Z2, Z1, Z0);

PROCESS
BEGIN
Clk <= '0';
WAIT FOR 1 ns;
X <= '0';
WAIT FOR 100 ns;
Clk <= '1';
WAIT FOR 30 ns;
X <= '1';
WAIT FOR 70 ns;
Clk <= '0';
WAIT FOR 100 ns;
Clk <= '1';
WAIT FOR 50 ns;
X <= '0';
WAIT FOR 50 ns;
Clk <= '0';
WAIT FOR 70 ns;
X <= '1';
WAIT FOR 30 ns;
Clk <= '1';
WAIT FOR 50 ns;
X <= '0';
WAIT FOR 50 ns;
Clk <= '0';
WAIT FOR 100 ns;
Clk <= '1';
WAIT FOR 10 ns;
X <= '1';
WAIT FOR 30 ns;
X <= '0';
WAIT FOR 30 ns;
X <= '1';
WAIT FOR 30 ns;
X <= '0';
WAIT FOR 1 ns;
Clk <= '0';
-- Executa per 3500 ns

END PROCESS;
END test;

