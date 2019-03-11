class ahb_master_base_sequence extends uvm_sequence #(ahb_master_transaction);
`uvm_object_utils(ahb_master_base_sequence);

extern function new(string name="ahb_master_base_sequence");

endclass : ahb_master_base_sequence

function ahb_master_base_sequence::new(string name="ahb_master_base_sequence");
	super.new(name);
endfunction : new
