class ahb_master_driver extends uvm_driver #(ahb_master_transaction);
`uvm_component_utils(ahb_master_driver);

 ahb_master_agent_config master_config_h;
 virtual ahb_if.master_drv ahb_vif;

 extern function new(string name="ahb_master_driver",uvm_component parent=null);
 extern function void build_phase(uvm_phase phase);
 extern function void connect_phase(uvm_phase phase);
 extern function void end_of_elaboration_phase(uvm_phase phase);
 extern task run_phase(uvm_phase phase);
 extern task drive();

endclass : ahb_master_driver

function ahb_master_driver::new(string name="ahb_master_driver",uvm_component parent=null);
	super.new(name,parent);
endfunction : new

function void ahb_master_driver::build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db #(ahb_master_agent_config)::get(this,"","ahb_master_agent_config",master_config_h))
	 `uvm_fatal("AHB_MASTER_DRIVER/NOCOFIG",{"Configuration must be set for : " ,get_full_name(),".master_config_h"});
endfunction : build_phase

function void ahb_master_driver::connect_phase(uvm_phase phase);
	ahb_vif = master_config_h.ahb_vif;
endfunction : connect_phase

function void ahb_master_driver::end_of_elaboration_phase(uvm_phase phase);
	`uvm_info("AHB_MASTER_DRIVER",{get_full_name()," Created.."},UVM_MEDIUM);
endfunction : end_of_elaboration_phase

task ahb_master_driver::run_phase(uvm_phase phase);
      //phase.raise_objection(this,"starting driver");
	forever
	begin
	seq_item_port.get_next_item(req);
	drive();
	seq_item_port.item_done();
	end
      //phase.raise_objection(this,"ending driver");
endtask : run_phase

task ahb_master_driver::drive();
	while(!ahb_vif.HRESETn) 
		@(ahb_vif.mst_drv_cb);
	void'(req.add_busy_cycles());
	//req.print();
	@(ahb_vif.mst_drv_cb);
	ahb_vif.mst_drv_cb.HWRITE <= req.HWRITE;
	ahb_vif.mst_drv_cb.HSIZE <= req.HSIZE;
	ahb_vif.mst_drv_cb.HBURST <= req.HBURST;
	foreach(req.HADDR[i])
	begin
		foreach(req.HTRANS[j])
		begin
			while(!ahb_vif.mst_drv_cb.HREADY)
				@(ahb_vif.mst_drv_cb);
			if(req.HTRANS[j] != BUSY)
			begin
				ahb_vif.mst_drv_cb.HADDR <= req.HADDR[i];
				ahb_vif.mst_drv_cb.HWDATA <= req.HWDATA[i];
				
			end
			ahb_vif.mst_drv_cb.HTRANS <= req.HTRANS[j];
		end
	end
endtask : drive