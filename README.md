# Posit-VHDL-Arithmetic

This is a implementation of simple posit adder and multiplier components, which are used for a weight stationary systolic array. <br />

The posit components can perform the operations '+', '-', and '*'.  <br />
They perform simple RoundTiesToEven rounding as described in the official posit standard (https://posithub.org/docs/posit_standard-2.pdf). <br />

The posit components are based on the Verilog Project "Posit-HDL-Arithmetic" by Manish Kumar Jaiswal. <br />
You can find that Project here: https://github.com/manish-kj/Posit-HDL-Arithmetic



The systolic_array_for_posits_new folder contains the final working version of the implementation.  <br />
This includes:  <br />
    - Posit adder   <br />
    - Posit multiplier  <br />
    - systolic array components like a controller, the processing elements and the memory modules.  <br />

The source files can be found at: systolic_array_for_posits_new/systolic_array_for_posits_new.srcs/sources_1/new/ <br />


The systolic_array_for_Posits folder has a broken project file but contains some of the used testbenches. 
