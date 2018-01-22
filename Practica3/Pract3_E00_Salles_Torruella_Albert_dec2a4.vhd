--DEC2A4--

ENTITY dec2a4 IS
  PORT(control,dada0,dada1: IN BIT; sortida3,sortida2,sortida1,sortida0: OUT BIT);
END dec2a4;

--Estructural--

ARCHITECTURE estructural OF dec2a4 IS
  
COMPONENT dec1a2 IS
  PORT(d,e: IN BIT; z1,z0: OUT BIT);
END COMPONENT;

COMPONENT and2 IS
  PORT(a,b:IN BIT; z: OUT BIT);
END COMPONENT;

COMPONENT inv IS
  PORT(a:IN BIT; z:OUT BIT);
END COMPONENT;

SIGNAL invdada1, alpha1, alpha2: BIT;

FOR DUT1: inv USE ENTITY WORK.inv(logica_retard);
FOR DUT2: and2 USE ENTITY WORK.and2(logica_retard);
FOR DUT3: and2 USE ENTITY WORK.and2(logica_retard);
FOR DUT4: dec1a2 USE ENTITY WORK.dec1a2(ifthen);
FOR DUT5: dec1a2 USE ENTITY WORK.dec1a2(estructural);

BEGIN
  
  DUT1: inv PORT MAP(dada1,invdada1);
  DUT2: and2 PORT MAP(invdada1,control,alpha1);
  DUT3: and2 PORT MAP(dada1,control,alpha2);
  DUT4: dec1a2 PORT MAP(dada0, alpha1, sortida1, sortida0);
  DUT5: dec1a2 PORT MAP(dada0, alpha2, sortida3, sortida2); 
   
END estructural;

--BANC DE PROVES--

ENTITY banc_proves IS                           
END banc_proves;

ARCHITECTURE test OF banc_proves IS
  
COMPONENT dec2a4 IS
	PORT(control,dada0,dada1: IN BIT; sortida3,sortida2,sortida1,sortida0: OUT BIT);
END COMPONENT;

FOR DUT1: dec2a4 USE ENTITY WORK.dec2a4(estructural);

SIGNAL control,dada1,dada0,sortida3,sortida2,sortida1,sortida0: BIT;

BEGIN

DUT1: dec2a4 PORT MAP(control,dada0,dada1,sortida3,sortida2,sortida1,sortida0);

PROCESS(control, dada0, dada1)
BEGIN
  	dada0<= NOT dada0 AFTER 50 ns; 
	dada1<= NOT dada1 AFTER 100 ns; 
	control<= NOT control AFTER 200 ns;
	
END PROCESS;

END test;