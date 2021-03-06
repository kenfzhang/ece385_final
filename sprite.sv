module platform(input logic  [9:0] xcoord,ycoord,
		  output logic out);	  
		  
		  
		  
		int x,y;
		assign x = xcoord;
		assign y = ycoord;
		parameter  [0:15][0:15] ROM = { 
		16'b0000000000000000, // 0
        16'b0000000000000000, // 1
        16'b0000000000000000, // 2	
		16'b0000000000000000, // 3
        16'b0000000000000000, // 4
        16'b0000000000000000, // 5        
        16'b0000000000000000, // 6        
        16'b0000000000000000, // 7       
        16'b0000000000000000, // 8      
        16'b1111111111111111, // 9 ****************
        16'b0000000000000000, // a 
        16'b0000000000000000, // b 
        16'b0000000000000000, // c 
        16'b0000000000000000, // d 
        16'b0000000000000000, // e   
        16'b0000000000000000, // f     
        };

		always_comb
		begin
			if (x>=0 && x<=15 && y>=0 && y<= 15)
				out= ROM [ycoord][xcoord];
			else
				out = 1'b0;
		end
endmodule

module player_sprite(input logic  [9:0] xcoord,ycoord,
		  output logic out);	  
		int x,y;
		assign x = xcoord;
		assign y = ycoord;

		parameter  [0:15][0:15] ROM = { 	
		16'b0000000000000000, // 0 
        16'b0000000000000000, // 1 
        16'b0000000000000000, // 2
        16'b0000000000000000, // 3 
        16'b0000000000000000, // 4      
        16'b0000011111000000, // 5 
        16'b0000011111000000, // 6 
        16'b0001111111110000, // 7 
        16'b0001111111110000, // 8
        16'b0011111111111000, // 9 
        16'b0011111111111000, // a 
        16'b0011111111111000, // b 
        16'b0011111111111000, // c
        16'b0011100000111000, // d
        16'b0011100000111000, // e 
        16'b0000000000000000  // f 
		};

		always_comb
		begin
			if (x>=0 && x<=15 && y>=0 && y<= 15)
				out= ROM [ycoord][xcoord];
			else
				out = 1'b0;
		end
endmodule 