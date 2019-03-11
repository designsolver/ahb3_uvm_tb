class ahb_env extends uvm_env;
`uvm_component_utils(ahb_env);

ahb_env_config env_config_h;

ahb_master_agent_config master_cfg_h;
ahb_slave_agent_config slave_cfg_h;
ahb_reset_agent_config reset_cfg_h;

ahb_master_agent master_agent_h;
ahb_slave_agent slave_agent_h;
ahb_reset_agent reset_agent_h;

bit has_coverage;

ahb_coverage cov_h;

extern function new(string name="ahb_env",uvm_component parent=null);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern function void end_of_elaboration_phase(uvm_phase phase);

endclass : ahb_env

function ahb_env::new(string name="ahb_env",uvm_component parent=null);
	super.new(name,parent);
endfunction : new

function void ahb_env::build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db #(ahb_env_config)::get(this,"","ahb_env_config",env_config_h))
	`uvm_fatal("AHB_ENV/NOCONFIG",{"Configuation not set for : ",get_full_name(),".cfg"});
	
	has_coverage = env_config_h.has_coverage;

	master_cfg_h = ahb_master_agent_config::type_id::create("master_cfg_h");
	slave_cfg_h = ahb_slave_agent_config::type_id::create("slave_cfg_h");
	reset_cfg_h = ahb_reset_agent_config::type_id::create("reset_cfg_h");

	master_cfg_h.ahb_vif = env_config_h.ahb_vif;
	slave_cfg_h.ahb_vif = env_config_h.ahb_vif;	
	reset_cfg_h.ahb_vif = env_config_h.ahb_vif;

	master_cfg_h.is_active = UVM_ACTIVE;
	slave_cfg_h.is_active = UVM_ACTIVE;

	uvm_config_db #(ahb_master_agent_config)::set(this,"*master*","ahb_master_agent_config",master_cfg_h);
	uvm_config_db #(ahb_slave_agent_config)::set(this,"*slave*","ahb_slave_agent_config",slave_cfg_h);
	uvm_config_db #(ahb_reset_agent_config)::set(this,"*reset*","ahb_reset_agent_config",reset_cfg_h);

	master_agent_h = ahb_master_agent::type_id::create("master_agent_h",this);
	slave_agent_h = ahb_slave_agent::type_id::create("slave_agent_h",this);
	reset_agent_h = ahb_reset_agent::type_id::create("reset_agent_h",this);

	if(has_coverage)
	cov_h = ahb_coverage::type_id::create("cov_h",this);

endfunction : build_phase

function void ahb_env::connect_phase(uvm_phase phase);
	if(has_coverage)
	begin
	master_agent_h.agent_ap.connect(cov_h.analysis_export);
  //slave_agent_h.agent_ap.connect(cov_h.analysis_export);
	end

endfunction : connect_phase

function void ahb_env::end_of_elaboration_phase(uvm_phase phase);
	`uvm_info("AHB_ENV",{get_full_name()," created..."},UVM_MEDIUM);
endfunction : end_of_elaboration_phase



