class ahb_master_sequencer extends uvm_sequencer #(ahb_master_transaction);
`uvm_component_utils(ahb_master_sequencer);

 extern function new(string name="ahb_master_sequencer",uvm_component parent=null);

endclass : ahb_master_sequencer

function ahb_master_sequencer::new(string name="ahb_master_sequencer",uvm_component parent=null);
	super.new(name,parent);
endfunction : new
