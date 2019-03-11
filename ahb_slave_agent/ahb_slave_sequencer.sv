class ahb_slave_sequencer extends uvm_sequencer #(ahb_slave_transaction);
`uvm_component_utils(ahb_slave_sequencer);

 extern function new(string name="ahb_slave_sequencer",uvm_component parent=null);

 endclass : ahb_slave_sequencer

 function ahb_slave_sequencer::new(string name="ahb_slave_sequencer",uvm_component parent=null);
 	super.new(name,parent);
 endfunction : new
