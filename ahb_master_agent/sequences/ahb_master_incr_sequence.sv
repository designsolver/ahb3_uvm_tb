class ahb_master_incr_sequence extends ahb_master_base_sequence;
`uvm_object_utils(ahb_master_incr_sequence);

extern function new(string name="ahb_master_incr_sequence");
extern task body();

endclass : ahb_master_incr_sequence

function ahb_master_incr_sequence::new(string name="ahb_master_incr_sequence");
	super.new(name);
endfunction : new

task ahb_master_incr_sequence::body();
	repeat(`COUNT)
	begin
	req = ahb_master_transaction::type_id::create("req");
	start_item(req);
	assert(req.randomize() with {req.HBURST == INCR4 || req.HBURST == INCR8 || req.HBURST == INCR16;});
	req.HRESETn = 1;
	//req.print();
	finish_item(req);
	end
endtask : body