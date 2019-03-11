class ahb_vseq extends ahb_base_vseq;
`uvm_object_utils(ahb_vseq);

extern function new(string name="ahb_vseq");
extern task body();

endclass : ahb_vseq

function ahb_vseq::new(string name="ahb_vseq");
	super.new(name);
endfunction : new

task ahb_vseq::body();

ahb_master_idle_seq 	= ahb_master_idle_sequence::type_id::create("ahb_master_idle_seq");
ahb_master_single_seq 	= ahb_master_single_sequence::type_id::create("ahb_master_single_sequence");
ahb_master_incr_seq 	= ahb_master_incr_sequence::type_id::create("ahb_master_incr_seq");
ahb_master_undeflen_seq = ahb_master_undeflen_sequence::type_id::create("ahb_master_undeflen_seq");
ahb_master_wrap_seq 	= ahb_master_wrap_sequence::type_id::create("ahb_master_wrap_seq");

ahb_slave_error_seq	= ahb_slave_error_sequence::type_id::create("ahb_slave_error_seq");
ahb_slave_okay_seq	= ahb_slave_okay_sequence::type_id::create("ahb_slave_okay_seq");

ahb_reset_seq 		= ahb_reset_sequence::type_id::create("ahb_reset_seq");
ahb_set_seq 		= ahb_set_sequence::type_id::create("ahb_set_seq");
ahb_reset_slave_seq	= ahb_reset_slave_sequence::type_id::create("ahb_reset_slave_seq");

/*fork
	ahb_reset_seq.start(ahb_reset_sqr);
	ahb_reset_slave_seq.start(ahb_slave_sqr);
join

fork
	ahb_set_seq.start(ahb_reset_sqr);
	ahb_slave_okay_seq.start(ahb_slave_sqr);
join

fork
	ahb_master_idle_seq.start(ahb_master_sqr);
	ahb_slave_error_seq.start(ahb_slave_sqr);
	ahb_slave_okay_seq.start(ahb_slave_sqr);
join

fork 
	ahb_master_single_seq.start(ahb_master_sqr);
	ahb_slave_error_seq.start(ahb_slave_sqr);
	ahb_slave_okay_seq.start(ahb_slave_sqr);
join

fork
	ahb_master_idle_seq.start(ahb_master_sqr);
	ahb_slave_okay_seq.start(ahb_slave_sqr);
join

fork 
	ahb_master_incr_seq.start(ahb_master_sqr);
	ahb_slave_error_seq.start(ahb_slave_sqr);
	ahb_slave_okay_seq.start(ahb_slave_sqr);
join

fork
	ahb_master_idle_seq.start(ahb_master_sqr);
	ahb_slave_okay_seq.start(ahb_slave_sqr);
join


fork 
	ahb_master_wrap_seq.start(ahb_master_sqr);
	ahb_slave_error_seq.start(ahb_slave_sqr);
	ahb_slave_okay_seq.start(ahb_slave_sqr);
join

fork
	ahb_master_idle_seq.start(ahb_master_sqr);
	ahb_slave_okay_seq.start(ahb_slave_sqr);
join

fork
	ahb_master_undeflen_seq.start(ahb_master_sqr);
	ahb_slave_error_seq.start(ahb_slave_sqr);
	ahb_slave_okay_seq.start(ahb_slave_sqr);
join
*/
fork
begin
	ahb_master_incr_seq.start(ahb_master_sqr);
	ahb_master_wrap_seq.start(ahb_master_sqr);
	ahb_master_single_seq.start(ahb_master_sqr);
	ahb_master_idle_seq.start(ahb_master_sqr);
	ahb_master_undeflen_seq.start(ahb_master_sqr);
end
begin
	ahb_slave_error_seq.start(ahb_slave_sqr);
	ahb_slave_okay_seq.start(ahb_slave_sqr);
end
join

endtask : body