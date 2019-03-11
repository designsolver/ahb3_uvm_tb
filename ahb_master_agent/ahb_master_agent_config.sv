class ahb_master_agent_config extends uvm_object;
`uvm_object_utils(ahb_master_agent_config);

virtual ahb_if ahb_vif;

uvm_active_passive_enum is_active;

extern function new(string name="ahb_master_agent_config");

endclass : ahb_master_agent_config

function ahb_master_agent_config::new(string name="ahb_master_agent_config");
	super.new(name);
endfunction : new