LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY RCAmulttipo1xm28b IS
	PORT (A1, A0, B1, B0: IN STD_LOGIC;
		S3, S2, S1, S0: OUT STD_LOGIC
	);
END RCAmulttipo1xm28b;

ARCHITECTURE RCAcomportamento1m28b OF RCAmulttipo1xm28b IS

SIGNAL i1, i2, i3, i4: STD_LOGIC;
BEGIN
	i1 <= NOT(A0 AND B0); --nand2
	S0 <= NOT i1; --inv1
	i2 <= A1 AND B0; --and2
	i3 <= A0 AND B1; --and2
	S1 <= i2 XOR i3; --xor
	i4 <= A1 AND B1; --and2
	S2 <= i1 AND i4; --and2
	S3 <= i2 AND i3; --and2
END RCAcomportamento1m28b;

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY RCAmulttipo2xam28b IS
	PORT (A1, A0, B1, B0: IN STD_LOGIC;
		S3, S2, S1, S0: OUT STD_LOGIC
	);
END RCAmulttipo2xam28b;

ARCHITECTURE RCAcomportamento2m28b OF RCAmulttipo2xam28b IS

SIGNAL m1, m2, temp1, temp2, temp3, temp4: STD_LOGIC;
SIGNAL var3, m3: STD_LOGIC;
BEGIN
	temp1 <= A0 AND B0; --and2
        S0 <= temp1;
	m1 <= A1 AND B0; --and2
	m2 <= A0 AND B1; --and2
	S1 <= m1 XOR m2; --xor
        temp2 <= A1 XOR A0;
        temp3 <= temp1 OR temp2;
        S2 <= B1 AND temp3;
        temp4 <= A0 OR A1;
        S3 <= B1 AND temp4;
END RCAcomportamento2m28b;

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY RCAhalfadderm28b IS
	PORT (A, B: IN STD_LOGIC;
		COUT, S: OUT STD_LOGIC
	);
END RCAhalfadderm28b;

ARCHITECTURE RCAcomportamento3m28b OF RCAhalfadderm28b IS

BEGIN
	S <= A XOR B; --xor
	COUT <= A AND B; --and2
END RCAcomportamento3m28b;

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY RCAfulladderm28b IS
	PORT (CIN, A, B: IN STD_LOGIC;
		COUT, S: OUT STD_LOGIC
	);
END RCAfulladderm28b;

ARCHITECTURE RCAcomportamento4m28b OF RCAfulladderm28b IS

SIGNAL fio1, fio2, fio3: STD_LOGIC;
BEGIN
	fio1 <= A XOR B; --xor
	S <= fio1 XOR CIN; --xor
	fio2 <= A AND B; --and2
	fio3 <= fio1 AND CIN; --and2
	COUT <= fio3 OR fio2; --or2
END RCAcomportamento4m28b;

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY RCAmulttipo2xm28b IS
	PORT (A1, A0, B1, B0: IN STD_LOGIC;
		S3, S2, S1, S0: OUT STD_LOGIC
	);
END RCAmulttipo2xm28b;

ARCHITECTURE RCAcomportamento5m28b OF RCAmulttipo2xm28b IS

SIGNAL m1, m2, temp1, temp2, var1, var2: STD_LOGIC;
SIGNAL var3, m3: STD_LOGIC;
BEGIN
	S0 <= A0 AND B0; --and2
	m1 <= A1 AND B0; --and2
	m2 <= A0 AND B1; --and2
	S1 <= m1 XOR m2; --xor
	temp1 <= NOT B1; --inv1
	temp2 <= NOT B0; --inv1
	var1 <= NOT((A1 AND B0) AND temp1); --nand3
	var2 <= NOT((A1 AND B1) AND temp2); --nand3
	var3 <= NOT((A1 AND A0) AND B1); --nand3
	S2 <= NOT((var1 AND var2) AND var3); --nand3
	m3 <= A1 AND B1; --and2
	S3 <= m1 OR m3; --or2
END RCAcomportamento5m28b;

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY RCAmulttipo3xm28b IS
	PORT (A1, A0, B1, B0: IN STD_LOGIC;
		S3, S2, S1, S0: OUT STD_LOGIC
	);
