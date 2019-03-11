class ahb_reset_sequencer extends uvm_sequencer #(ahb_master_transaction);
`uvm_component_utils(ahb_reset_sequencer);

extern function new(string name="ahb_reset_sequencer",uvm_component parent=null);

endclass : ahb_reset_sequencer

function ahb_reset_sequencer::new(string name="ahb_reset_sequencer",uvm_component parent=null);
	super.new(name,parent);
endfunction : new

