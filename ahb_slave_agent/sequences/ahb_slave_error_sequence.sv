class ahb_slave_error_sequence extends ahb_slave_base_sequence;
`uvm_object_utils(ahb_slave_error_sequence);

extern function new(string name="ahb_slave_error_sequence");
extern task body();

endclass : ahb_slave_error_sequence

function ahb_slave_error_sequence::new(string name="ahb_slave_error_sequence");
	super.new(name);
endfunction : new

task ahb_slave_error_sequence::body();
	repeat(`COUNT)
	begin
	req = ahb_slave_transaction::type_id::create("req");
	start_item(req);
	assert(req.randomize() with {req.HRESP == ERROR;});
	req.HRESETn = 1;
	finish_item(req);
	end
endtask : body