END RCAmulttipo3xm28b;

ARCHITECTURE RCAcomportamento6m28b OF RCAmulttipo3xm28b IS

SIGNAL m1, m2, temp1, temp2, var1, var2: STD_LOGIC;
SIGNAL temp3, temp4, var3, var4, var5: STD_LOGIC;
BEGIN
	S0 <= A0 AND B0; --and2
	m1 <= A1 AND B0; --and2
	m2 <= A0 AND B1; --and2
	S1 <= m1 XOR m2; --xor
	temp1 <= NOT B1; --inv1
	temp2 <= NOT A1; --inv1
	var1 <= NOT((A1 AND temp1) AND B0); --nand3
	var2 <= NOT((temp2 AND A0) AND B1); --nand3
	S3 <= NOT(var1 AND var2); --nand2
	temp3 <= NOT A0; --inv1
	temp4 <= NOT B0; --inv1
	var3 <= A1 AND temp3; --and2
	var4 <= B1 AND temp4; --and2
	var5 <= NOT(var3 AND var4); --nand2
	S2 <= NOT((var1 AND var2) AND var5); --nand3
END RCAcomportamento6m28b;

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY RCAfulladder_nppm28b IS
	PORT (CIN, A, B: IN STD_LOGIC;
		S: OUT STD_LOGIC
	);
END RCAfulladder_nppm28b;

ARCHITECTURE RCAcomportamento7m28b OF RCAfulladder_nppm28b IS

SIGNAL fio1: STD_LOGIC;
BEGIN
	fio1 <= A XOR B; --xor
	S <= fio1 XOR CIN; --xor
END RCAcomportamento7m28b;


----- File my_components.vhd: ---------------
 LIBRARY ieee;
 USE ieee.std_logic_1164.all;

 PACKAGE my_componentsm28bRCA IS

