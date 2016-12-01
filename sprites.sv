module Playersprite(input logic  [9:0] xcoord,ycoord,
		  output logic outbit);	  
		  
		  
		  
		  int x,y;
		assign x = xcoord;
		assign y = ycoord;
//		logic bitval;
		parameter  [0:15][0:15] ROM = { 	
		  16'b0000000100000000, // 0        *
        16'b0000000100000000, // 1        *
        16'b0000000100000000, // 2        *
        16'b0000001110000000, // 3       ***
        16'b0000001010000000, // 4       * *      
        16'b1000011011000010, // 5 *    ** **    *
        16'b1000011111000010, // 6 *    *****    *
        16'b1000111011100010, // 7 *   *** ***   *
        16'b1100110001100110, // 8 **  **   **  **
        16'b1100110001100110, // 9 **  **   **  **
        16'b1100111111100110, // a **  *******  **
        16'b1111110001111110, // b ******   ******
        16'b0001111011110000, // c    **** ****
        16'b0010111111101000, // d   * ******* *
        16'b0111100000111100, // e  ****     ****
        16'b0111100000111100  // f  ****     ****
		  
		  };
//		assign outbit = ROM [ycoord][xcoord];
		always_comb
		begin
			if (x>=0 && x<=15 && y>=0 && y<= 15)
				outbit= ROM [ycoord][xcoord];
			else
				outbit = 1'b0;
		end
endmodule 		





module Lasersprite(input logic  [9:0] xcoord,ycoord,
		  output logic outbit);	  
		  
		  
		  
		int x,y;
		assign x = xcoord;
		assign y = ycoord;
		parameter  [0:15][0:15] ROM = { 
		16'b0000000000000000, // 0
        16'b0000000000000000, // 1
        16'b0000000000000000, // 2	
		16'b0000000000000000, // 3
        16'b0000000100000000, // 4
        16'b0000000100000000, // 5        *
        16'b0000001110000000, // 6        *
        16'b0000001110000000, // 7       ***
        16'b0000001110000000, // 8      *****
        16'b0000001110000000, // 9      *****
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
				outbit= ROM [ycoord][xcoord];
			else
				outbit = 1'b0;
		end
endmodule 		


module Enemysprite(input logic  [9:0] xcoord,ycoord,
		  output logic outbit);	  
		  
		  
		  
		  int x,y;
		assign x = xcoord;
		assign y = ycoord;
		parameter  [0:15][0:15] ROM = { 	
		  16'b0000000000000000, // 0
        16'b0000000110000000, // 1
        16'b0000000110000000, // 2        *
        16'b0000001111000000, // 3        *
        16'b0001001111001000, // 4       ***
        16'b0010111001110100, // 5      *****
        16'b0011101111011100, // 6      *****
        16'b1110111111110111, // 7 
        16'b0011011001101100, // 8 
        16'b0000111111110000, // 9 
        16'b0000011111100000, // a 
        16'b0000100000010000, // b   
        16'b0001010000101000, // c     
        16'b0010001111000100, // d
        16'b0100000110000010, // e
        16'b0000000000000000  // f
		  
		  };
		always_comb
		begin
			if (x>=0 && x<=15 && y>=0 && y<= 15)
				outbit= ROM [ycoord][xcoord];
			else
				outbit = 1'b0;
		end
endmodule 		


module Gameoversprite(input logic  [9:0] xcoord,ycoord,
		  output logic outbit);	  
		  
		  
		  
		  int x,y;
		assign x = xcoord;
		assign y = ycoord;
		parameter  [0:35][0:99] ROM = { 	
			100'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000,
		    100'b0000000000001111110000000000000000111110000000000000011000000000000000011000000000000000000000000000,
		    100'b0000000000111111111110000000000001111111000000000000111110000000000001111100000001111111111111111000,
			100'b0000001111111111111111100000000011111111100000000001111111000000000011111110000001111111111111111000,
			100'b0000111111110000001111100000000111111111111000000001111111100000000111111111000001111100000000000000,
			100'b0001111111000000000000000000001111100011111100000001111111110000001111111111000001111100000000000000,
			100'b0001111100001111111111110000011111000001111110000001111111111000011111111111100001111111111111100000,
			100'b0001111100011111111111110000111111100000111111000001111101111000111111001111100001111111111111110000,
			100'b0001111100011111111111111000111111111111111111100001111000111110111111001111110001111111111111110000,
			100'b0001111110000000000111111001111100000000011111110011111000011111111110001111110001111100000000000000,
			100'b0000111111100000011111110011111100000000011111110011111000001111110000001111111001111100000000000000,
			100'b0000001111111111111111100011111100000000001111110011111000001111110000000111111001111111111111111000,
			100'b0000000011111111111111000011111100000000001111110011111000000111110000000111111001111111111111111100,
			100'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000,
			100'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000,
			100'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000,
			100'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000,
			100'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000,
			100'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000,
			100'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000,
			100'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000,
			100'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000,
			100'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000,
		  
			100'b0000000000111111111000000001111100000000000000111111000000000000000000000011111111111111100000000000,
			100'b0000000011111111111111100000111110000000000001111000011111111111111111000111111111111111110000000000,
			100'b0000001111111111111111111000111111000000000011111000011111111111111111000111111000001111111000000000,
			100'b0000011111110000000011111100011111100000000111110000011111000000000000000111110000000111111000000000,
			100'b0000111111000000000011111100011111110000001111110000011111000000000000000111110000000111111000000000,
			100'b0001111110000000000001111110000111110000011111100000011111111111111100000111110000001111111000000000,
			100'b0001111100000000000011111100000011111000111110000000011111111111111100000111111111111111110000000000,
			100'b0001111100000000000011111100000001111101111100000000011111111111111100000111111111111100000000000000,
			100'b0001111100000000000111111100000000111111111100000000011111000000000000000111110001111111000000000000,
			100'b0000111111100000011111110000000000111111111000000000011111100000000000000111110000011111111000000000,
			100'b0000011111111111111111100000000000011111110000000000011111111111111110000111110000000111111100000000,
			100'b0000000111111111111110000000000000001111100000000000011111111111111110000111110000000001111110000000,
			100'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

		  
		  
		  };
		always_comb
		begin
			if (x>=0 && x<=99 && y>=0 && y<= 35)
				outbit= ROM [ycoord][xcoord];
			else
				outbit = 1'b0;
		end
endmodule 		

