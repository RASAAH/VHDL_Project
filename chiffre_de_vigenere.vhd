library ieee ;
use ieee.std_logic_1164 .all ; 
use ieee.numeric_std.all ; 
use ieee.std_logic_unsigned.all;

entity chiffre_de_vigenere is 
 port ( message_entree : in  std_logic_vector(6 downto 0 );
        key            : in  std_logic_vector (6 downto 0);
		  reset          : in  std_logic;
		  encry          : in  std_logic;
		  decry          : in  std_logic;
		  clock          : in  std_logic;
		  message_sortie : out std_logic_vector (6 downto 0));		  
end entity ;
architecture cs of chiffre_de_vigenere is 
component stockage_key is
 port (key_entree      : in std_logic_vector(6 downto 0 )  ; 
       clk             : in std_logic                      ;
       reset           : in std_logic                      ; 
		 R_1_sortie      : out std_logic_vector(6 downto 0 ) ;
		 R_2_sortie      : out std_logic_vector(6 downto 0 ) ;
		 R_3_sortie      : out std_logic_vector(6 downto 0 ) ;
		 R_4_sortie      : out std_logic_vector(6 downto 0 ) ;
		 R_5_sortie      : out std_logic_vector(6 downto 0 ) ;
		 R_6_sortie      : out std_logic_vector(6 downto 0 ) ;
		 R_7_sortie      : out std_logic_vector(6 downto 0 ) ;
		 R_8_sortie      : out std_logic_vector(6 downto 0 ) ;
		 R_9_sortie      : out std_logic_vector(6 downto 0 ) ;
		 R_10_sortie     : out std_logic_vector(6 downto 0 ) );
end component ; 
component incre_mux is 
 port (presence_on     : in std_logic ;
       reset           : in std_logic ;
       position        : out std_logic_vector(3 downto 0  ));
end component ;
component mux_10_1 is 
 port ( key : out std_logic_vector (6 downto 0 ) ;
	       position : in std_logic_vector(3 downto 0 ) ; 
	       R1 : in std_logic_vector (6 downto 0);
			 R2 : in std_logic_vector (6 downto 0);
			 R3 : in std_logic_vector (6 downto 0);
			 R4 : in std_logic_vector (6 downto 0);
			 R5 : in std_logic_vector (6 downto 0);
			 R6 : in std_logic_vector (6 downto 0);
			 R7 : in std_logic_vector (6 downto 0);
			 R8 : in std_logic_vector (6 downto 0);
			 R9 : in std_logic_vector (6 downto 0);
			 R10: in std_logic_vector(6 downto 0));
end component ;
component  add is 
 port (  encry : in std_logic ;
         decry : in std_logic ;
         x     : in  std_logic_vector(6 downto 0 );
         key   : in  std_logic_vector (6 downto 0);
		   R     : out std_logic_vector (6 downto 0));
end component ;
component presence_test is 
 port(
        presence_on   : out  STD_LOGIC ;
        message_entree: in std_logic_vector(6 downto 0 ));
end component ;
signal  presence_message : std_logic;
signal  position         : std_logic_vector(3 downto 0);
signal R1       : std_logic_vector( 6 downto 0 );
signal R2       : std_logic_vector( 6 downto 0 );
signal R3       : std_logic_vector( 6 downto 0 );
signal R4       : std_logic_vector( 6 downto 0 );
signal R5       : std_logic_vector( 6 downto 0 );
signal R6       : std_logic_vector( 6 downto 0 );
signal R7       : std_logic_vector( 6 downto 0 );
signal R8       : std_logic_vector( 6 downto 0 );
signal R9       : std_logic_vector( 6 downto 0 );
signal R10      : std_logic_vector( 6 downto 0 );
signal x        : std_logic_vector( 6 downto 0 );
begin 
incrementeur : incre_mux port map (
               presence_on  =>  presence_message , 
               reset        =>  reset, 
               position     =>   position);
test :   presence_test port map (
               presence_on    => presence_message,
               message_entree =>	message_entree);
ram :  stockage_key port map(
               key_entree  => key ,  
               clk         => clock, 
               reset       =>  reset,   
		         R_1_sortie  => R1 ,  
		         R_2_sortie  => R2 ,
		         R_3_sortie  => R3 , 
		         R_4_sortie  => R4 ,
		         R_5_sortie  => R5 , 
		         R_6_sortie  => R6 ,
		         R_7_sortie  => R7 ,  
		         R_8_sortie  => R8 , 
		         R_9_sortie  => R9 ,
		         R_10_sortie => R10  );	
mux :  mux_10_1 port map (
          key      => x,
	       position => position,
	       R1      => R1,
			 R2      => R2,
			 R3      => R3,
			 R4      => R4,
			 R5      => R5,
			 R6      => R6,
			 R7      => R7,
			 R8      => R8,
			 R9      => R9,
			 R10     => R10);
enry_decry : add port map(
         encry   => encry,
         decry   => decry,
         x       => x,
         key     =>  message_entree,
		   R       => message_sortie );

end cs;
