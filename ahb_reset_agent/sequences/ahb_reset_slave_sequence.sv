class ahb_reset_slave_sequence extends uvm_sequence #(ahb_slave_transaction);
`uvm_object_utils(ahb_reset_slave_sequence);

extern function new(string name="ahb_reset_slave_sequence");
extern task body();

endclass : ahb_reset_slave_sequence

function ahb_reset_slave_sequence::new(string name="ahb_reset_slave_sequence");
	super.new(name);
endfunction : new

task ahb_reset_slave_sequence::body();
	repeat(`COUNT)
	begin
	req = ahb_slave_transaction::type_id::create("req");
	start_item(req);
	`uvm_info("AHB_RESET_SLAVE_SEQUENCE","Reset asserted, Slave Ready",UVM_MEDIUM);
	assert(req.randomize() with {req.HREADYOUT == 1;});
	finish_item(req);
	end
endtask : body