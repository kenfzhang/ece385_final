//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//                                                                       --
//    Fall 2014 Distribution                                             --
//                                                                       --
//    For use with ECE 385 Lab 7                                         --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------



module  color_mapper ( input        [9:0] BallX, BallY, DrawX, DrawY, Ball_size,
                       output logic [7:0]  Red, Green, Blue );
    
    logic ball_on;
    logic [10:0] ball_X = 320; 
    logic [10:0] ball_Y = 240;
    logic [10:0] ball_size_X = 8; 
    logic [10:0] ball_size_Y = 16;

    logic platform_on;
    logic [10:0] platform_X = 320; 
	logic [10:0] platform_Y = 300;
	logic [10:0] platform_size_X = 8; 
	logic [10:0] platform_size_Y = 16;

    logic [10:0] sprite_addr;
    logic [7:0] sprite_data;
    font_rom (.addr(sprite_addr), .data(sprite_data));

    always_comb
    begin:Ball_on_proc
	    if(DrawX >= ball_X && DrawX < ball_X + ball_size_X &&
			 DrawY >= ball_Y && DrawY < ball_Y + ball_size_Y)
		 begin
			ball_on = 1'b1;
			platform_on = 1'b0;
            sprite_addr = (DrawY - ball_Y + 16*'h02);
		 end
		 else if(DrawX >= platform_X && DrawX < platform_X + platform_size_X &&
			      DrawY >= platform_Y && DrawY < platform_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform_Y + 16*'h2d);
	    end
		else
		begin
            ball_on = 1'b0;
			platform_on = 1'b0;
            sprite_addr = 1'b0;
		end 
    end 
       
    always_comb
    begin:RGB_Display

        // display the bouncing ball: BLACK
        if ((ball_on == 1'b1) && (sprite_data[DrawX - ball_X] == 1'b1)) 
        begin 
            Red = 8'h00;
            Green = 8'hff;
            Blue = 8'hff;
        end

        // display the shape: BLACK
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform_X] == 1'b1))
        begin
            Red = 8'hff;
            Green = 8'hff;
            Blue = 8'h00;
        end

        // else display the background
        else 
        begin 
            Red = 8'hff;// - DrawX[9:3]; 
            Green = 8'hff;
            Blue = 8'hff; //- DrawX[9:3];
        end      
    end 
    
endmodule
