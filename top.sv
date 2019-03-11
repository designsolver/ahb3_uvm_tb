module top;
bit clk;

initial
 forever
  #10 clk = ~clk;

ahb_if ahb_intf(clk);

initial 
begin
	uvm_config_db #(virtual ahb_if)::set(null,"uvm_test_top","ahb_vif",ahb_intf);

	run_test("init_vseq_from_test");

end

endmodule : top