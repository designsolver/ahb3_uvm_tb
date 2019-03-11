class ahb_base_test extends uvm_test;
`uvm_component_utils(ahb_base_test);

ahb_env env_h;
 
bit has_coverage;

ahb_env_config env_config_h;

extern function new(string name="ahb_base_test",uvm_component parent=null);
extern function void build_phase(uvm_phase phase);
extern function void end_of_elaboration_phase(uvm_phase phase);
extern function void init_vseq(ahb_base_vseq vseq);

endclass : ahb_base_test

function ahb_base_test::new(string name="ahb_base_test",uvm_component parent=null);
	super.new(name,parent);
endfunction 

function void ahb_base_test::build_phase(uvm_phase phase);
	env_config_h = ahb_env_config::type_id::create("env_config_h");

	if(!uvm_config_db #(virtual ahb_if)::get(this,"","ahb_vif",env_config_h.ahb_vif))
	`uvm_fatal("AHB_BASE_TEST/NOVIF",{"virtual interface must be set for : ",get_full_name(),".vif"});

	has_coverage = 1;
	env_config_h.has_coverage = has_coverage;

	uvm_config_db #(ahb_env_config)::set(this,"*","ahb_env_config",env_config_h);

	env_h = ahb_env::type_id::create("env_h",this);
endfunction : build_phase

function void ahb_base_test::end_of_elaboration_phase(uvm_phase phase);
	`uvm_info("AHB_BASE_TEST",{get_full_name()," created.."},UVM_MEDIUM);
endfunction : end_of_elaboration_phase

function void ahb_base_test::init_vseq(ahb_base_vseq vseq);
	vseq.ahb_master_sqr = env_h.master_agent_h.ahb_master_sqr;
	vseq.ahb_slave_sqr = env_h.slave_agent_h.ahb_slave_sqr;
	vseq.ahb_reset_sqr = env_h.reset_agent_h.ahb_reset_sqr;
endfunction : init_vseq