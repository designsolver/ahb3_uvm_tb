class ahb_slave_transaction extends uvm_sequence_item;

  logic 		HRESETn;
  logic [31:0]  	HADDR;
  burst_t		HBURST;
//bit  			HMASTLOCK;
//bit  [3:0] 		HPROT;
  size_t 		HSIZE;
  transfer_t		HTRANS;
  bit [31:0]    	HWDATA ;
  rw_t	        	HWRITE;
  rand bit [31:0]    	HRDATA;
  bit 			HREADYOUT;
  rand response_t	HRESP;

  rand bit 		ready[];
 

 `uvm_object_utils_begin(ahb_slave_transaction)
	`uvm_field_int(HRESETn, UVM_ALL_ON)
	`uvm_field_int(HADDR, UVM_ALL_ON)
	`uvm_field_enum(burst_t,HBURST, UVM_ALL_ON)
      //`uvm_field_int(HMASTLOCK, UVM_ALL_ON)
      //`uvm_field_int(HPROT, UVM_ALL_ON)
	`uvm_field_enum(size_t,HSIZE, UVM_ALL_ON)
	`uvm_field_enum(transfer_t,HTRANS, UVM_ALL_ON)
	`uvm_field_int(HWDATA, UVM_ALL_ON)
	`uvm_field_enum(rw_t,HWRITE, UVM_ALL_ON)
	`uvm_field_int(HRDATA, UVM_ALL_ON)
	`uvm_field_int(HREADYOUT, UVM_ALL_ON)
	`uvm_field_enum(response_t,HRESP, UVM_ALL_ON)
 `uvm_object_utils_end

  constraint ready_cycle{ 
          ready.size inside {[10:20]};
          foreach(ready[i])
              ready[i] dist { 0 := 2, 1 := 5};
  }

  extern function new(string name="ahb_slave_transaction");

  endclass : ahb_slave_transaction

 function ahb_slave_transaction::new(string name="ahb_slave_transaction");
	super.new(name);
 endfunction : new
