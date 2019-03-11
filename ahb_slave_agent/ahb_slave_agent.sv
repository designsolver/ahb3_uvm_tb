class ahb_slave_agent extends uvm_agent;
 `uvm_component_utils(ahb_slave_agent);

 ahb_slave_agent_config config_h;
 
 ahb_slave_driver ahb_slave_drv;
 ahb_slave_monitor ahb_slave_mon;
 ahb_slave_sequencer ahb_slave_sqr;

 uvm_analysis_port #(ahb_slave_transaction) agent_ap;


extern function new(string name="ahb_slave_agent",uvm_component parent=null);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern function void end_of_elaboration_phase(uvm_phase phase);

endclass : ahb_slave_agent


function ahb_slave_agent::new(string name="ahb_slave_agent",uvm_component parent=null);
	super.new(name,parent);
	agent_ap = new("agent_ap",this);
endfunction

function void ahb_slave_agent::build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db #(ahb_slave_agent_config)::get(this,"","ahb_slave_agent_config",config_h))
	`uvm_fatal("AHB_SLAVE_AGENT/NOCONFIG",{"configuration is not set for :",get_full_name(),".cfg"});

	ahb_slave_mon = ahb_slave_monitor::type_id::create("ahb_slave_mon",this);

	if(config_h.is_active == UVM_ACTIVE)
	begin
	ahb_slave_drv = ahb_slave_driver::type_id::create("abh_slave_drv",this);
	ahb_slave_sqr = ahb_slave_sequencer::type_id::create("ahb_slave_sqr",this);
	end
endfunction : build_phase

function void ahb_slave_agent::connect_phase(uvm_phase phase);
	ahb_slave_mon.monitor_ap.connect(agent_ap);
	ahb_slave_drv.seq_item_port.connect(ahb_slave_sqr.seq_item_export);
endfunction : connect_phase

function void ahb_slave_agent::end_of_elaboration_phase(uvm_phase phase);
	`uvm_info("AHB_SLAVE_AGENT",{get_full_name()," created.."},UVM_NONE);
endfunction : end_of_elaboration_phase
