class ahb_slave_driver extends uvm_driver #(ahb_slave_transaction);
 `uvm_component_utils(ahb_slave_driver);
 
 ahb_slave_agent_config config_h;
 virtual ahb_if ahb_vif;

 extern function new(string name="ahb_slave_driver",uvm_component parent=null);
 extern function void build_phase(uvm_phase phase);
 extern function void connect_phase(uvm_phase phase);
 extern function void end_of_elaboration_phase(uvm_phase phase);
 extern task run_phase(uvm_phase phase);
 extern task drive();

endclass : ahb_slave_driver


 function ahb_slave_driver::new(string name="ahb_slave_driver",uvm_component parent=null);
  	super.new(name,parent);
 endfunction : new

 function void ahb_slave_driver::build_phase(uvm_phase phase);
  super.build_phase(phase);
  if(!uvm_config_db #(ahb_slave_agent_config)::get(this,"","ahb_slave_agent_config",config_h))
   `uvm_fatal("AHB_SLAVE_DRIVER/NOCONFIG",{"configuration must be set for ",get_full_name(),".cfg"});
 endfunction : build_phase

 function void ahb_slave_driver::connect_phase(uvm_phase phase);
	ahb_vif = config_h.ahb_vif;
 endfunction : connect_phase

 function void ahb_slave_driver::end_of_elaboration_phase(uvm_phase phase);
  `uvm_info("AHB_SLAVE_DRIVER",{get_full_name()," created..."},UVM_MEDIUM);
 endfunction : end_of_elaboration_phase

 task ahb_slave_driver::run_phase(uvm_phase phase);
      //phase.raise_objection(this,"starting slave driver");
	seq_item_port.get_next_item(req);
	drive();
	seq_item_port.item_done();
      //phase.drop_objection(this,"ending slave driver");
 endtask : run_phase

 task ahb_slave_driver::drive();
	while(!ahb_vif.HRESETn)
	begin
		@(ahb_vif.slv_drv_cb);
		ahb_vif.slv_drv_cb.HREADY <= '1;
	end
	foreach(req.ready[i])
	begin
		//req.print();
		@(ahb_vif.slv_drv_cb);
		ahb_vif.slv_drv_cb.HREADY <= req.ready[i];
		if(req.ready[i])
			if(!ahb_vif.slv_drv_cb.HWRITE)
			begin
				ahb_vif.slv_drv_cb.HRESP <= req.HRESP;
				if(req.HRESP == OKAY)
					ahb_vif.slv_drv_cb.HRDATA <= req.HRDATA;
				if(req.HRESP == ERROR)
					ahb_vif.slv_drv_cb.HRDATA <= '0;
			end
		else 
		begin
			ahb_vif.slv_drv_cb.HRESP <= OKAY;
			ahb_vif.slv_drv_cb.HRDATA <= '0;
		end
	end
	
 endtask : drive
