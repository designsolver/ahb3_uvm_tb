class ahb_reset_driver extends uvm_driver #(ahb_master_transaction);
`uvm_component_utils(ahb_reset_driver);

ahb_reset_agent_config config_h;
virtual ahb_if ahb_vif;

extern function new(string name="ahb_reset_driver",uvm_component parent=null);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern function void end_of_elaboration_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task reset();

endclass : ahb_reset_driver

function ahb_reset_driver::new(string name="ahb_reset_driver",uvm_component parent=null);
	super.new(name,parent);
endfunction : new

function void ahb_reset_driver::build_phase(uvm_phase phase);
if(!uvm_config_db #(ahb_reset_agent_config)::get(this,"","ahb_reset_agent_config",config_h))
`uvm_fatal("AHB_RESET_AGENT/NOCONFIG",{"configuration not set for :",get_full_name(),".cfg"});
endfunction : build_phase

function void ahb_reset_driver::connect_phase(uvm_phase phase);
	ahb_vif = config_h.ahb_vif;
endfunction : connect_phase

function void ahb_reset_driver::end_of_elaboration_phase(uvm_phase phase);
	`uvm_info("AHB_RESET_DRIVER",{get_full_name()," created.."},UVM_MEDIUM);
endfunction : end_of_elaboration_phase

task ahb_reset_driver::run_phase(uvm_phase phase);
      //phase.raise_objection(this,"starting reset driver");
	forever
	begin
	seq_item_port.get_next_item(req);
	reset();
	seq_item_port.item_done();
	end
      //phase.drop_objection(this,"ending reset driver");
endtask : run_phase

task ahb_reset_driver::reset();
	@(ahb_vif.reset_drv_cb);
	ahb_vif.HRESETn <= req.HRESETn;
	ahb_vif.reset_drv_cb.HADDR <= '0;
	ahb_vif.reset_drv_cb.HSIZE <= '1;
	ahb_vif.reset_drv_cb.HBURST <= IDLE;
	ahb_vif.reset_drv_cb.HWRITE <= req.HWRITE;
	ahb_vif.reset_drv_cb.HTRANS <= req.HTRANS[0];
	ahb_vif.reset_drv_cb.HWDATA <= '0;
endtask : reset