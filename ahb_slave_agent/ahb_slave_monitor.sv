class ahb_slave_monitor extends uvm_monitor;
 `uvm_component_utils(ahb_slave_monitor);

 ahb_slave_agent_config config_h;
 virtual ahb_if ahb_vif;

 uvm_analysis_port #(ahb_slave_transaction) monitor_ap;

 extern function new(string name="ahb_slave_monitor",uvm_component parent=null);
 extern function void build_phase(uvm_phase phase);
 extern function void connect_phase(uvm_phase phase);
 extern function void end_of_elaboration_phase(uvm_phase phase);
 extern task run_phase(uvm_phase phase);
 extern task monitor();

endclass : ahb_slave_monitor

function ahb_slave_monitor::new(string name="ahb_slave_monitor",uvm_component parent=null);
	super.new(name,parent);
	monitor_ap = new("monitor_ap",this);
endfunction : new

function void ahb_slave_monitor::build_phase(uvm_phase phase);
 super.build_phase(phase);
 if(!uvm_config_db #(ahb_slave_agent_config)::get(this,"","ahb_slave_agent_config",config_h))
	`uvm_fatal("AHB_SLAVE_MONITOR/NOCONFIG",{"configuration not set for ",get_full_name(),".cfg"});
endfunction : build_phase

function void ahb_slave_monitor::connect_phase(uvm_phase phase);
 ahb_vif = config_h.ahb_vif;
endfunction : connect_phase

function void ahb_slave_monitor::end_of_elaboration_phase(uvm_phase phase);
 `uvm_info("AHB_SLAVE_MONITOR",{get_full_name()," created..."},UVM_MEDIUM);
endfunction : end_of_elaboration_phase

task ahb_slave_monitor::run_phase(uvm_phase phase);
	phase.raise_objection(this,"starting slave monitor");


	phase.drop_objection(this,"ending slave monitor");
endtask : run_phase

task ahb_slave_monitor::monitor();

endtask : monitor