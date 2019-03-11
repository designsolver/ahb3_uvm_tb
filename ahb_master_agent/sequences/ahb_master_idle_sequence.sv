class ahb_master_idle_sequence extends ahb_master_base_sequence;
`uvm_object_utils(ahb_master_idle_sequence);

extern function new(string name="ahb_master_idle_sequence");
extern task body();

endclass : ahb_master_idle_sequence

function ahb_master_idle_sequence::new(string name="ahb_master_idle_sequence");
	super.new(name);
endfunction : new

task ahb_master_idle_sequence::body();
	repeat(`COUNT)
	begin
	req = ahb_master_transaction::type_id::create("req");
	start_item(req);
	assert(req.randomize() with {req.HBURST == SINGLE;req.HTRANS[0] == IDLE;});
	req.HRESETn = 1;
	finish_item(req);
	end
endtask : body