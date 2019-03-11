class ahb_reset_agent extends uvm_agent;
`uvm_component_utils(ahb_reset_agent);

virtual ahb_if ahb_vif;
//uvm_analysis_port #(ahb_master_transaction) agent_ap;

ahb_reset_agent_config config_h;

ahb_reset_driver ahb_reset_drv;
ahb_reset_sequencer ahb_reset_sqr;

extern function new(string name="ahb_reset_agent",uvm_component parent=null);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern function void end_of_elaboration_phase(uvm_phase phase);

endclass : ahb_reset_agent

function ahb_reset_agent::new(string name="ahb_reset_agent",uvm_component parent=null);
	super.new(name,parent);
endfunction : new

function void ahb_reset_agent::build_phase(uvm_phase phase);
if(!uvm_config_db #(ahb_reset_agent_config)::get(this,"","ahb_reset_agent_config",config_h))
 `uvm_fatal("AHB_RESET_AGENT/NOCONFIG",{"configuration not set for : ",get_full_name(),".cfg"});

ahb_reset_drv = ahb_reset_driver::type_id::create("ahb_reset_drv",this);
ahb_reset_sqr = ahb_reset_sequencer::type_id::create("ahb_reset_sqr",this);

endfunction : build_phase

function void ahb_reset_agent::connect_phase(uvm_phase phase);
	ahb_reset_drv.seq_item_port.connect(ahb_reset_sqr.seq_item_export);
endfunction : connect_phase

function void ahb_reset_agent::end_of_elaboration_phase(uvm_phase phase);
`uvm_info("AHB_RESET_AGENT",{get_full_name()," created..."},UVM_MEDIUM);
endfunction : end_of_elaboration_phase
