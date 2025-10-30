LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity BoothParalelo8b is
  port(
        A      : in std_logic_vector(7 downto 0);
        B      : in std_logic_vector(7 downto 0);
        S  : out std_logic_vector(15 downto 0)
      );
end BoothParalelo8b;

architecture BoothP of BoothParalelo8b is

  signal passamd1 : std_logic;
  signal shiftmd1 : std_logic;
  signal aux      : std_logic_vector(8 downto 0);
  signal caux     : std_logic_vector(7 downto 0);
  signal pp       : std_logic_vector(35 downto 0);
  signal zero     : std_logic;
  signal um       : std_logic;
  signal passamd2 : std_logic;
  signal shiftmd2 : std_logic;
  signal passamd3 : std_logic;
  signal shiftmd3 : std_logic;
  signal passamd4 : std_logic;
  signal shiftmd4 : std_logic;
  signal soma     : std_logic_vector(26 downto 0);
  signal c        : std_logic_vector(26 downto 0);

begin

--------------------------- Início da parte operativa -------------------------------

  zero <= '0';
  um   <= '1';

-- Circuito para a determinação do primeiro produto parcial

  passamd1 <= A(0) xor zero;
  shiftmd1 <= (A(1) nor (A(0) nand zero)) or (A(1) and (A(0) nor zero));

  aux(0) <= A(1) xor (B(0) and passamd1);
 
  aux(1) <= A(1) xor ((B(1) and passamd1) or (B(0) and shiftmd1));
  aux(2) <= A(1) xor ((B(2) and passamd1) or (B(1) and shiftmd1));
  aux(3) <= A(1) xor ((B(3) and passamd1) or (B(2) and shiftmd1));
  aux(4) <= A(1) xor ((B(4) and passamd1) or (B(3) and shiftmd1));
  aux(5) <= A(1) xor ((B(5) and passamd1) or (B(4) and shiftmd1));
  aux(6) <= A(1) xor ((B(6) and passamd1) or (B(5) and shiftmd1));
  aux(7) <= A(1) xor ((B(7) and passamd1) or (B(6) and shiftmd1));
  aux(8) <= A(1) xor ((B(7) and passamd1) or (B(7) and shiftmd1));
  

  pp(0) <= aux(0) xor A(1); caux(0) <= aux(0) and A(1);
  
  pp(1) <= aux(1) xor caux(0); caux(1) <= aux(1) and caux(0);
  pp(2) <= aux(2) xor caux(1); caux(2) <= aux(2) and caux(1);
  pp(3) <= aux(3) xor caux(2); caux(3) <= aux(3) and caux(2);
  pp(4) <= aux(4) xor caux(3); caux(4) <= aux(4) and caux(3);
  pp(5) <= aux(5) xor caux(4); caux(5) <= aux(5) and caux(4);
  pp(6) <= aux(6) xor caux(5); caux(6) <= aux(6) and caux(5);
  pp(7) <= aux(7) xor caux(6); caux(7) <= aux(7) and caux(6);
  pp(8) <= aux(8) xor caux(7);  

  
-- Circuito para a determinação do segundo produto parcial

  passamd2 <= A(2) xor A(1);
  shiftmd2 <= (A(3) nor (A(2) nand A(1))) or (A(3) and (A(2) nor A(1)));

  pp(9) <= A(3) xor (B(0) and passamd2);
 
  pp(10) <= A(3) xor ((B(1) and passamd2) or (B(0) and shiftmd2));
  pp(11) <= A(3) xor ((B(2) and passamd2) or (B(1) and shiftmd2));
  pp(12) <= A(3) xor ((B(3) and passamd2) or (B(2) and shiftmd2));
  pp(13) <= A(3) xor ((B(4) and passamd2) or (B(3) and shiftmd2));
  pp(14) <= A(3) xor ((B(5) and passamd2) or (B(4) and shiftmd2));
  pp(15) <= A(3) xor ((B(6) and passamd2) or (B(5) and shiftmd2));
  pp(16) <= A(3) xor ((B(7) and passamd2) or (B(6) and shiftmd2));
  pp(17) <= A(3) xor ((B(7) and passamd2) or (B(7) and shiftmd2));
   

-- Circuito para a determinação do terceiro produto parcial

  passamd3 <= A(4) xor A(3);
  shiftmd3 <= (A(5) nor (A(4) nand A(3))) or (A(5) and (A(4) nor A(3)));

  pp(18) <= A(5) xor (B(0) and passamd3);
 
  pp(19) <= A(5) xor ((B(1) and passamd3) or (B(0) and shiftmd3));
  pp(20) <= A(5) xor ((B(2) and passamd3) or (B(1) and shiftmd3));
  pp(21) <= A(5) xor ((B(3) and passamd3) or (B(2) and shiftmd3));
  pp(22) <= A(5) xor ((B(4) and passamd3) or (B(3) and shiftmd3));
  pp(23) <= A(5) xor ((B(5) and passamd3) or (B(4) and shiftmd3));
  pp(24) <= A(5) xor ((B(6) and passamd3) or (B(5) and shiftmd3));
  pp(25) <= A(5) xor ((B(7) and passamd3) or (B(6) and shiftmd3));
  pp(26) <= A(5) xor ((B(7) and passamd3) or (B(7) and shiftmd3));
    

