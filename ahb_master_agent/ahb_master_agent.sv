class ahb_master_agent extends uvm_agent;
`uvm_component_utils(ahb_master_agent);

 uvm_analysis_port #(ahb_master_transaction) agent_ap;

 ahb_master_driver ahb_master_drv;
 ahb_master_monitor ahb_master_mon;
 ahb_master_sequencer ahb_master_sqr;

 ahb_master_agent_config cfg_h;

extern function new(string name="ahb_master_agent",uvm_component parent=null);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern function void end_of_elaboration_phase(uvm_phase phase);

endclass : ahb_master_agent

function ahb_master_agent::new(string name="ahb_master_agent",uvm_component parent=null);
	super.new(name,parent);
	agent_ap = new("agent_ap",this);
endfunction : new

function void ahb_master_agent::build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db #(ahb_master_agent_config)::get(this,"ahb_master_agent","ahb_master_agent_config",cfg_h))
	`uvm_fatal("AHB_MASTER_AGENT",{"unable to retrieve configuration for : ",get_full_name(),".cfg"});
	 
	if(cfg_h.is_active == UVM_ACTIVE)
	begin
	ahb_master_drv = ahb_master_driver::type_id::create("ahb_master_drv",this);
	ahb_master_sqr = ahb_master_sequencer::type_id::create("ahb_master_sqr",this);
	end
	ahb_master_mon = ahb_master_monitor::type_id::create("ahb_master_mon",this);
endfunction : build_phase

function void ahb_master_agent::connect_phase(uvm_phase phase);
	ahb_master_drv.seq_item_port.connect(ahb_master_sqr.seq_item_export);
	ahb_master_mon.monitor_ap.connect(agent_ap);
endfunction : connect_phase

function void ahb_master_agent::end_of_elaboration_phase(uvm_phase phase);
	`uvm_info("AHB_MASTER_AGENT",{get_full_name()," created...."},UVM_NONE);
endfunction : end_of_elaboration_phase
