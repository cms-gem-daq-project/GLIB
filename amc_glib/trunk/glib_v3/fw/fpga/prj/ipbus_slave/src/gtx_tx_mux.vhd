library ieee;
use ieee.std_logic_1164.all;

library work;
use work.user_package.all;

entity gtx_tx_mux is
port(
    gtx_clk_i       : in std_logic;
    reset_i         : in std_logic;
    
    vfat2_en_i      : in std_logic;
    vfat2_data_i    : in std_logic_vector(31 downto 0);  
    
    tx_kchar_o      : out std_logic_vector(1 downto 0);
    tx_data_o       : out std_logic_vector(15 downto 0);
   
    priorities_i    : in std_logic_vector(6 downto 0)
);
end gtx_tx_mux;

architecture Behavioral of gtx_tx_mux is
begin
   
    process(gtx_clk_i) 
        
        -- State for sending
        variable state          : integer range 0 to 7 := 0;
        
        -- Data
        variable data           : std_logic_vector(31 downto 0) := (others => '0');
    
        -- Last kchar sent
        variable kchar_count    : integer range 0 to 1023 := 0;
        
        -- Input slave
        variable selected_core  : integer range 0 to 3 := 0;

    begin
    
        if (rising_edge(gtx_clk_i)) then
        
            -- Reset
            if (reset_i = '1') then
            
                tx_kchar_o <= "00";
                
                tx_data_o <= def_gtx_idle & x"BC";
                
                state := 0;
                
                selected_core := 0;
                
                kchar_count := 0;
                
            else
            
                if (priorities_i /= "0000000") then
                
                    -- Set kchar
                    tx_kchar_o <= "01";
                
                    -- LV1A
                    if (priorities_i(0) = '1') then
                        tx_data_o <= def_gtx_lv1a & x"BC";
                    -- CalPulse
                    elsif (priorities_i(1) = '1') then
                        tx_data_o <= def_gtx_calpulse & x"BC";
                    -- Resync
                    elsif (priorities_i(2) = '1') then
                        tx_data_o <= def_gtx_resync & x"BC";
                    -- BC0
                    elsif (priorities_i(3) = '1') then
                        tx_data_o <= def_gtx_bc0 & x"BC";
                    -- OptoHybrid reset
                    elsif (priorities_i(4) = '1') then
                        tx_data_o <= def_gtx_oh_res & x"BC";
                    -- VFAT2 hard reset
                    elsif (priorities_i(5) = '1') then
                        tx_data_o <= def_gtx_v_hres & x"BC";
                    -- VFAT2 soft reset
                    elsif (priorities_i(6) = '1') then
                        tx_data_o <= def_gtx_v_bres & x"BC"; 
                    end if;
            
                -- Normal state machine
                else
                
                    -- Ready to send data
                    if (state = 0) then
                    
                        -- VFAT2 Data is ready
                        if (vfat2_en_i = '1') then
                    
                            -- Get the data
                            data := vfat2_data_i;
                        
                            -- Set selected the core
                            selected_core := 1;
                        
                            -- Change state
                            state := 1;
                            
                        end if;
                        
                        -- Determine if kchar must be sent
                        if (kchar_count = 1023) then
                        
                            -- Set kchar
                            tx_kchar_o <= "01";
                            
                            tx_data_o <= def_gtx_idle & x"BC"; -- Idle code
                            
                            kchar_count := 0;
                            
                        else
                       
                            -- Clear kchar
                            tx_kchar_o <= "00";
                        
                            tx_data_o <= def_gtx_idle & x"BC"; -- Idle code
                            
                            kchar_count := kchar_count + 1;
                            
                        end if;                        
                    
                    -- Data 1
                    elsif (state = 1) then
                    
                        -- Set TX kchar
                        tx_kchar_o <= "01";
                        
                        -- Send data header according to slave
                        if (selected_core = 1) then
                        
                            -- Set the TX data
                            tx_data_o <= def_gtx_vfat2 & x"BC"; -- VFAT2 IIC code
                        
                            -- Next state
                            state := 2;
                            
                        else
                        
                            tx_data_o <= def_gtx_idle & x"BC"; -- Idle code
                            
                            state := 0;
                        
                        end if;
                        
                   -- Data 2
                    elsif (state = 2) then
                    
                        -- Set TX kchar
                        tx_kchar_o <= "00";
                        
                        -- Set the TX data
                        tx_data_o <= data(31 downto 16);
                        
                        -- Next state
                        state := 3;
                        
                    -- Data 3
                    elsif (state = 3) then
                    
                        -- Set TX kchar
                        tx_kchar_o <= "00";
                        
                        -- Set the TX data
                        tx_data_o <= data(15 downto 0);
                        
                        -- Reset state
                        state := 0;
                        
                    -- Out of FSM
                    else
                
                        tx_kchar_o <= "00";
                        
                        tx_data_o <= def_gtx_idle & x"BC";
                        
                        state := 0;
                    
                        selected_core := 0;
                        
                        kchar_count := 0;
                        
                    end if;
                    
                end if;
                
            end if;
            
        end if;
        
    end process;

end Behavioral;