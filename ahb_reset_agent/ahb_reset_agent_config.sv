class ahb_reset_agent_config extends uvm_object;
`uvm_object_utils(ahb_reset_agent_config);

virtual ahb_if ahb_vif;

extern function new(string name="ahb_reset_agent_config");

endclass : ahb_reset_agent_config

function ahb_reset_agent_config::new(string name="ahb_reset_agent_config");
	super.new(name);
endfunction : new
