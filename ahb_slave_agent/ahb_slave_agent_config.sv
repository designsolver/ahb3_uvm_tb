class ahb_slave_agent_config extends uvm_object;
`uvm_object_utils(ahb_slave_agent_config);

 uvm_active_passive_enum is_active;

 virtual ahb_if ahb_vif;

extern function new(string name="ahb_slave_agent_config");

endclass : ahb_slave_agent_config

function ahb_slave_agent_config::new(string name="ahb_slave_agent_config");
	super.new(name);
endfunction : new