class ahb_master_wrap_sequence extends ahb_master_base_sequence;
`uvm_object_utils(ahb_master_wrap_sequence);

extern function new(string name="ahb_master_wrap_sequence");
extern task body();

endclass : ahb_master_wrap_sequence

function ahb_master_wrap_sequence::new(string name="ahb_master_wrap_sequence");
	super.new(name);
endfunction : new

task ahb_master_wrap_sequence::body();
	repeat(`COUNT)
	begin
	req = ahb_master_transaction::type_id::create("req");
	start_item(req);
	assert(req.randomize() with {req.HBURST == WRAP4 || req.HBURST == WRAP8 || req.HBURST == WRAP16;});
	req.HRESETn = 1;
	finish_item(req);
	end
endtask : body