//-------------------------------------------------------------------------
//    Ball.sv                                                            --
//    Viral Mehta                                                        --
//    Spring 2005                                                        --
//                                                                       --
//    Modified by Stephen Kempf 03-01-2006                               --
//                              03-12-2007                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Fall 2014 Distribution                                             --
//                                                                       --
//    For use with ECE 298 Lab 7                                         --
//    UIUC ECE Department                                                --
//-------------------------------------------------------------------------


module  ball ( input Reset, frame_clk,
				input [7:0] keycode,
               	output [10:0]  BallX, BallY, BallS, output logic gg );
    
    logic [9:0] Ball_X_Pos, Ball_X_Motion, Ball_Y_Pos, Ball_Y_Motion, Ball_SizeX, Ball_SizeY, Ball_Mid;
	logic [9:0] a, b;
	logic [9:0] curr_height, falling_height;
	logic [9:0] t;
	 
    parameter [9:0] Ball_X_start = 280;  // Initial position on the X axis
    parameter [9:0] Ball_Y_start = 460;  // Initial position on the Y axis
    
	parameter [9:0] Ball_X_Min=0;       // Leftmost point on the X axis
    parameter [9:0] Ball_X_Max=639;     // Rightmost point on the X axis
    parameter [9:0] Ball_Y_Min=0;       // Topmost point on the Y axis
    parameter [9:0] Ball_Y_Max=479;     // Bottommost point on the Y axis
    
	parameter [9:0] Ball_X_Step=1;      // Step size on the X axis
    parameter [9:0] Ball_Y_Step=1;      // Step size on the Y axis
	 
	 logic bool1 = 0;
	 logic bool2 = 0;
	 logic bool3 = 0;

	 logic over = 0;
 

    assign Ball_SizeX = 8;
	assign Ball_Mid = 4;
	assign Ball_SizeY = 10;
   
    always_ff @ (posedge Reset or posedge frame_clk )
    begin: Move_Ball
        if (Reset)  // Asynchronous Reset
        begin 
            Ball_Y_Motion <= 10'd0; //Ball_Y_Step;
			Ball_X_Motion <= 10'd0; //Ball_X_Step;
			Ball_Y_Pos <= Ball_Y_start;
			Ball_X_Pos <= Ball_X_start;
        end
           
        else 
        begin
				if ( (Ball_Y_Pos + Ball_SizeY) >= Ball_Y_Max && (Ball_X_Pos + Ball_SizeX) >= Ball_X_Max)  // Ball is at the bottom right edge, BOUNCE!
						begin
							if(Ball_Y_Motion != 10'd0)
								begin
								Ball_Y_Motion <= (~ (Ball_Y_Step) + 1'b1);
								Ball_X_Motion <= 0;
								end
							else  // 2's complement.
								begin
								Ball_X_Motion <= (~ (Ball_X_Step) + 1'b1);
								Ball_Y_Motion <= 0;
								end
						end
				else if ( (Ball_Y_Pos) <= Ball_Y_Min  && (Ball_X_Pos + Ball_SizeX) >= Ball_X_Max)  // Ball is at the top right edge, BOUNCE!
						begin
							if(Ball_Y_Motion != 10'd0)
								begin
								Ball_Y_Motion <= Ball_Y_Step;
								Ball_X_Motion <= 0;
								end
							else
								begin
								Ball_X_Motion <= (~ (Ball_X_Step) + 1'b1);
								Ball_Y_Motion <= 0;
								end
						end
				else if ( (Ball_X_Pos) >= Ball_X_Max  && (Ball_Y_Pos + Ball_SizeY) >= Ball_Y_Max)  // Ball is at the bottom left edge, BOUNCE!
						begin	
							if(Ball_Y_Motion == 10'd0)
								begin
								Ball_X_Motion <= Ball_X_Step;  // 2's complement.
								Ball_Y_Motion <= 0;
								end
							else
								begin
								Ball_Y_Motion <= (~ (Ball_Y_Step) + 1'b1);
								Ball_X_Motion <= 0;
								end
						end
				else if ( (Ball_X_Pos) <= Ball_X_Min && (Ball_Y_Pos) <= Ball_Y_Min)  // Ball is at the top left edge, BOUNCE!
						begin	
							if(Ball_Y_Motion == 10'd0)
								begin
								Ball_X_Motion <= Ball_X_Step;
								Ball_Y_Motion <= 0;
								end
							else
								begin
								Ball_Y_Motion <= Ball_Y_Step;
								Ball_X_Motion <= 0;
								end
						end
				// If we hit the bottom of the screen
				// TODO: MAKE SURE IF THIS CONDITION IS MET, END GAME
				else if( (Ball_Y_Pos + Ball_SizeY) >= Ball_Y_Max && (Ball_X_Pos + Ball_SizeX) < Ball_X_Max && (Ball_X_Pos) > Ball_X_Min)
						begin
						Ball_Y_Motion <= 0;
						Ball_X_Motion <= 0;

						over = 1;
						end
				// If we hit the top of the screen
				else if( (Ball_Y_Pos) <= Ball_Y_Min && (Ball_X_Pos + Ball_SizeX) < Ball_X_Max && (Ball_X_Pos) > Ball_X_Min)
						begin
						Ball_Y_Motion <= Ball_Y_Step;
						Ball_X_Motion <= 0;
						end
				// if we hit the left of the screen
				else if( (Ball_X_Pos) <= Ball_X_Min && (Ball_Y_Pos + Ball_SizeY) < Ball_Y_Max && (Ball_Y_Pos) > Ball_Y_Min)
						begin
						Ball_X_Motion <= Ball_X_Step;
						Ball_Y_Motion <= 0;
						end
				// if we hit the right of the screen
				else if( (Ball_X_Pos + Ball_SizeX) >= Ball_X_Max && (Ball_Y_Pos + Ball_SizeY) < Ball_Y_Max && (Ball_Y_Pos - Ball_SizeY) > Ball_Y_Min)		
						begin
						Ball_X_Motion <= (~ (Ball_X_Step) + 1'b1);
						Ball_Y_Motion <= 0;
						end
				// check the keycodes
				// else if(keycode == 8'd26 || keycode == 8'd22)
				// 	begin
				// 		Ball_X_Motion <= 10'd0;
				// 		if(keycode == 8'd26 && Ball_Y_Motion == Ball_Y_Step)
				// 			Ball_Y_Motion <= (~ (Ball_Y_Step) + 1'b1);
				// 		else if(keycode == 8'd22 && Ball_Y_Motion == (~ (Ball_Y_Step) + 1'b1))
				// 			Ball_Y_Motion <= Ball_Y_Step;
				// 		else if( (Ball_Y_Motion == 10'd0) && keycode == 8'd26)
				// 				Ball_Y_Motion <= (~ (Ball_Y_Step) + 1'b1);
				// 		else if( (Ball_Y_Motion == 10'd0) && keycode == 8'd22)
				// 				Ball_Y_Motion <= Ball_Y_Step;
				// 		else
				// 			Ball_Y_Motion <= Ball_Y_Motion;
				// 	end
				// When we press the A or D key
				else if ( (Ball_Y_Motion > 0) && ((Ball_X_Pos + Ball_Mid) >= 240 && (Ball_X_Pos + Ball_Mid) <= 320 && (Ball_Y_Pos + Ball_SizeY) < 470 + 4'd5 && (Ball_Y_Pos + Ball_SizeY) >= 470 - 4'd5)
								|| ((Ball_X_Pos + Ball_Mid) >= 165 && (Ball_X_Pos + Ball_Mid) <= 247 && (Ball_Y_Pos + Ball_SizeY) < 455 + 4'd5 && (Ball_Y_Pos + Ball_SizeY) >= 455 - 4'd5)
								|| ((Ball_X_Pos + Ball_Mid) >= 317 && (Ball_X_Pos + Ball_Mid) <= 389 && (Ball_Y_Pos + Ball_SizeY) < 450 + 4'd5 && (Ball_Y_Pos + Ball_SizeY) >= 450 - 4'd5)
											)			
					begin
						Ball_Y_Motion <= -3;
					end
				else if(keycode == 8'd4 || keycode == 8'd7)
					begin
						//Ball_Y_Motion <= 10'd0;
						if(keycode == 8'd7 && Ball_X_Motion == (~ (Ball_X_Step) + 1'b1))
							Ball_X_Motion <= Ball_X_Step;
						else if(keycode == 8'd4 && Ball_X_Motion == Ball_X_Step)
							Ball_X_Motion <= (~ (Ball_X_Step) + 1'b1);
						else if( (Ball_X_Motion == 10'd0) && keycode == 8'd4)
							Ball_X_Motion <= (~ (Ball_X_Step) + 1'b1);
						else if( (Ball_X_Motion == 10'd0) && keycode == 8'd7)
							Ball_X_Motion <= Ball_X_Step;
						else
							Ball_X_Motion <= Ball_X_Motion;
						bool1 <= ~bool1;
						if(bool1 == 0)
						begin
							bool2 <= ~bool2;
							if(bool2 == 0)
							begin
								bool3 <= ~bool3;
								if(bool3 == 0)
								begin
									Ball_Y_Motion <= Ball_Y_Motion + 1;
								end
							end
							
						end						
					end
				// Check whether we hit a platform
				else if ( (Ball_Y_Motion > 0) && ((Ball_X_Pos + Ball_Mid) >= 240 && (Ball_X_Pos + Ball_Mid) <= 320 && (Ball_Y_Pos + Ball_SizeY) < 470 + 4'd5 && (Ball_Y_Pos + Ball_SizeY) >= 470 - 4'd5)
							|| ((Ball_X_Pos + Ball_Mid) >= 165 && (Ball_X_Pos + Ball_Mid) <= 247 && (Ball_Y_Pos + Ball_SizeY) < 455 + 4'd5 && (Ball_Y_Pos + Ball_SizeY) >= 455 - 4'd5)
							|| ((Ball_X_Pos + Ball_Mid) >= 317 && (Ball_X_Pos + Ball_Mid) <= 389 && (Ball_Y_Pos + Ball_SizeY) < 450 + 4'd5 && (Ball_Y_Pos + Ball_SizeY) >= 450 - 4'd5)
											)			
					begin
						Ball_Y_Motion <= -3;
					end
				// If we dont hit a platform
				else
					begin
						bool1 <= ~bool1;
						if(bool1 == 0)
						begin
							bool2 <= ~bool2;
							if(bool2 == 0)
							begin
								bool3 <= ~bool3;
								if(bool3 == 0)
								begin
									Ball_Y_Motion <= Ball_Y_Motion + 1;
								end
							end
							
						end						

						//Ball_Y_Motion <= Ball_Y_Motion + 1;
						//Ball_Y_Motion <= Ball_Y_Motion; // Ball is somewhere in the middle, keep bouncing in position
						//Ball_Y_Motion <= -1;  // Ball is somewhere in the middle and no button is pressed, X motion no change
					end
				 //Ball_X_Motion <= Ball_X_Motion;  // You need to remove this and make both X and Y respond to keyboard input
				 
				 Ball_Y_Pos <= (Ball_Y_Pos + Ball_Y_Motion);  // Update ball position
				 Ball_X_Pos <= (Ball_X_Pos + Ball_X_Motion);
			
			
	  /**************************************************************************************
	    ATTENTION! Please answer the following quesiton in your lab report! Points will be allocated for the answers!
		 Hidden Question #2/2:
          Note that Ball_Y_Motion in the above statement may have been changed at the same clock edge
          that is causing the assignment of Ball_Y_pos.  Will the new value of Ball_Y_Motion be used,
          or the old?  How will this impact behavior of the ball during a bounce, and how might that 
          interact with a response to a keypress?  Can you fix it?  Give an answer in your Post-Lab.
      **************************************************************************************/
      
			
		end  
    end
       
    assign BallX = Ball_X_Pos;
   
    assign BallY = Ball_Y_Pos;
   
	assign gg = over;
    //assign BallS = Ball_Size;
    

endmodule
