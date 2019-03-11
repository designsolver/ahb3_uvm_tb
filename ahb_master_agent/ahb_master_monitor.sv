class ahb_master_monitor extends uvm_monitor;
`uvm_component_utils(ahb_master_monitor);

ahb_master_transaction req;

virtual ahb_if.master_mon ahb_vif;
ahb_master_agent_config cfg;

uvm_analysis_port #(ahb_master_transaction) monitor_ap;

 extern function new(string name="ahb_master_monitor",uvm_component parent=null);
 extern function void build_phase(uvm_phase phase);
 extern function void connect_phase(uvm_phase phase);
 extern function void end_of_elaboration_phase(uvm_phase phase);
 extern task run_phase(uvm_phase phase);
 extern function ahb_master_transaction create_transaction();
 extern task monitor();

endclass : ahb_master_monitor

function ahb_master_monitor::new(string name="ahb_master_monitor",uvm_component parent=null);
	super.new(name,parent);
	monitor_ap = new("monitor_ap",this);
endfunction : new

function void ahb_master_monitor::build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db #(ahb_master_agent_config)::get(this,"","ahb_master_agent_config",cfg))
	`uvm_fatal("AHB_MASTER_MONITOR/NOCONFIG",{"configuration must be set for : ",get_full_name(),".cfg"});
endfunction : build_phase

function void ahb_master_monitor::connect_phase(uvm_phase phase);
	ahb_vif = cfg.ahb_vif;
endfunction : connect_phase

function void ahb_master_monitor::end_of_elaboration_phase(uvm_phase phase);
	`uvm_info("AHB_MASTER_MONITOR",{get_full_name()," created..."},UVM_MEDIUM);
endfunction : end_of_elaboration_phase

task ahb_master_monitor::run_phase(uvm_phase phase);
      //phase.raise_objection(this,"starting master monitor");
	forever
	begin
	do
	@(ahb_vif.mst_mon_cb);
	while(!ahb_vif.HRESETn);
	//`uvm_info("AHB_MASTER_MONITOR","RESET deasserted .. ",UVM_MEDIUM);
	//`uvm_info("AHB_MASTER_MONITOR","Master monitoring...",UVM_MEDIUM);
	monitor();
	end
      //phase.drop_objection(this,"ending master monitor");
endtask : run_phase

function ahb_master_transaction ahb_master_monitor::create_transaction();
	ahb_master_transaction req = ahb_master_transaction::type_id::create("req");
	req.HADDR = new[1];
	req.HTRANS = new[1];
	req.HWDATA = new[1];
	return req;
endfunction : create_transaction

task ahb_master_monitor::monitor();
	req = create_transaction();
	@(ahb_vif.mst_mon_cb);
		if(ahb_vif.mst_mon_cb.HTRANS == IDLE)
		begin
			`uvm_info("AHB_MASTER_MONITOR","IDLE transaction detected",UVM_MEDIUM);
			req.HADDR[0] = ahb_vif.mst_mon_cb.HADDR;
			$cast(req.HTRANS[0],ahb_vif.mst_mon_cb.HTRANS);
			$cast(req.HBURST,ahb_vif.mst_mon_cb.HBURST);
			$cast(req.HWRITE,ahb_vif.mst_mon_cb.HWRITE);
			$cast(req.HSIZE,ahb_vif.mst_mon_cb.HSIZE);
			monitor_ap.write(req);
			//return;
		end
		if(ahb_vif.mst_mon_cb.HTRANS == BUSY)
		begin
			`uvm_info("AHB_MASTER_MONITOR","BUSY Transaction detected",UVM_MEDIUM);
			req.HADDR[0] = ahb_vif.mst_mon_cb.HADDR;
			$cast(req.HTRANS[0],ahb_vif.mst_mon_cb.HTRANS);
			$cast(req.HBURST,ahb_vif.mst_mon_cb.HBURST);
			$cast(req.HWRITE,ahb_vif.mst_mon_cb.HWRITE);
			$cast(req.HSIZE,ahb_vif.mst_mon_cb.HSIZE);
			monitor_ap.write(req);
			@(ahb_vif.mst_mon_cb);
			if(ahb_vif.mst_mon_cb.HTRANS == IDLE)
			begin	
				`uvm_info("AHB_MASTER_MONITOR","IDLE Transaction detected",UVM_MEDIUM);
				req.HADDR[0] = ahb_vif.mst_mon_cb.HADDR;
				$cast(req.HTRANS[0],ahb_vif.mst_mon_cb.HTRANS);
				$cast(req.HBURST,ahb_vif.mst_mon_cb.HBURST);
				$cast(req.HWRITE,ahb_vif.mst_mon_cb.HWRITE);
				$cast(req.HSIZE,ahb_vif.mst_mon_cb.HSIZE);
				monitor_ap.write(req);
				//return;
			end
		end
		if(ahb_vif.mst_mon_cb.HTRANS == SEQ || ahb_vif.mst_mon_cb.HTRANS == NONSEQ)
		begin
			`uvm_info("AHB_MASTER_MONITOR","Transaction detected",UVM_MEDIUM);
			req.HADDR[0] = ahb_vif.mst_mon_cb.HADDR;
			$cast(req.HTRANS[0],ahb_vif.mst_mon_cb.HTRANS);
			$cast(req.HBURST,ahb_vif.mst_mon_cb.HBURST);
			$cast(req.HWRITE,ahb_vif.mst_mon_cb.HWRITE);
			$cast(req.HSIZE,ahb_vif.mst_mon_cb.HSIZE);
			req.HWDATA[0] = ahb_vif.mst_mon_cb.HWDATA;
			//req.print();
			monitor_ap.write(req);
			//return;
		end
endtask : monitor