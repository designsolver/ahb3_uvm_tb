class init_vseq_from_test extends ahb_base_test;
`uvm_component_utils(init_vseq_from_test);

extern function new(string name="init_vseq_from_test",uvm_component parent=null);
extern task run_phase(uvm_phase phase);
 
endclass : init_vseq_from_test

function init_vseq_from_test::new(string name="init_vseq_from_test",uvm_component parent=null);
	super.new(name,parent);
endfunction : new

task init_vseq_from_test::run_phase(uvm_phase phase);
	ahb_vseq vseq = ahb_vseq::type_id::create("ahb_vseq");
	phase.raise_objection(this,"starting virtual sequence");
	`uvm_info("AHB_VSEQ","Starting the test",UVM_MEDIUM);
	uvm_top.print_topology();
	init_vseq(vseq);
	vseq.start(null);

	#5000;
	phase.drop_objection(this,"ending virtual sequence");
	
	`uvm_info("AHB_VSEQ","Ending the test",UVM_MEDIUM);
endtask : run_phase