class ahb_set_sequence extends uvm_sequence #(ahb_master_transaction);
`uvm_object_utils(ahb_set_sequence);

extern function new(string name="ahb_set_sequence");
extern task body();


endclass : ahb_set_sequence

function ahb_set_sequence::new(string name="ahb_set_sequence");
	super.new(name);
endfunction : new

task ahb_set_sequence::body();
	repeat(`COUNT)
	begin
	req = ahb_master_transaction::type_id::create("req");
	start_item(req);
	assert(req.randomize() with {req.HBURST == SINGLE;});
	req.HRESETn = 1;
	finish_item(req);
	end
endtask : body
