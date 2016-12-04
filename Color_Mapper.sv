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
    
    // parameters for the doodle guy
    logic ball_on;
    logic [10:0] ball_X = 320; 
    logic [10:0] ball_Y = 240;
    logic [10:0] ball_size_X = 8; 
    logic [10:0] ball_size_Y = 16;

    // turn on platform
    logic platform_on;
    logic [10:0] platform1_X1 = 240;
    logic [10:0] platform1_X2 = platform1_X1 + platform_size_X;
    logic [10:0] platform1_X3 = platform1_X2 + platform_size_X;
    logic [10:0] platform1_X4 = platform1_X3 + platform_size_X;
    logic [10:0] platform1_X5 = platform1_X4 + platform_size_X;
    logic [10:0] platform1_X6 = platform1_X5 + platform_size_X;
    logic [10:0] platform1_X7 = platform1_X6 + platform_size_X;
    logic [10:0] platform1_X8 = platform1_X7 + platform_size_X;
    logic [10:0] platform1_X9 = platform1_X8 + platform_size_X;
    logic [10:0] platform1_X10 = platform1_X9 + platform_size_X;

	logic [10:0] platform1_Y = 470;
	logic [10:0] platform_size_X = 8; 
	logic [10:0] platform_size_Y = 16;

    // font rom stuff, only used for doodle guy
    logic [10:0] sprite_addr;
    logic [7:0] sprite_data;
    font_rom (.addr(sprite_addr), .data(sprite_data));

    always_comb
    begin:Ball_on_proc

        // drawing the ball sprite
	    if(DrawX >= ball_X && DrawX < ball_X + ball_size_X &&
			 DrawY >= ball_Y && DrawY < ball_Y + ball_size_Y)
		 begin
			ball_on = 1'b1;
			platform_on = 1'b0;
            sprite_addr = (DrawY - ball_Y + 16*'h02);
		 end

         // drawing the platform1 sprite
		 else if(DrawX >= platform1_X1 && DrawX < platform1_X1 + platform_size_X &&
			      DrawY >= platform1_Y && DrawY < platform1_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            platform_addr = (DrawY - platform_Y + 16*'h00);
	    end
        else if(DrawX >= platform1_X2 && DrawX < platform1_X2 + platform_size_X &&
			      DrawY >= platform1_Y && DrawY < platform1_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            platform_addr = (DrawY - platform_Y + 16*'h00);
	    end
        else if(DrawX >= platform1_X3 && DrawX < platform1_X3 + platform_size_X &&
			      DrawY >= platform1_Y && DrawY < platform1_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            platform_addr = (DrawY - platform_Y + 16*'h00);
	    end
        else if(DrawX >= platform1_X4 && DrawX < platform1_X4 + platform_size_X &&
			      DrawY >= platform1_Y && DrawY < platform1_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            platform_addr = (DrawY - platform_Y + 16*'h00);
	    end
        else if(DrawX >= platform1_X5 && DrawX < platform1_X5 + platform_size_X &&
			      DrawY >= platform1_Y && DrawY < platform1_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            platform_addr = (DrawY - platform_Y + 16*'h00);
	    end
        else if(DrawX >= platform1_X6 && DrawX < platform1_X6 + platform_size_X &&
			      DrawY >= platform1_Y && DrawY < platform1_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            platform_addr = (DrawY - platform_Y + 16*'h00);
	    end
        else if(DrawX >= platform1_X7 && DrawX < platform1_X7 + platform_size_X &&
			      DrawY >= platform1_Y && DrawY < platform1_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            platform_addr = (DrawY - platform_Y + 16*'h00);
	    end
        else if(DrawX >= platform1_X8 && DrawX < platform1_X8 + platform_size_X &&
			      DrawY >= platform1_Y && DrawY < platform1_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            platform_addr = (DrawY - platform_Y + 16*'h00);
	    end
        else if(DrawX >= platform1_X9 && DrawX < platform1_X9 + platform_size_X &&
			      DrawY >= platform1_Y && DrawY < platform1_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            platform_addr = (DrawY - platform_Y + 16*'h00);
	    end
        else if(DrawX >= platform1_X10 && DrawX < platform1_X10 + platform_size_X &&
			      DrawY >= platform1_Y && DrawY < platform1_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            platform_addr = (DrawY - platform_Y + 16*'h00);
	    end

        // else, draw nothing
		else
		begin
            ball_on = 1'b0;
			platform_on = 1'b0;
            sprite_addr = 1'b0;
		end

    end 
       
    always_comb
    begin:RGB_Display

        // display the bouncing ball
        if ((ball_on == 1'b1) && (sprite_data[DrawX - ball_X] == 1'b1)) 
        begin 
            Red = 8'h00;
            Green = 8'hff;
            Blue = 8'hff;
        end

        // display the platform
        else if ((platform_on == 1'b1) && (platform_data[DrawX - platform1_X1] == 1'b1))
        begin
            Red = 8'hff;
            Green = 8'hff;
            Blue = 8'h00;
        end
        else if ((platform_on == 1'b1) && (platform_data[DrawX - platform1_X2] == 1'b1))
        begin
            Red = 8'hff;
            Green = 8'hff;
            Blue = 8'h00;
        end
        else if ((platform_on == 1'b1) && (platform_data[DrawX - platform1_X3] == 1'b1))
        begin
            Red = 8'hff;
            Green = 8'hff;
            Blue = 8'h00;
        end
        else if ((platform_on == 1'b1) && (platform_data[DrawX - platform1_X4] == 1'b1))
        begin
            Red = 8'hff;
            Green = 8'hff;
            Blue = 8'h00;
        end
        else if ((platform_on == 1'b1) && (platform_data[DrawX - platform1_X5] == 1'b1))
        begin
            Red = 8'hff;
            Green = 8'hff;
            Blue = 8'h00;
        end
        else if ((platform_on == 1'b1) && (platform_data[DrawX - platform1_X6] == 1'b1))
        begin
            Red = 8'hff;
            Green = 8'hff;
            Blue = 8'h00;
        end
        else if ((platform_on == 1'b1) && (platform_data[DrawX - platform1_X7] == 1'b1))
        begin
            Red = 8'hff;
            Green = 8'hff;
            Blue = 8'h00;
        end
        else if ((platform_on == 1'b1) && (platform_data[DrawX - platform1_X8] == 1'b1))
        begin
            Red = 8'hff;
            Green = 8'hff;
            Blue = 8'h00;
        end
        else if ((platform_on == 1'b1) && (platform_data[DrawX - platform1_X9] == 1'b1))
        begin
            Red = 8'hff;
            Green = 8'hff;
            Blue = 8'h00;
        end
        else if ((platform_on == 1'b1) && (platform_data[DrawX - platform1_X10] == 1'b1))
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
