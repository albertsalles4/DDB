--Definim l'entitat
ENTITY bancdeproves IS
END bancdeproves;

--Definim l'arquitectura
ARCHITECTURE test OF bancdeproves IS

COMPONENT comp2bits IS
PORT (enable: IN BIT; a1, a0, b1, b0: IN BIT; z2,z1,z0: OUT BIT);
END COMPONENT; 

COMPONENT compNbits IS
PORT (enable: IN BIT; f2, f1, f0, g2, g1, g0: IN BIT; z2, z1, z0: OUT BIT);
END COMPONENT;

SIGNAL enable: BIT;
SIGNAL ent_a3, ent_a2, ent_a1, ent_a0: BIT;
SIGNAL ent_b3, ent_b2, ent_b1, ent_b0: BIT;
SIGNAL f2, f1, f0, g2, g1, g0, sort2, sort1, sort0: BIT;

FOR dut1: comp2bits USE ENTITY WORK.funcio_2(ifthen);
FOR dut2: comp2bits USE ENTITY WORK.funcio_2(ifthen);
FOR dut3: compNbits USE ENTITY WORK.funcio_aux(ifthen);

BEGIN
dut1: comp2bits PORT MAP (enable, ent_a3, ent_a2, ent_b3, ent_b2, f2, f1, f0);
dut2: comp2bits PORT MAP (enable, ent_a1, ent_a0, ent_b1, ent_b0, g2, g1, g0);
dut3: compNbits PORT MAP (enable, f2, f1, f0, g2, g1, g0, sort2, sort1, sort0);

PROCESS(enable, ent_a3, ent_a2, ent_a1, ent_a0, ent_b3, ent_b2, ent_b1, ent_b0) 
BEGIN
enable <= NOT enable AFTER 6400ns;
ent_a3 <= NOT ent_a3 AFTER 25ns;
ent_a2 <= NOT ent_a2 AFTER 50ns;
ent_a1 <= NOT ent_a1 AFTER 100ns;
ent_a0 <= NOT ent_a0 AFTER 200ns;
ent_b3 <= NOT ent_b3 AFTER 400ns;
ent_b2 <= NOT ent_b2 AFTER 800ns;
ent_b1 <= NOT ent_b1 AFTER 1600ns;
ent_b0 <= NOT ent_b0 AFTER 3200ns;

END PROCESS;
 
END test;
