class ahb_reset_sequence extends uvm_sequence #(ahb_master_transaction);
`uvm_object_utils(ahb_reset_sequence);

extern function new(string name="ahb_reset_sequence");
extern task body();

endclass : ahb_reset_sequence

function ahb_reset_sequence::new(string name="ahb_reset_sequence");
	super.new(name);
endfunction : new

task ahb_reset_sequence::body();
	repeat(`COUNT)
	begin
	req = ahb_master_transaction::type_id::create("req");
	start_item(req);
	assert(req.randomize() with {req.HBURST == SINGLE;});
	`uvm_info("AHB_RESET_AGENT","Asserting reset..",UVM_MEDIUM);
	req.HRESETn = 0;
	finish_item(req);
	end
endtask : body
