class ahb_base_vseq extends uvm_sequence #(uvm_sequence_item);
`uvm_object_utils(ahb_base_vseq);

ahb_master_sequencer ahb_master_sqr;
ahb_slave_sequencer ahb_slave_sqr;
ahb_reset_sequencer ahb_reset_sqr;

ahb_master_idle_sequence ahb_master_idle_seq;
ahb_master_single_sequence ahb_master_single_seq;
ahb_master_incr_sequence ahb_master_incr_seq;
ahb_master_undeflen_sequence ahb_master_undeflen_seq;
ahb_master_wrap_sequence ahb_master_wrap_seq;

ahb_slave_error_sequence ahb_slave_error_seq;
ahb_slave_okay_sequence ahb_slave_okay_seq;

ahb_reset_sequence ahb_reset_seq;
ahb_set_sequence ahb_set_seq;
ahb_reset_slave_sequence ahb_reset_slave_seq;

extern function new(string name="ahb_base_vseq");

endclass : ahb_base_vseq

function ahb_base_vseq::new(string name="ahb_base_vseq");
	super.new(name);
endfunction : new