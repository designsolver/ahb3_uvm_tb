interface ahb_if(input bit HCLK);
 logic 		HRESETn;
 logic 		HREADY;
 logic 		HWRITE;
 logic [1:0]	HRESP;
 logic [1:0]	HTRANS;
 logic [2:0] 	HBURST;
 logic [2:0] 	HSIZE;
 logic [31:0]	HADDR;
 logic [31:0]	HWDATA;
 logic [31:0]	HRDATA;

clocking mst_drv_cb @(posedge HCLK);
	default input #1 output #0;
	input HRESP, HREADY, HRDATA;
	output HTRANS, HBURST, HSIZE, HADDR, HWDATA, HWRITE;
endclocking 

clocking mst_mon_cb @(posedge HCLK);
	default input #1 output #0;
	input HREADY, HRESP, HTRANS, HBURST, HSIZE, HADDR, HWDATA, HRDATA, HWRITE;
endclocking

clocking slv_drv_cb @(posedge HCLK);
	default input #1 output #0;
	input HTRANS, HBURST, HSIZE, HADDR, HWDATA, HWRITE;
	output HRESP, HREADY;
	output negedge HRDATA;
endclocking

clocking slv_mon_cb @(posedge HCLK);
	default input #1 output #0;
	input HREADY, HRESP, HTRANS, HBURST, HSIZE, HADDR, HWDATA, HRDATA, HWRITE;
endclocking 

clocking reset_drv_cb @(posedge HCLK);
	default input #1 output #0;
	input HRESP, HREADY, HRDATA;
	output HTRANS, HBURST, HSIZE, HADDR, HWDATA, HWRITE;
endclocking 

modport master_drv (clocking mst_drv_cb, input HRESETn);
modport master_mon (clocking mst_mon_cb, input HRESETn);
modport slave_drv (clocking slv_drv_cb, input HRESETn);
modport slave_mon (clocking slv_mon_cb, input HRESETn);
modport reset_drv (clocking reset_drv_cb, output HRESETn);


endinterface : ahb_if
