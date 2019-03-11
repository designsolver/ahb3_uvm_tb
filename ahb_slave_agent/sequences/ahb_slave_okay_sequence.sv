class ahb_slave_okay_sequence extends ahb_slave_base_sequence;
`uvm_object_utils(ahb_slave_okay_sequence);

extern function new(string name="ahb_slave_okay_sequence");
extern task body();

endclass : ahb_slave_okay_sequence

function ahb_slave_okay_sequence::new(string name="ahb_slave_okay_sequence");
	super.new(name);
endfunction : new

task ahb_slave_okay_sequence::body();
	repeat(`COUNT)
	begin
	req = ahb_slave_transaction::type_id::create("req");
	start_item(req);
	assert(req.randomize() with { req.HRESP == OKAY;});
	req.HRESETn = 1;
	finish_item(req);
	end
endtask : body