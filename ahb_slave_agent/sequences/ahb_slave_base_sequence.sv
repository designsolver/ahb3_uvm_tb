class ahb_slave_base_sequence extends uvm_sequence #(ahb_slave_transaction);
`uvm_object_utils(ahb_slave_base_sequence);

extern function new(string name="ahb_slave_base_sequence");


endclass : ahb_slave_base_sequence

function ahb_slave_base_sequence::new(string name="ahb_slave_base_sequence");
	super.new(name);
endfunction : new 	