COMPONENT RCAmulttipo1xm28b IS
	PORT (A1, A0, B1, B0: IN STD_LOGIC;
		S3, S2, S1, S0: OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT RCAmulttipo2xam28b IS
	PORT (A1, A0, B1, B0: IN STD_LOGIC;
		S3, S2, S1, S0: OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT RCAhalfadderm28b IS
	PORT (A, B: IN STD_LOGIC;
		COUT, S: OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT RCAfulladderm28b IS
	PORT (CIN, A, B: IN STD_LOGIC;
		COUT, S: OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT RCAmulttipo2xm28b IS
	PORT (A1, A0, B1, B0: IN STD_LOGIC;
		S3, S2, S1, S0: OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT RCAmulttipo3xm28b IS
	PORT (A1, A0, B1, B0: IN STD_LOGIC;
		S3, S2, S1, S0: OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT RCAfulladder_nppm28b IS
	PORT (CIN, A, B: IN STD_LOGIC;
		S: OUT STD_LOGIC
	);
END COMPONENT;


END my_componentsm28bRCA;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.my_componentsm28bRCA.all;

ENTITY RCAhalfadder_2Bitsm28b IS
	PORT (A1, A0, B1, B0: IN STD_LOGIC;
		COUT, S1, S0: OUT STD_LOGIC
	);
END RCAhalfadder_2Bitsm28b;

ARCHITECTURE RCAcomportamento8m28b OF RCAhalfadder_2Bitsm28b IS

SIGNAL COUT0: STD_LOGIC;
BEGIN
	stage_0m28bRCA: RCAhalfadderm28b port map (A0, B0, COUT0, S0);
	stage_1m28bRCA: RCAfulladderm28b port map (COUT0, A1, B1, COUT, S1);
END RCAcomportamento8m28b;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.my_componentsm28bRCA.all;

ENTITY RCAfulladder_2Bitsm28b IS
	PORT (CIN, A1, A0, B1, B0: IN STD_LOGIC;
		COUT, S1, S0: OUT STD_LOGIC
	);
END RCAfulladder_2Bitsm28b;

ARCHITECTURE RCAcomportamento9m28b OF RCAfulladder_2Bitsm28b IS

SIGNAL COUT0: STD_LOGIC;
BEGIN
	stage_0m28bRCA: RCAfulladderm28b port map (CIN, A0, B0, COUT0, S0);
	stage_1m28bRCA: RCAfulladderm28b port map (COUT0, A1, B1, COUT, S1);
END RCAcomportamento9m28b;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.my_componentsm28bRCA.all;

ENTITY RCAbitsadder_2Bitsm28b IS
	PORT (CIN, A1, A0: IN STD_LOGIC;
		S1, S0: OUT STD_LOGIC
	);
END RCAbitsadder_2Bitsm28b;

ARCHITECTURE RCAcomportamento10m28b OF RCAbitsadder_2Bitsm28b IS

SIGNAL COUT0: STD_LOGIC;
BEGIN
	stage_0m28bRCA: RCAhalfadderm28b port map (A0, CIN, COUT0, S0);
	S1 <= A1 XOR COUT0; --xor
 
END RCAcomportamento10m28b;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.my_componentsm28bRCA.all;

ENTITY RCAfulladder_npp_2Bitsm28b IS
	PORT (CIN, A1, A0, B1, B0: IN STD_LOGIC;
		S1, S0: OUT STD_LOGIC
	);
END RCAfulladder_npp_2Bitsm28b;

ARCHITECTURE RCAcomportamento11m28b OF RCAfulladder_npp_2Bitsm28b IS

SIGNAL COUT0, COUT1, COUT2: STD_LOGIC;
BEGIN
	stage_0m28bRCA: RCAfulladderm28b port map (CIN, A0, B0, COUT0, S0);
	stage_1m28bRCA: RCAfulladder_nppm28b port map (COUT0, A1, B1, S1);
END RCAcomportamento11m28b;


LIBRARY ieee;
 USE ieee.std_logic_1164.all;

 PACKAGE my_components1m28bRCA IS

COMPONENT RCAhalfadder_2Bitsm28b IS
	PORT (A1, A0, B1, B0: IN STD_LOGIC;
		COUT, S1, S0: OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT RCAfulladder_2Bitsm28b IS
	PORT (CIN, A1, A0, B1, B0: IN STD_LOGIC;
		COUT, S1, S0: OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT RCAbitsadder_2Bitsm28b IS
	PORT (CIN, A1, A0: IN STD_LOGIC;
		S1, S0: OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT RCAfulladder_npp_2Bitsm28b IS
	PORT (CIN, A1, A0, B1, B0: IN STD_LOGIC;
		S1, S0: OUT STD_LOGIC
	);
END COMPONENT;


END my_components1m28bRCA;


LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.my_componentsm28bRCA.all;
USE work.my_components1m28bRCA.all;

ENTITY RCAoperando1m28b IS
	PORT (A1, A0, B7, B6, B5, B4, B3, B2, B1, B0: IN STD_LOGIC;
		 S9, S8, S7, S6, S5, S4, S3, S2, S1, S0: OUT STD_LOGIC
	);
END RCAoperando1m28b;

ARCHITECTURE RCAcomportamento22m28b OF RCAoperando1m28b IS

SIGNAL RP01, RP00: STD_LOGIC;
SIGNAL RP13, RP12, RP11, RP10: STD_LOGIC;
SIGNAL RP23, RP22, RP21, RP20: STD_LOGIC;
SIGNAL RP33, RP32, RP31, RP30: STD_LOGIC; 

SIGNAL COUT2, COUT1, COUT0: STD_LOGIC;

BEGIN
	stage_0m28bRCA: RCAmulttipo1xm28b port map (A1, A0, B1, B0, RP01, RP00, S1, S0);
	stage_1m28bRCA: RCAmulttipo1xm28b port map (A1, A0, B3, B2, RP13, RP12, RP11, RP10);
	stage_2m28bRCA: RCAmulttipo1xm28b port map (A1, A0, B5, B4, RP23, RP22, RP21, RP20);
	stage_3m28bRCA: RCAmulttipo2xam28b port map (A1, A0, B7, B6, RP33, RP32, RP31, RP30);
        stage_4m28bRCA: RCAhalfadder_2Bitsm28b port map (RP01, RP00, RP11, RP10, COUT0, S3, S2);
	stage_5m28bRCA: RCAfulladder_2Bitsm28b port map (COUT0, RP13, RP12, RP21, RP20, COUT1, S5, S4);
	stage_6m28bRCA: RCAfulladder_2Bitsm28b port map (COUT1, RP23, RP22, RP31, RP30, COUT2, S7, S6);
      	stage_7m28bRCA: RCAbitsadder_2Bitsm28b port map (COUT2, RP33, RP32, S9, S8);

END RCAcomportamento22m28b;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.my_componentsm28bRCA.all;
USE work.my_components1m28bRCA.all;

ENTITY RCAoperando2m28b IS 
PORT (A1, A0, B7, B6, B5, B4, B3, B2, B1, B0: IN STD_LOGIC;
	  S9, S8, S7, S6, S5, S4, S3, S2, S1, S0: OUT STD_LOGIC
	);
END RCAoperando2m28b;

ARCHITECTURE RCAcomportamento23m28b OF RCAoperando2m28b IS

SIGNAL COUT0, COUT1, COUT2: STD_LOGIC;
SIGNAL RP01, RP00: STD_LOGIC;
SIGNAL RP13, RP12, RP11, RP10: STD_LOGIC;
SIGNAL RP23, RP22, RP21, RP20: STD_LOGIC;
SIGNAL RP33, RP32, RP31, RP30: STD_LOGIC;
SIGNAL G3, G2, G1, G0 : STD_LOGIC;

BEGIN
        stage_0am28bRCA: RCAmulttipo2xm28b port map (A1, A0, B1, B0, RP01, RP00, S1, S0);
	stage_1am28bRCA: RCAmulttipo2xm28b port map (A1, A0, B3, B2, RP13, RP12, RP11, RP10);
	stage_2am28bRCA: RCAmulttipo2xm28b port map (A1, A0, B5, B4, RP23, RP22, RP21, RP20);
	stage_3am28bRCA: RCAmulttipo3xm28b port map (A1, A0, B7, B6, RP33, RP32, RP31, RP30);
        stage_4am28bRCA: RCAhalfadder_2Bitsm28b port map (RP01, RP00, RP11, RP10, COUT0, S3, S2);
 	stage_5am28bRCA: RCAfulladder_npp_2Bitsm28b port map (COUT0, RP13, RP12, RP01, RP01, G1, G0);
	stage_6am28bRCA: RCAhalfadder_2Bitsm28b port map (RP21, RP20, G1, G0, COUT1, S5, S4);
	stage_7am28bRCA: RCAfulladder_npp_2Bitsm28b port map (COUT1, RP23, RP22, G1, G1, G3, G2);
	stage_8am28bRCA: RCAhalfadder_2Bitsm28b port map (RP31, RP30, G3, G2, COUT2, S7, S6);
	stage_9am28bRCA: RCAfulladder_npp_2Bitsm28b port map (COUT2, RP33, RP32, G3, G3, S9, S8);
    
END RCAcomportamento23m28b; 

LIBRARY ieee;
 USE ieee.std_logic_1164.all;

 PACKAGE my_components2m28bRCA IS

COMPONENT RCAoperando1m28b IS
	PORT (A1, A0, B7, B6, B5, B4, B3, B2, B1, B0: IN STD_LOGIC;
		  S9, S8, S7, S6, S5, S4, S3, S2, S1, S0: OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT RCAoperando2m28b IS 
    PORT (A1, A0, B7, B6, B5, B4, B3, B2, B1, B0: IN STD_LOGIC;
	      S9, S8, S7, S6, S5, S4, S3, S2, S1, S0: OUT STD_LOGIC
	);
END COMPONENT;

END my_components2m28bRCA;


LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.my_components1m28bRCA.all;
USE work.my_components2m28bRCA.all;


Entity RCA_radix4_8b is
	Port ( A, B: IN Std_Logic_Vector(7 downto 0);
	       S: OUT Std_Logic_Vector(15 downto 0)
	      );
	End RCA_radix4_8b;

Architecture RCAcomportamento25m28b of RCA_radix4_8b is
Signal W0, W1, W2, W3: Std_Logic_Vector(9 downto 0);
Signal F0, F1: std_logic_vector (7 downto 0);
Signal COUT0, COUT1, COUT2: std_logic_vector (3 downto 0);


Begin

-- Bloco de Multiplicação Radix-4

estagio0m28bRCA: RCAoperando1m28b PORT MAP (A(1), A(0),
                     B(7), B(6), B(5), B(4), B(3), B(2), B(1), B(0),
                     W0(7), W0(6), W0(5), W0(4), W0(3), W0(2), W0(1), W0(0), S(1), S(0));

estagio1m28bRCA: RCAoperando1m28b PORT MAP (A(3), A(2),
                     B(7), B(6), B(5), B(4), B(3), B(2), B(1), B(0),
                     W1(9), W1(8), W1(7), W1(6), W1(5), W1(4), W1(3), W1(2), W1(1), W1(0));

estagio2m28bRCA: RCAoperando1m28b PORT MAP (A(5), A(4),
                     B(7), B(6), B(5), B(4), B(3), B(2), B(1), B(0),
                     W2(9), W2(8), W2(7), W2(6), W2(5), W2(4), W2(3), W2(2), W2(1), W2(0));

estagio3m28bRCA: RCAoperando2m28b PORT MAP (A(7), A(6),
                     B(7), B(6), B(5), B(4), B(3), B(2), B(1), B(0),
                     W3(9), W3(8), W3(7), W3(6), W3(5), W3(4), W3(3), W3(2), W3(1), W3(0));


-- RCA Tree

estagio10RCA: RCAhalfadder_2Bitsm28b PORT MAP(W0(1), W0(0), W1(1), W1(0), COUT0(0), S(3), S(2)); 
estagio11RCA: RCAfulladder_2Bitsm28b PORT MAP(COUT0(0), W0(3), W0(2), W1(3), W1(2), COUT0(1), F0(1), F0(0)); 
estagio12RCA: RCAfulladder_2Bitsm28b PORT MAP(COUT0(1), W0(5), W0(4), W1(5), W1(4), COUT0(2), F0(3), F0(2)); 
estagio13RCA: RCAfulladder_2Bitsm28b PORT MAP(COUT0(2), W0(7), W0(6), W1(7), W1(6), COUT0(3), F0(5), F0(4)); 
estagio18RCA: RCAfulladder_npp_2Bitsm28b PORT MAP(COUT0(3), W0(7), W0(7), W1(9), W1(8), F0(7), F0(6)); 

estagio21RCA: RCAhalfadder_2Bitsm28b PORT MAP(F0(1), F0(0), W2(1), W2(0), COUT1(0), S(5), S(4)); 
estagio22RCA: RCAfulladder_2Bitsm28b PORT MAP(COUT1(0), F0(3), F0(2), W2(3), W2(2), COUT1(1), F1(1), F1(0)); 
estagio23RCA: RCAfulladder_2Bitsm28b PORT MAP(COUT1(1), F0(5), F0(4), W2(5), W2(4), COUT1(2), F1(3), F1(2)); 
estagio24RCA: RCAfulladder_2Bitsm28b PORT MAP(COUT1(2), F0(7), F0(6), W2(7), W2(6), COUT1(3), F1(5), F1(4)); 
estagio29RCA: RCAfulladder_npp_2Bitsm28b PORT MAP(COUT1(3), F0(7), F0(7), W2(9), W2(8), F1(7), F1(6)); 

estagio32RCA: RCAhalfadder_2Bitsm28b PORT MAP(F1(1), F1(0), W3(1), W3(0), COUT2(0), S(7), S(6)); 
estagio33RCA: RCAfulladder_2Bitsm28b PORT MAP(COUT2(0), F1(3), F1(2), W3(3), W3(2), COUT2(1), S(9), S(8)); 
estagio34RCA: RCAfulladder_2Bitsm28b PORT MAP(COUT2(1), F1(5), F1(4), W3(5), W3(4), COUT2(2), S(11), S(10)); 
estagio35RCA: RCAfulladder_2Bitsm28b PORT MAP(COUT2(2), F1(7), F1(6), W3(7), W3(6), COUT2(3), S(13), S(12)); 
estagio40RCA: RCAfulladder_npp_2Bitsm28b PORT MAP(COUT2(3), F1(7), F1(7), W3(9), W3(8), S(15), S(14)); 
End RCAcomportamento25m28b;
