# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "Bs" -parent ${Page_0}
  ipgui::add_param $IPINST -name "N" -parent ${Page_0}
  ipgui::add_param $IPINST -name "array_width" -parent ${Page_0}
  ipgui::add_param $IPINST -name "es" -parent ${Page_0}


}

proc update_PARAM_VALUE.Bs { PARAM_VALUE.Bs } {
	# Procedure called to update Bs when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.Bs { PARAM_VALUE.Bs } {
	# Procedure called to validate Bs
	return true
}

proc update_PARAM_VALUE.N { PARAM_VALUE.N } {
	# Procedure called to update N when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.N { PARAM_VALUE.N } {
	# Procedure called to validate N
	return true
}

proc update_PARAM_VALUE.array_width { PARAM_VALUE.array_width } {
	# Procedure called to update array_width when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.array_width { PARAM_VALUE.array_width } {
	# Procedure called to validate array_width
	return true
}

proc update_PARAM_VALUE.es { PARAM_VALUE.es } {
	# Procedure called to update es when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.es { PARAM_VALUE.es } {
	# Procedure called to validate es
	return true
}


proc update_MODELPARAM_VALUE.N { MODELPARAM_VALUE.N PARAM_VALUE.N } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.N}] ${MODELPARAM_VALUE.N}
}

proc update_MODELPARAM_VALUE.Bs { MODELPARAM_VALUE.Bs PARAM_VALUE.Bs } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.Bs}] ${MODELPARAM_VALUE.Bs}
}

proc update_MODELPARAM_VALUE.es { MODELPARAM_VALUE.es PARAM_VALUE.es } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.es}] ${MODELPARAM_VALUE.es}
}

proc update_MODELPARAM_VALUE.array_width { MODELPARAM_VALUE.array_width PARAM_VALUE.array_width } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.array_width}] ${MODELPARAM_VALUE.array_width}
}