-- Circuito para a determinação do quarto produto parcial

  passamd4 <= A(6) xor A(5);
  shiftmd4 <= (A(7) nor (A(6) nand A(5))) or (A(7) and (A(6) nor A(5)));

  pp(27) <= A(7) xor (B(0) and passamd4);
 
  pp(28) <= A(7) xor ((B(1) and passamd4) or (B(0) and shiftmd4));
  pp(29) <= A(7) xor ((B(2) and passamd4) or (B(1) and shiftmd4));
  pp(30) <= A(7) xor ((B(3) and passamd4) or (B(2) and shiftmd4));
  pp(31) <= A(7) xor ((B(4) and passamd4) or (B(3) and shiftmd4));
  pp(32) <= A(7) xor ((B(5) and passamd4) or (B(4) and shiftmd4));
  pp(33) <= A(7) xor ((B(6) and passamd4) or (B(5) and shiftmd4));
  pp(34) <= A(7) xor ((B(7) and passamd4) or (B(6) and shiftmd4));
  pp(35) <= A(7) xor ((B(7) and passamd4) or (B(7) and shiftmd4));
    

-- Soma do primero e segundo produtos parciais

  soma(0) <= pp(2) xor pp(9) xor A(3);
  c(0) <= ((pp(2) xor pp(9)) and A(3)) or (pp(2) and pp(9));

  soma(1) <= pp(3) xor pp(10) xor c(0);
  c(1) <= ((pp(3) xor pp(10)) and c(0)) or (pp(3) and pp(10));

  soma(2) <= pp(4) xor pp(11) xor c(1);
  c(2) <= ((pp(4) xor pp(11)) and c(1)) or (pp(4) and pp(11));

  soma(3) <= pp(5) xor pp(12) xor c(2);
  c(3) <= ((pp(5) xor pp(12)) and c(2)) or (pp(5) and pp(12));

  soma(4) <= pp(6) xor pp(13) xor c(3);
  c(4) <= ((pp(6) xor pp(13)) and c(3)) or (pp(6) and pp(13));

  soma(5) <= pp(7) xor pp(14) xor c(4);
  c(5) <= ((pp(7) xor pp(14)) and c(4)) or (pp(7) and pp(14));

  soma(6) <= pp(8) xor pp(15) xor c(5);
  c(6) <= ((pp(8) xor pp(15)) and c(5)) or (pp(8) and pp(15));

  soma(7) <= pp(8) xor pp(16) xor c(6);
  c(7) <= ((pp(8) xor pp(16)) and c(6)) or (pp(8) and pp(16));

  soma(8) <= pp(8) xor pp(17) xor c(7);
  

-- Soma do terceiro produto parcial

  soma(9) <= soma(2) xor pp(18) xor A(5);
  c(9) <= ((soma(2) xor pp(18)) and A(5)) or (soma(2) and pp(18));

  soma(10) <= soma(3) xor pp(19) xor c(9);
  c(10) <= ((soma(3) xor pp(19)) and c(9)) or (soma(3) and pp(19));

  soma(11) <= soma(4) xor pp(20) xor c(10);
  c(11) <= ((soma(4) xor pp(20)) and c(10)) or (soma(4) and pp(20));

  soma(12) <= soma(5) xor pp(21) xor c(11);
  c(12) <= ((soma(5) xor pp(21)) and c(11)) or (soma(5) and pp(21));

  soma(13) <= soma(6) xor pp(22) xor c(12);
  c(13) <= ((soma(6) xor pp(22)) and c(12)) or (soma(6) and pp(22));

  soma(14) <= soma(7) xor pp(23) xor c(13);
  c(14) <= ((soma(7) xor pp(23)) and c(13)) or (soma(7) and pp(23));

  soma(15) <= soma(8) xor pp(24) xor c(14);
  c(15) <= ((soma(8) xor pp(24)) and c(14)) or (soma(8) and pp(24));

  soma(16) <= soma(8) xor pp(25) xor c(15);
  c(16) <= ((soma(8) xor pp(25)) and c(15)) or (soma(8) and pp(25));

  soma(17) <= soma(8) xor pp(26) xor c(16);

  
-- Soma do quarto produto parcial

  soma(18) <= soma(11) xor pp(27) xor A(7);
  c(18) <= ((soma(11) xor pp(27)) and A(7)) or (soma(11) and pp(27));

  soma(19) <= soma(12) xor pp(28) xor c(18);
  c(19) <= ((soma(12) xor pp(28)) and c(18)) or (soma(12) and pp(28));

  soma(20) <= soma(13) xor pp(29) xor c(19);
  c(20) <= ((soma(13) xor pp(29)) and c(19)) or (soma(13) and pp(29));

  soma(21) <= soma(14) xor pp(30) xor c(20);
  c(21) <= ((soma(14) xor pp(30)) and c(20)) or (soma(14) and pp(30));

  soma(22) <= soma(15) xor pp(31) xor c(21);
  c(22) <= ((soma(15) xor pp(31)) and c(21)) or (soma(15) and pp(31));

  soma(23) <= soma(16) xor pp(32) xor c(22);
  c(23) <= ((soma(16) xor pp(32)) and c(22)) or (soma(16) and pp(32));

  soma(24) <= soma(17) xor pp(33) xor c(23);
  c(24) <= ((soma(17) xor pp(33)) and c(23)) or (soma(17) and pp(33));

  soma(25) <= soma(17) xor pp(34) xor c(24);
  c(25) <= ((soma(17) xor pp(34)) and c(24)) or (soma(17) and pp(34));

  soma(26) <= soma(17) xor pp(35) xor c(25);


  c(8) <= zero;
  c(17) <= zero;
  c(26) <= zero;
  
  
-- Saida do circuito multiplicador

S(0) <= pp(0);
S(1) <= pp(1);
S(2) <= soma(0);
S(3) <= soma(1);
S(4) <= soma(9);
S(5) <= soma(10);
S(6) <= soma(18);
S(7) <= soma(19);
S(8) <= soma(20);
S(9) <= soma(21);
S(10) <= soma(22);
S(11) <= soma(23);
S(12) <= soma(24);
S(13) <= soma(25);
S(14) <= soma(26);
S(15) <= soma(26);

end BoothP;
