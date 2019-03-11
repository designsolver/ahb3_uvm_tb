class ahb_env_config extends uvm_object;
`uvm_object_utils(ahb_env_config);

 bit has_coverage;

 ahb_master_agent_config master_cfg;
 ahb_slave_agent_config slave_cfg;

 virtual ahb_if ahb_vif;

extern function new(string name="ahb_env_config");

endclass : ahb_env_config

function ahb_env_config::new(string name="ahb_env_config");
	super.new(name);
endfunction : new

