--Fitxer de la funcio logica a implementar:
--  f=(/a·b·/c+b·/d+a·c·d+a·/d) XOR (a+/d)

--Aqui definim l'entitat i l'arquitectura del banc de proves
ENTITY bancdeproves IS
END bancdeproves;

ARCHITECTURE test OF bancdeproves IS

--Definim el component al que volem fer el test
COMPONENT bloc IS
PORT(A,B,C,D: IN BIT; f: OUT BIT);
END COMPONENT;

--Definim els senyals externs que apliquem
SIGNAL ent0, ent1, ent2, ent3, sort_logica, sort_logicaretard, sort_estructural, sort_ifthen: BIT;
FOR dut1: bloc USE ENTITY WORK.funcio_2(logica);
FOR dut2: bloc USE ENTITY WORK.funcio_2(logicaretard);
FOR dut3: bloc USE ENTITY WORK.funcio_2(estructural);
FOR dut4: bloc USE ENTITY WORK.funcio_2(ifthen);

--Ara definim el cos de l'arquitectura
BEGIN
dut1: bloc PORT MAP(ent0, ent1, ent2, ent3, sort_logica);
dut2: bloc PORT MAP(ent0, ent1, ent2, ent3, sort_logicaretard);
dut3: bloc PORT MAP(ent0, ent1, ent2, ent3, sort_estructural);
dut4: bloc PORT MAP(ent0, ent1, ent2, ent3, sort_ifthen);

PROCESS(ent0, ent1, ent2, ent3)
BEGIN
ent0 <= NOT ent0 AFTER 50ns;
ent1 <= NOT ent1 AFTER 100ns;
ent2 <= NOT ent2 AFTER 200ns;
ent3 <= NOT ent3 AFTER 400ns;
END PROCESS;

END test;

--Per la qüestió 2d):
--El resultat es veu afectat per un endarreriment encara major
--a més, hi apareixen uns certs "rebots" que fan que el resultat
--sigui incorrecte en períodes de temps molt curts. Aquests "rebots"
--no són aleatoris perquè sempre apareixen al mateix moment del
--del cicle que fan les entrades i sol ser just després de que alguna
--d'aquestes canvïi de valor.

--Per la qüestió 2e):
--Si fem que l'entrada que varia més ràpidament ho faci en 5ns
--aleshores el gràfic resultant de logicaretard queda gairebé
--exactament invertit respecte el gràfic de logica.
--Això es deu a que logicaretard ja té un retard de 5ns de per sí,
--per tant si variem la primera entrada en aquest mateix temps el
--resultat, que ja varia respecte aquesta entrada, es veu afectat
--d'aquesta manera.