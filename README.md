# Posit-VHDL-Arithmetic

This is a implementation of simple posit adder and multiplier components, which are used for a weight stationary systolic array.

The posit components can perform the operations '+', '-', and '*'
They perform simple RoundTiesToEven rounding as describen in the official posit standard (https://posithub.org/docs/posit_standard-2.pdf)

The posit components are based on the Verilog Project "Posit-HDL-Arithmetic" by Manish Kumar Jaiswal.
You can find that Project here: https://github.com/manish-kj/Posit-HDL-Arithmetic



The systolic_array_for_posits_new folder contains the final working version of the implementation.
This includes:
    - Posit adder
    - Posit multiplier
    - systolic array components like a controller, the processing elements and the memory modules.

The source files can be found at: systolic_array_for_posits_new/systolic_array_for_posits_new.srcs/sources_1/new/


The systolic_array_for_Posits folder has a broken project file but contains some of the used testbenches.
