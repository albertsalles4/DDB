--DEC1A2--

ENTITY dec1a2 IS
  PORT(d,e: IN BIT; z0,z1: OUT BIT);
END dec1a2;

--Ifthen--

ARCHITECTURE ifthen OF dec1a2 IS
BEGIN
  
  PROCESS(d,e)
    BEGIN
      
    IF e='0' THEN z1<='0' AFTER 3 ns; z0<='0' AFTER 3 ns;
    ELSIF e='1' THEN
      IF d='0' THEN z1<='0' AFTER 3 ns; z0<='1' AFTER 3 ns;
      ELSIF d='1' THEN z1<='1' AFTER 3 ns; z0<='0' AFTER 3 ns; 
        
      END IF; 
    END IF; 
  END PROCESS;
  
END ifthen;

---Estructural--

ARCHITECTURE estructural OF dec1a2 IS

COMPONENT and2 IS
  PORT(a,b:IN BIT; z: OUT BIT);
END COMPONENT;

COMPONENT inv IS
  PORT(a:IN BIT; z:OUT BIT);
END COMPONENT;

SIGNAL invd: BIT;

FOR DUT1: inv USE ENTITY WORK.inv(logica_retard);
FOR DUT2: and2 USE ENTITY WORK.and2(logica_retard);
FOR DUT3: and2 USE ENTITY WORK.and2(logica_retard);

BEGIN
  
  DUT1: inv PORT MAP(d,invd);
  DUT2: and2 PORT MAP(d,e,z1);
  DUT3: and2 PORT MAP(invd,e,z0);
    
END estructural;