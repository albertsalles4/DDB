ENTITY bdp_proves IS
END bdp_proves;

ARCHITECTURE vectors OF bdp_proves IS

COMPONENT inversor
PORT (a:IN BIT; z:OUT BIT);
END COMPONENT;

COMPONENT and2
PORT (a,b:IN BIT; z:OUT BIT);
END COMPONENT;

COMPONENT or2
PORT (a,b:IN BIT; z:OUT BIT);
END COMPONENT;

COMPONENT and3
PORT (a,b,c:IN BIT; z:OUT BIT);
END COMPONENT;

COMPONENT or3
PORT (a,b,c:IN BIT; z:OUT BIT);
END COMPONENT;

COMPONENT and4
PORT (a,b,c,d:IN BIT; z:OUT BIT);
END COMPONENT;

COMPONENT or4
PORT (a,b,c,d:IN BIT; z:OUT BIT);
END COMPONENT;

SIGNAL ent1, ent2, ent3, ent4, sort_inversor_logica, sort_inversor_logicaretard,
sort_and2_logica, sort_and2_logicaretard, sort_or2_logica, sort_or2_logicaretard,
sort_and3_logica, sort_and3_logicaretard, sort_or3_logica, sort_or3_logicaretard,
sort_and4_logica, sort_and4_logicaretard, sort_or4_logica, sort_or4_logicaretard:BIT;

FOR dut1: inversor USE ENTITY WORK.inversor(logica);
FOR dut2: inversor USE ENTITY WORK.inversor(logicaretard);
FOR dut3: and2 USE ENTITY WORK.and2(logica);
FOR dut4: and2 USE ENTITY WORK.and2(logicaretard);
FOR dut5: or2 USE ENTITY WORK.or2(logica);
FOR dut6: or2 USE ENTITY WORK.or2(logicaretard);
FOR dut7: and3 USE ENTITY WORK.and3(logica);
FOR dut8: and3 USE ENTITY WORK.and3(logicaretard);
FOR dut9: or3 USE ENTITY WORK.or3(logica);
FOR dut10: or3 USE ENTITY WORK.or3(logicaretard);
FOR dut11: and4 USE ENTITY WORK.and4(logica);
FOR dut12: and4 USE ENTITY WORK.and4(logicaretard);
FOR dut13: or4 USE ENTITY WORK.or4(logica);
FOR dut14: or4 USE ENTITY WORK.or4(logicaretard);

BEGIN
dut1: inversor PORT MAP(ent1, sort_inversor_logica);
dut2: inversor PORT MAP(ent1, sort_inversor_logicaretard);
dut3: and2 PORT MAP(ent1, ent2, sort_and2_logica);
dut4: and2 PORT MAP(ent1, ent2, sort_and2_logicaretard);
dut5: or2 PORT MAP(ent1, ent2, sort_or2_logica);
dut6: or2 PORT MAP(ent1, ent2, sort_or2_logicaretard);
dut7: and3 PORT MAP(ent1, ent2, ent3, sort_and3_logica);
dut8: and3 PORT MAP(ent1, ent2, ent3, sort_and3_logicaretard);
dut9: or3 PORT MAP(ent1, ent2, ent3, sort_or3_logica);
dut10: or3 PORT MAP(ent1, ent2, ent3, sort_or3_logicaretard);
dut11: and4 PORT MAP(ent1, ent2, ent3, ent4, sort_and4_logica);
dut12: and4 PORT MAP(ent1, ent2, ent3, ent4, sort_and4_logicaretard);
dut13: or4 PORT MAP(ent1, ent2, ent3, ent4, sort_or4_logica);
dut14: or4 PORT MAP(ent1, ent2, ent3, ent4, sort_or4_logicaretard);
PROCESS (ent1, ent2, ent3, ent4)
BEGIN
ent1<=NOT ent1 AFTER 200 ns;
ent2<=NOT ent2 AFTER 100 ns;
ent3<=NOT ent3 AFTER 50 ns;
ent4<=NOT ent4 AFTER 25 ns;
END PROCESS;
END vectors;


ENTITY bdp_funcio IS
END bdp_funcio;

ARCHITECTURE vectors of bdp_funcio IS

COMPONENT xor2
PORT (a, b: IN BIT; z: OUT BIT);
END COMPONENT;

SIGNAL ent1, ent2, sort_xor2_logica, sort_xor2_logicaretard: BIT;

FOR dut1: xor2 USE ENTITY WORK.xor2(logica);
FOR dut2: xor2 USE ENTITY WORK.xor2(logicaretard);

BEGIN
dut1: xor2 PORT MAP(ent1, ent2, sort_xor2_logica);
dut2: xor2 PORT MAP(ent1, ent2, sort_xor2_logicaretard);
PROCESS (ent1, ent2)
BEGIN
ent1 <= NOT ent1 AFTER 50 ns;
ent2 <= NOT ent2 AFTER 25 ns;
END PROCESS;
END vectors;