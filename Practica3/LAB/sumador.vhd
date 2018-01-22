--SUMADOR MODIFICAT D'UN BIT
--Aquesta és la entitat del sumador modificat d'un bit que volem implementar
ENTITY sumador_modificat_1bit IS
PORT (a,b,cin: IN BIT; suma_smod_1bit,cout_smod_1bit,aib_smod_1bit,aob_smod_1bit: OUT BIT);
END sumador_modificat_1bit;

-- Aquesta és la definició del sumador modificat de forma estructural
ARCHITECTURE estructural OF sumador_modificat_1bit IS

COMPONENT portaand2 IS
PORT(a,b: IN BIT; z: OUT BIT);
END COMPONENT;

COMPONENT portaor2 IS
PORT(a,b: IN BIT; z: OUT BIT);
END COMPONENT;

COMPONENT portaxor2 IS
PORT (a,b: IN BIT; z: OUT BIT);
END COMPONENT ;

--Ens calen 6 DUTs.
FOR DUT1: portaxor2 USE ENTITY WORK.xor2(logica);
FOR DUT2: portaxor2 USE ENTITY WORK.xor2(logica);
FOR DUT3: portaand2 USE ENTITY WORK.and2(logica);
FOR DUT4: portaor2 USE ENTITY WORK.or2(logica);
FOR DUT5: portaand2 USE ENTITY WORK.and2(logica);
FOR DUT6: portaor2 USE ENTITY WORK.or2(logica);
-- Calen 4 senyals interns
SIGNAL sort_xor,sort_or,sort_and1,sort_and2: BIT;
-- Un cop introduïts tots els blocs i senyals, passem a realitzar les connexions
-- i, d'aquesta forma,
-- fer la definició de la funció lògica en funció de les variables a, b i cin.

BEGIN
	DUT1: portaxor2 PORT MAP (a,b,sort_xor);
	DUT2: portaxor2 PORT MAP( sort_xor,cin,suma_smod_1bit);
	DUT3: portaand2 PORT MAP (a,b,sort_and1);
	DUT4: portaor2 PORT MAP( a,b,sort_or);
	DUT5: portaand2 PORT MAP (sort_or,cin,sort_and2);
	DUT6: portaor2 PORT MAP (sort_and1,sort_and2,cout_smod_1bit);

-- ara introduïm quins senyals interns s?utilitzen, també, com externs
aib_smod_1bit <= sort_and1;
aob_smod_1bit <= sort_or;

END estructural;

----------- SUMADOR MODIFICAT 3 BITS --------------------------------------
ENTITY sumador_modificat_3bits IS
 PORT(a2, a1, a0, b2, b1, b0: IN BIT; suma2, suma1, suma0, aib2, aib1, aib0, aob2, aob1, aob0, cout: OUT BIT); 
END sumador_modificat_3bits;

ARCHITECTURE estructural OF sumador_modificat_3bits IS
  
COMPONENT sumador_modificat_1bit IS
  PORT (a,b,cin: IN BIT; suma_smod_1bit,cout_smod_1bit,aib_smod_1bit,aob_smod_1bit: OUT BIT);
END COMPONENT;

FOR DUT1: sumador_modificat_1bit USE ENTITY WORK.sumador_modificat_1bit(estructural);
FOR DUT2: sumador_modificat_1bit USE ENTITY WORK.sumador_modificat_1bit(estructural);
FOR DUT3: sumador_modificat_1bit USE ENTITY WORK.sumador_modificat_1bit(estructural);

SIGNAL c1, c2: BIT;

BEGIN
  DUT1: sumador_modificat_1bit PORT MAP (a0, b0, '0', suma0, c1, aib0, aob0);
  DUT2: sumador_modificat_1bit PORT MAP (a1, b1, c1, suma1, c2, aib1, aob1);
  DUT3: sumador_modificat_1bit PORT MAP (a2, b2, c2, suma2, cout, aib2, aob2);

END estructural;

----------- BANC DE PROVES ------------------------------------------------
ENTITY bancdeproves IS
END bancdeproves;

ARCHITECTURE test OF bancdeproves IS
  
COMPONENT bloc_que_simulem IS
  PORT(a2, a1, a0, b2, b1, b0: IN BIT; suma2, suma1, suma0, aib2, aib1, aib0, aob2, aob1, aob0, cout: OUT BIT);
END COMPONENT;

SIGNAL a2, a1, a0, b2, b1, b0, suma2, suma1, suma0, aib2, aib1, aib0, aob2, aob1, aob0, cout: BIT;
FOR DUT1: bloc_que_simulem USE ENTITY WORK.sumador_modificat_3bits(estructural);

BEGIN
DUT1: bloc_que_simulem PORT MAP (a2, a1, a0, b2, b1, b0, suma2, suma1, suma0, aib2, aib1, aib0, aob2, aob1, aob0, cout);

PROCESS(a2, a1, a0, b2, b1, b0)
BEGIN
  
  a2 <= NOT a2 AFTER 100 ns;
  a1 <= NOT a1 AFTER 50 ns;
  a0 <= NOT a0 AFTER 25 ns;
  
  b2 <= NOT b2 AFTER 800 ns;
  b1 <= NOT b1 AFTER 400 ns;
  b0 <= NOT b0 AFTER 200 ns;
  
END PROCESS;

END test;  


