library ieee;
use ieee.std_logic_1164.all;

library work;
use work.user_package.all;

entity gtx_rx_mux is
port(
    gtx_clk_i       : in std_logic;
    reset_i         : in std_logic;
    
    vfat2_en_o      : out std_logic;
    vfat2_data_o    : out std_logic_vector(31 downto 0);
  
    rx_kchar_i      : in std_logic_vector(1 downto 0);
    rx_data_i       : in std_logic_vector(15 downto 0)
);
end gtx_rx_mux;

architecture Behavioral of gtx_rx_mux is
begin
      
    process(gtx_clk_i) 
    
        -- State machine
        variable state          : integer range 0 to 7 := 0;
    
        -- Incomming data
        variable data           : std_logic_vector(31 downto 0) := (others => '0');
        
        -- Output slave
        variable selected_core  : integer range 0 to 3 := 0;
    
    begin
    
        if (rising_edge(gtx_clk_i)) then
        
            -- Reset
            if (reset_i = '1') then
                
                vfat2_en_o <= '0';
                
                selected_core := 0;
                
                state := 0;
                
            else
            
                -- Wait for kchar
                if (state = 0) then
                
                    -- Detect data package
                    if (rx_kchar_i = "01") then
                    
                        -- VFAT2 data packet
                        if (rx_data_i = def_gtx_vfat2 & x"BC") then
                        
                            -- Set selected the core
                            selected_core := 1;
                            
                            -- Select slave
                            state := 1;
                            
                        end if;  
                        
                    end if;
                    
                    vfat2_en_o <= '0';
                   
                -- Data 1
                elsif (state = 1) then
                
                    if (rx_kchar_i = "00") then
                    
                        -- Save the data
                        data(31 downto 16) := rx_data_i;
                        
                        state := 2;
                    
                    else 
                    
                        state := 0;
                        
                    end if;
                    
                -- Data 2
                elsif (state = 2) then
                
                    if (rx_kchar_i = "00") then
                    
                        -- Save the data
                        data(15 downto 0) := rx_data_i;
                        
                        -- Acknowledge the selected core
                        if (selected_core = 1) then
                        
                            -- Set the ipbus data
                            vfat2_data_o <= data(31 downto 0);
                        
                            -- Storbe
                            vfat2_en_o <= '1';
                        
                        end if;
                    
                    end if;
                    
                    state := 0;
                
                -- Out of FSM
                else
                
                    vfat2_en_o <= '0';
                
                    selected_core := 0;
                
                    state := 0;
                    
                end if;
                
            end if;
            
        end if;
        
    end process;
    
end Behavioral;
