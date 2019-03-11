class ahb_master_transaction extends uvm_sequence_item;

  bit	 	    HRESETn;
  rand bit [31:0]   HADDR [];
  rand burst_t	    HBURST;
//bit  		    HMASTLOCK;
//bit  [3:0] 	    HPROT;
  rand size_t 	    HSIZE;
  rand transfer_t   HTRANS [];
  rand bit [31:0]   HWDATA [];
  rand rw_t	    HWRITE;
  bit [31:0]	    HRDATA [];
  bit 		    HREADY;
  response_t	    HRESP;
  rand int busy_cycles;
  rand bit busy_bits[];

`uvm_object_utils_begin(ahb_master_transaction)
	`uvm_field_int(HRESETn, UVM_ALL_ON)
	`uvm_field_array_int(HADDR, UVM_ALL_ON)
	`uvm_field_enum(burst_t,HBURST, UVM_ALL_ON)
      //`uvm_field_int(HMASTLOCK, UVM_ALL_ON)
      //`uvm_field_int(HPROT, UVM_ALL_ON)
	`uvm_field_enum(size_t,HSIZE, UVM_ALL_ON)
	`uvm_field_array_enum(transfer_t,HTRANS, UVM_ALL_ON)
	`uvm_field_array_int(HWDATA, UVM_ALL_ON)
	`uvm_field_enum(rw_t,HWRITE, UVM_ALL_ON)
	`uvm_field_array_int(HRDATA, UVM_ALL_ON)
	`uvm_field_int(HREADY, UVM_ALL_ON)
	`uvm_field_enum(response_t,HRESP, UVM_ALL_ON)
`uvm_object_utils_end


 constraint busy_bit_vals{
	busy_bits.size == 2 * busy_cycles;
	foreach(busy_bits[i])
		busy_bits[i] dist { 1 := 1, 0 := 1};
 }	
  
 constraint busy_cycle_count{
	busy_cycles == HADDR.size;
 }

 constraint addr_size{
		 HADDR.size > 0;
		 if(HBURST == SINGLE) HADDR.size == 1;
		 if(HBURST == INCR) HADDR.size < (1024 / (2 ** HSIZE));
		 if(HBURST == INCR4 || HBURST == WRAP4) HADDR.size == 4;
		 if(HBURST == INCR8 || HBURST == WRAP8) HADDR.size == 8;
		 if(HBURST == INCR16 || HBURST == WRAP16) HADDR.size == 16;
 }
 
 constraint addr_1kb_boundary{
 }

 constraint wdata{
		HWDATA.size == HADDR.size;
 }

 constraint trans_size{
		HTRANS.size == HADDR.size + busy_cycles;
}



  constraint first_trans_type{ // single transfers can be IDLE or NONSEQ
		if(HBURST == SINGLE){
			 HTRANS[0] inside { IDLE, NONSEQ };
		}
		else HTRANS[0] == NONSEQ; // indicates single transfer or first transfer of a burst
 }

 constraint incr_trans_type{
		if(HBURST != SINGLE)
			foreach(HTRANS[i])
				if(i == 0)
					HTRANS[i] == NONSEQ;
				else 
					HTRANS[i] == SEQ;

 }
 

  constraint trans_val{ //transfter size set by HSIZE must be less than or equal to width of data bus
		HSIZE <= WORDx2;
 }

 constraint addr_boundary{ //all transfers in a burst must be aligned to the address boundary equal to the size of transfers
	if(HSIZE == HALFWORD)
		foreach(HADDR[i])
			HADDR[i][0] == 0;

	if(HSIZE == WORD)
		foreach(HADDR[i])
			HADDR[i][1:0] == 0;

	if(HSIZE == WORDx2)
		foreach(HADDR[i])
			HADDR[i][2:0] == 0;

	if(HSIZE == WORDx4)
		foreach(HADDR[i])
			HADDR[i][3:0] == 0;

	if(HSIZE == WORDx8)
		foreach(HADDR[i])
			HADDR[i][4:0] == 0;

	if(HSIZE == WORDx16)
		foreach(HADDR[i])
			HADDR[i][5:0] == 0;

	if(HSIZE == WORDx32)
		foreach(HADDR[i])
			HADDR[i][6:0] == 0;
 }

 
 constraint addr_vals{
	if(HBURST == INCR || HBURST == INCR4 || HBURST == INCR8 || HBURST == INCR16)
		foreach(HADDR[i])
			if(i > 0) 
				HADDR[i] == HADDR[i-1] + 2**HSIZE;
 }

 constraint addr_4beat_wrap{
	if(HBURST == WRAP4){
		if(HSIZE == BYTE)
			foreach(HADDR[i])
				if(i > 0){
					HADDR[i][1:0] == HADDR[i-1][1:0] + 1;
					HADDR[i][31:2] == HADDR[i-1][31:2];
				}

		if(HSIZE == HALFWORD)
			foreach(HADDR[i])
				if(i > 0){
					HADDR[i][2:1] == HADDR[i-1][2:1] + 1;
					HADDR[i][31:3] == HADDR[i-1][31:3];
				}

		if(HSIZE == WORD)
			foreach(HADDR[i])
				if(i > 0){
					HADDR[i][3:2] == HADDR[i-1][3:2] + 1;
					HADDR[i][31:4] == HADDR[i-1][31:4];
				}
	}
 }

 constraint addr_8beat_wrap{
	if(HBURST ==  WRAP8){
		if(HSIZE == BYTE)
			foreach(HADDR[i])
				if(i > 0){
					HADDR[i][2:0] == HADDR[i-1][2:0] + 1;
					HADDR[i][31:3] == HADDR[i-1][31:3];
				}

		if(HSIZE == HALFWORD)
			foreach(HADDR[i])
				if(i > 0){
					HADDR[i][3:1] == HADDR[i-1][3:1] + 1;
					HADDR[i][31:4] == HADDR[i-1][31:4];
				}
	
		if(HSIZE == WORD)
			foreach(HADDR[i])
				if(i > 0){
					HADDR[i][4:2] == HADDR[i-1][4:2] + 1;
					HADDR[i][31:5] == HADDR[i][31:5];
				}

	}
	
 }	

 constraint addr_16beat_wrap{
	if(HBURST == WRAP16){
		if(HSIZE == BYTE)
			foreach(HADDR[i])
				if(i > 0){
					HADDR[i][3:0] == HADDR[i-1][3:0] + 1;
					HADDR[i][31:4] == HADDR[i-1][31:4];
				}
	
		if(HSIZE == HALFWORD)
			foreach(HADDR[i])
				if(i > 0){
					HADDR[i][4:1] == HADDR[i-1][4:1] + 1;
					HADDR[i][31:5] == HADDR[i-1][31:5];
				}
		
		if(HSIZE == WORD)
			foreach(HADDR[i])
				if(i > 0){
					HADDR[i][5:2] == HADDR[i-1][5:2] + 1;
					HADDR[i][31:6] == HADDR[i-1][31:6];
				}
	}

 }


 extern function new(string name="ahb_master_transaction");
 extern function void add_busy_cycles();
 
endclass : ahb_master_transaction

function ahb_master_transaction::new(string name="ahb_master_transaction");
	super.new(name);
endfunction : new


function void ahb_master_transaction::add_busy_cycles();
	if(HADDR.size > 1)
		foreach(busy_bits[i])
			if(i != 0 && busy_bits[i] == 1)
				HTRANS[i] = BUSY;
	else HTRANS[1] = BUSY;


endfunction : add_busy_cycles



