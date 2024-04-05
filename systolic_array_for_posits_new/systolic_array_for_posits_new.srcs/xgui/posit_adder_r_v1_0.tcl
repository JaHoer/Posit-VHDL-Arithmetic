# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "N" -parent ${Page_0}
  ipgui::add_param $IPINST -name "es" -parent ${Page_0}
  ipgui::add_param $IPINST -name "pipeline_num" -parent ${Page_0}


}

proc update_PARAM_VALUE.N { PARAM_VALUE.N } {
	# Procedure called to update N when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.N { PARAM_VALUE.N } {
	# Procedure called to validate N
	return true
}

proc update_PARAM_VALUE.es { PARAM_VALUE.es } {
	# Procedure called to update es when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.es { PARAM_VALUE.es } {
	# Procedure called to validate es
	return true
}

proc update_PARAM_VALUE.pipeline_num { PARAM_VALUE.pipeline_num } {
	# Procedure called to update pipeline_num when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.pipeline_num { PARAM_VALUE.pipeline_num } {
	# Procedure called to validate pipeline_num
	return true
}


proc update_MODELPARAM_VALUE.N { MODELPARAM_VALUE.N PARAM_VALUE.N } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.N}] ${MODELPARAM_VALUE.N}
}

proc update_MODELPARAM_VALUE.es { MODELPARAM_VALUE.es PARAM_VALUE.es } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.es}] ${MODELPARAM_VALUE.es}
}

proc update_MODELPARAM_VALUE.pipeline_num { MODELPARAM_VALUE.pipeline_num PARAM_VALUE.pipeline_num } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.pipeline_num}] ${MODELPARAM_VALUE.pipeline_num}
}

