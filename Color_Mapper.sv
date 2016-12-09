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



module  color_mapper ( input        [10:0] BallX, BallY, DrawX, DrawY, Ball_size,
                       output logic [7:0]  Red, Green, Blue );
    
    // parameters for the doodle guy
    logic ball_on;
    //logic [10:0] BallX = BallX; 
    //logic [10:0] BallY = BallY;
    logic [10:0] ball_size_X = 8; 
    logic [10:0] ball_size_Y = 10;

    // turn on platform
    logic platform_on;
    // Platform1 
    logic [10:0] platform1_X1 = 240;
    logic [10:0] platform1_X2 = 248;
    logic [10:0] platform1_X3 = 256;
    logic [10:0] platform1_X4 = 264;
    logic [10:0] platform1_X5 = 272;
    logic [10:0] platform1_X6 = 280;
    logic [10:0] platform1_X7 = 288;
    logic [10:0] platform1_X8 = 296;
    logic [10:0] platform1_X9 = 304;
    logic [10:0] platform1_X10 = 312;
    logic [10:0] platform1_Y = 470;
    // Platform2
    logic [10:0] platform2_X1 = 165;
    logic [10:0] platform2_X2 = 173;
    logic [10:0] platform2_X3 = 181;
    logic [10:0] platform2_X4 = 189;
    logic [10:0] platform2_X5 = 197;
    logic [10:0] platform2_X6 = 205;
    logic [10:0] platform2_X7 = 213;
    logic [10:0] platform2_X8 = 221;
    logic [10:0] platform2_X9 = 229;
    logic [10:0] platform2_X10 = 237;
    logic [10:0] platform2_Y = 455;
    // Platform3
    logic [10:0] platform3_X1 = 317;
    logic [10:0] platform3_X2 = 325;
    logic [10:0] platform3_X3 = 333;
    logic [10:0] platform3_X4 = 341;
    logic [10:0] platform3_X5 = 349;
    logic [10:0] platform3_X6 = 357;
    logic [10:0] platform3_X7 = 365;
    logic [10:0] platform3_X8 = 373;
    logic [10:0] platform3_X9 = 381;
    logic [10:0] platform3_X10 = 389;
    logic [10:0] platform3_Y = 450;
    // Platform4
     logic [10:0] platform4_X1 = 250;
     logic [10:0] platform4_X2 = 258;
     logic [10:0] platform4_X3 = 266;
     logic [10:0] platform4_X4 = 274;
     logic [10:0] platform4_X5 = 272;
     logic [10:0] platform4_X6 = 280;
     logic [10:0] platform4_X7 = 288;
     logic [10:0] platform4_X8 = 296;
     logic [10:0] platform4_X9 = 304;
     logic [10:0] platform4_X10 = 312;
     logic [10:0] platform4_Y = 243;
    // Platform5
     logic [10:0] platform5_X1 = 260;
     logic [10:0] platform5_X2 = 268;
     logic [10:0] platform5_X3 = 276;
     logic [10:0] platform5_X4 = 284;
     logic [10:0] platform5_X5 = 292;
     logic [10:0] platform5_X6 = 300;
     logic [10:0] platform5_X7 = 308;
     logic [10:0] platform5_X8 = 316;
     logic [10:0] platform5_X9 = 324;
     logic [10:0] platform5_X10 = 332;
     logic [10:0] platform5_Y = 436;
    // Platform6
     logic [10:0] platform6_X1 = 180;
     logic [10:0] platform6_X2 = 188;
     logic [10:0] platform6_X3 = 196;
     logic [10:0] platform6_X4 = 204;
     logic [10:0] platform6_X5 = 212;
     logic [10:0] platform6_X6 = 220;
     logic [10:0] platform6_X7 = 228;
     logic [10:0] platform6_X8 = 236;
     logic [10:0] platform6_X9 = 244;
     logic [10:0] platform6_X10 = 252;
     logic [10:0] platform6_Y = 428;
    // Platform7
     logic [10:0] platform7_X1 = 130;
     logic [10:0] platform7_X2 = 138;
     logic [10:0] platform7_X3 = 146;
     logic [10:0] platform7_X4 = 154;
     logic [10:0] platform7_X5 = 162;
     logic [10:0] platform7_X6 = 170;
     logic [10:0] platform7_X7 = 178;
     logic [10:0] platform7_X8 = 186;
     logic [10:0] platform7_X9 = 194;
     logic [10:0] platform7_X10 = 202;
     logic [10:0] platform7_Y = 417;
    // Platform8
     logic [10:0] platform8_X1 = 330;
     logic [10:0] platform8_X2 = 338;
     logic [10:0] platform8_X3 = 346;
     logic [10:0] platform8_X4 = 354;
     logic [10:0] platform8_X5 = 362;
     logic [10:0] platform8_X6 = 370;
     logic [10:0] platform8_X7 = 378;
     logic [10:0] platform8_X8 = 386;
     logic [10:0] platform8_X9 = 394;
     logic [10:0] platform8_X10 = 402;
     logic [10:0] platform8_Y = 403;	 
	  
	  
	logic [10:0] platform_size_X = 8; 
	logic [10:0] platform_size_Y = 16;

    // font rom stuff, only used for doodle guy
    logic [10:0] sprite_addr;
    logic [7:0] sprite_data;
    font_rom (.addr(sprite_addr), .data(sprite_data));

    always_comb
    begin:Ball_on_proc

        // drawing the ball sprite
	    if(DrawX >= BallX && DrawX < BallX + ball_size_X &&
			 DrawY >= BallY && DrawY < BallY + ball_size_Y)
		 begin
			ball_on = 1'b1;
			platform_on = 1'b0;
            sprite_addr = (DrawY - BallY + 16*'h02);
		 end

         // drawing the platform1 sprite
		 else if(DrawX >= platform1_X1 && DrawX < platform1_X1 + platform_size_X &&
			      DrawY >= platform1_Y && DrawY < platform1_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform1_Y + 16*'h00);
	     end
        else if(DrawX >= platform1_X2 && DrawX < platform1_X2 + platform_size_X &&
			      DrawY >= platform1_Y && DrawY < platform1_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform1_Y + 16*'h00);
	    end
        else if(DrawX >= platform1_X3 && DrawX < platform1_X3 + platform_size_X &&
			      DrawY >= platform1_Y && DrawY < platform1_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform1_Y + 16*'h00);
	    end
        else if(DrawX >= platform1_X4 && DrawX < platform1_X4 + platform_size_X &&
			      DrawY >= platform1_Y && DrawY < platform1_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform1_Y + 16*'h00);
	    end
        else if(DrawX >= platform1_X5 && DrawX < platform1_X5 + platform_size_X &&
			      DrawY >= platform1_Y && DrawY < platform1_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform1_Y + 16*'h00);
	    end
        else if(DrawX >= platform1_X6 && DrawX < platform1_X6 + platform_size_X &&
			      DrawY >= platform1_Y && DrawY < platform1_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform1_Y + 16*'h00);
	    end
        else if(DrawX >= platform1_X7 && DrawX < platform1_X7 + platform_size_X &&
			      DrawY >= platform1_Y && DrawY < platform1_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform1_Y + 16*'h00);
	    end
        else if(DrawX >= platform1_X8 && DrawX < platform1_X8 + platform_size_X &&
			      DrawY >= platform1_Y && DrawY < platform1_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform1_Y + 16*'h00);
	    end
        else if(DrawX >= platform1_X9 && DrawX < platform1_X9 + platform_size_X &&
			      DrawY >= platform1_Y && DrawY < platform1_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform1_Y + 16*'h00);
	    end
        else if(DrawX >= platform1_X10 && DrawX < platform1_X10 + platform_size_X &&
			      DrawY >= platform1_Y && DrawY < platform1_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform1_Y + 16*'h00);
	    end

        // drawing the platform2 sprite
		 else if(DrawX >= platform2_X1 && DrawX < platform2_X1 + platform_size_X &&
			      DrawY >= platform2_Y && DrawY < platform2_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform2_Y + 16*'h00);
	     end
        else if(DrawX >= platform2_X2 && DrawX < platform2_X2 + platform_size_X &&
			      DrawY >= platform2_Y && DrawY < platform2_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform2_Y + 16*'h00);
	    end
        else if(DrawX >= platform2_X3 && DrawX < platform2_X3 + platform_size_X &&
			      DrawY >= platform2_Y && DrawY < platform2_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform2_Y + 16*'h00);
	    end
        else if(DrawX >= platform2_X4 && DrawX < platform2_X4 + platform_size_X &&
			      DrawY >= platform2_Y && DrawY < platform2_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform2_Y + 16*'h00);
	    end
        else if(DrawX >= platform2_X5 && DrawX < platform2_X5 + platform_size_X &&
			      DrawY >= platform2_Y && DrawY < platform2_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform2_Y + 16*'h00);
	    end
        else if(DrawX >= platform2_X6 && DrawX < platform2_X6 + platform_size_X &&
			      DrawY >= platform2_Y && DrawY < platform2_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform2_Y + 16*'h00);
	    end
        else if(DrawX >= platform2_X7 && DrawX < platform2_X7 + platform_size_X &&
			      DrawY >= platform2_Y && DrawY < platform2_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform2_Y + 16*'h00);
	    end
        else if(DrawX >= platform2_X8 && DrawX < platform2_X8 + platform_size_X &&
			      DrawY >= platform2_Y && DrawY < platform2_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform2_Y + 16*'h00);
	    end
        else if(DrawX >= platform2_X9 && DrawX < platform2_X9 + platform_size_X &&
			      DrawY >= platform2_Y && DrawY < platform2_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform2_Y + 16*'h00);
	    end
        else if(DrawX >= platform2_X10 && DrawX < platform2_X10 + platform_size_X &&
			      DrawY >= platform2_Y && DrawY < platform2_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform2_Y + 16*'h00);
	    end

        // drawing the platform3 sprite
		 else if(DrawX >= platform3_X1 && DrawX < platform3_X1 + platform_size_X &&
			      DrawY >= platform3_Y && DrawY < platform3_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform3_Y + 16*'h00);
	     end
        else if(DrawX >= platform3_X2 && DrawX < platform3_X2 + platform_size_X &&
			      DrawY >= platform3_Y && DrawY < platform3_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform3_Y + 16*'h00);
	    end
        else if(DrawX >= platform3_X3 && DrawX < platform3_X3 + platform_size_X &&
			      DrawY >= platform3_Y && DrawY < platform3_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform3_Y + 16*'h00);
	    end
        else if(DrawX >= platform3_X4 && DrawX < platform3_X4 + platform_size_X &&
			      DrawY >= platform3_Y && DrawY < platform3_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform3_Y + 16*'h00);
	    end
        else if(DrawX >= platform3_X5 && DrawX < platform3_X5 + platform_size_X &&
			      DrawY >= platform3_Y && DrawY < platform3_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform3_Y + 16*'h00);
	    end
        else if(DrawX >= platform3_X6 && DrawX < platform3_X6 + platform_size_X &&
			      DrawY >= platform3_Y && DrawY < platform3_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform3_Y + 16*'h00);
	    end
        else if(DrawX >= platform3_X7 && DrawX < platform3_X7 + platform_size_X &&
			      DrawY >= platform3_Y && DrawY < platform3_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform3_Y + 16*'h00);
	    end
        else if(DrawX >= platform3_X8 && DrawX < platform3_X8 + platform_size_X &&
			      DrawY >= platform3_Y && DrawY < platform3_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform3_Y + 16*'h00);
	    end
        else if(DrawX >= platform3_X9 && DrawX < platform3_X9 + platform_size_X &&
			      DrawY >= platform3_Y && DrawY < platform3_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform3_Y + 16*'h00);
	    end
        else if(DrawX >= platform3_X10 && DrawX < platform3_X10 + platform_size_X &&
			      DrawY >= platform3_Y && DrawY < platform3_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform3_Y + 16*'h00);
	    end
		 
		 // drawing the platform4 sprite
		 else if(DrawX >= platform4_X1 && DrawX < platform4_X1 + platform_size_X &&
			      DrawY >= platform4_Y && DrawY < platform4_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform4_Y + 16*'h00);
	     end
        else if(DrawX >= platform4_X2 && DrawX < platform4_X2 + platform_size_X &&
			      DrawY >= platform4_Y && DrawY < platform4_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform4_Y + 16*'h00);
	    end
        else if(DrawX >= platform4_X3 && DrawX < platform4_X3 + platform_size_X &&
			      DrawY >= platform4_Y && DrawY < platform4_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform4_Y + 16*'h00);
	    end
        else if(DrawX >= platform4_X4 && DrawX < platform4_X4 + platform_size_X &&
			      DrawY >= platform4_Y && DrawY < platform4_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform4_Y + 16*'h00);
	    end
        else if(DrawX >= platform4_X5 && DrawX < platform4_X5 + platform_size_X &&
			      DrawY >= platform4_Y && DrawY < platform4_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform4_Y + 16*'h00);
	    end
        else if(DrawX >= platform4_X6 && DrawX < platform4_X6 + platform_size_X &&
			      DrawY >= platform4_Y && DrawY < platform4_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform4_Y + 16*'h00);
	    end
        else if(DrawX >= platform4_X7 && DrawX < platform4_X7 + platform_size_X &&
			      DrawY >= platform4_Y && DrawY < platform4_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform4_Y + 16*'h00);
	    end
        else if(DrawX >= platform4_X8 && DrawX < platform4_X8 + platform_size_X &&
			      DrawY >= platform4_Y && DrawY < platform4_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform4_Y + 16*'h00);
	    end
        else if(DrawX >= platform4_X9 && DrawX < platform4_X9 + platform_size_X &&
			      DrawY >= platform4_Y && DrawY < platform4_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform4_Y + 16*'h00);
	    end
        else if(DrawX >= platform4_X10 && DrawX < platform4_X10 + platform_size_X &&
			      DrawY >= platform4_Y && DrawY < platform4_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform4_Y + 16*'h00);
	    end
		
				 // drawing the platform5 sprite
		 else if(DrawX >= platform5_X1 && DrawX < platform5_X1 + platform_size_X &&
			      DrawY >= platform5_Y && DrawY < platform5_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform5_Y + 16*'h00);
	     end
        else if(DrawX >= platform5_X2 && DrawX < platform5_X2 + platform_size_X &&
			      DrawY >= platform5_Y && DrawY < platform5_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform5_Y + 16*'h00);
	    end
        else if(DrawX >= platform5_X3 && DrawX < platform5_X3 + platform_size_X &&
			      DrawY >= platform5_Y && DrawY < platform5_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform5_Y + 16*'h00);
	    end
        else if(DrawX >= platform5_X4 && DrawX < platform5_X4 + platform_size_X &&
			      DrawY >= platform5_Y && DrawY < platform5_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform5_Y + 16*'h00);
	    end
        else if(DrawX >= platform5_X5 && DrawX < platform5_X5 + platform_size_X &&
			      DrawY >= platform5_Y && DrawY < platform5_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform5_Y + 16*'h00);
	    end
        else if(DrawX >= platform5_X6 && DrawX < platform5_X6 + platform_size_X &&
			      DrawY >= platform5_Y && DrawY < platform5_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform5_Y + 16*'h00);
	    end
        else if(DrawX >= platform5_X7 && DrawX < platform5_X7 + platform_size_X &&
			      DrawY >= platform5_Y && DrawY < platform5_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform5_Y + 16*'h00);
	    end
        else if(DrawX >= platform5_X8 && DrawX < platform5_X8 + platform_size_X &&
			      DrawY >= platform5_Y && DrawY < platform5_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform5_Y + 16*'h00);
	    end
        else if(DrawX >= platform5_X9 && DrawX < platform5_X9 + platform_size_X &&
			      DrawY >= platform5_Y && DrawY < platform5_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform5_Y + 16*'h00);
	    end
        else if(DrawX >= platform5_X10 && DrawX < platform5_X10 + platform_size_X &&
			      DrawY >= platform5_Y && DrawY < platform5_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform5_Y + 16*'h00);
	    end
		
		 // drawing the platform6 sprite
		 else if(DrawX >= platform6_X1 && DrawX < platform6_X1 + platform_size_X &&
			      DrawY >= platform6_Y && DrawY < platform6_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform6_Y + 16*'h00);
	     end
        else if(DrawX >= platform6_X2 && DrawX < platform6_X2 + platform_size_X &&
			      DrawY >= platform6_Y && DrawY < platform6_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform6_Y + 16*'h00);
	    end
        else if(DrawX >= platform6_X3 && DrawX < platform6_X3 + platform_size_X &&
			      DrawY >= platform6_Y && DrawY < platform6_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform6_Y + 16*'h00);
	    end
        else if(DrawX >= platform6_X4 && DrawX < platform6_X4 + platform_size_X &&
			      DrawY >= platform6_Y && DrawY < platform6_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform6_Y + 16*'h00);
	    end
        else if(DrawX >= platform6_X5 && DrawX < platform6_X5 + platform_size_X &&
			      DrawY >= platform6_Y && DrawY < platform6_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform6_Y + 16*'h00);
	    end
        else if(DrawX >= platform6_X6 && DrawX < platform6_X6 + platform_size_X &&
			      DrawY >= platform6_Y && DrawY < platform6_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform6_Y + 16*'h00);
	    end
        else if(DrawX >= platform6_X7 && DrawX < platform6_X7 + platform_size_X &&
			      DrawY >= platform6_Y && DrawY < platform6_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform6_Y + 16*'h00);
	    end
        else if(DrawX >= platform6_X8 && DrawX < platform6_X8 + platform_size_X &&
			      DrawY >= platform6_Y && DrawY < platform6_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform6_Y + 16*'h00);
	    end
        else if(DrawX >= platform6_X9 && DrawX < platform6_X9 + platform_size_X &&
			      DrawY >= platform6_Y && DrawY < platform6_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform6_Y + 16*'h00);
	    end
        else if(DrawX >= platform6_X10 && DrawX < platform6_X10 + platform_size_X &&
			      DrawY >= platform6_Y && DrawY < platform6_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform6_Y + 16*'h00);
	    end
		
		 // drawing the platform7 sprite
		 else if(DrawX >= platform7_X1 && DrawX < platform7_X1 + platform_size_X &&
			      DrawY >= platform7_Y && DrawY < platform7_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform7_Y + 16*'h00);
	     end
        else if(DrawX >= platform7_X2 && DrawX < platform7_X2 + platform_size_X &&
			      DrawY >= platform7_Y && DrawY < platform7_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform7_Y + 16*'h00);
	    end
        else if(DrawX >= platform7_X3 && DrawX < platform7_X3 + platform_size_X &&
			      DrawY >= platform7_Y && DrawY < platform7_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform7_Y + 16*'h00);
	    end
        else if(DrawX >= platform7_X4 && DrawX < platform7_X4 + platform_size_X &&
			      DrawY >= platform7_Y && DrawY < platform7_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform7_Y + 16*'h00);
	    end
        else if(DrawX >= platform7_X5 && DrawX < platform7_X5 + platform_size_X &&
			      DrawY >= platform7_Y && DrawY < platform7_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform7_Y + 16*'h00);
	    end
        else if(DrawX >= platform7_X6 && DrawX < platform7_X6 + platform_size_X &&
			      DrawY >= platform7_Y && DrawY < platform7_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform7_Y + 16*'h00);
	    end
        else if(DrawX >= platform7_X7 && DrawX < platform7_X7 + platform_size_X &&
			      DrawY >= platform7_Y && DrawY < platform7_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform7_Y + 16*'h00);
	    end
        else if(DrawX >= platform7_X8 && DrawX < platform7_X8 + platform_size_X &&
			      DrawY >= platform7_Y && DrawY < platform7_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform7_Y + 16*'h00);
	    end
        else if(DrawX >= platform7_X9 && DrawX < platform7_X9 + platform_size_X &&
			      DrawY >= platform7_Y && DrawY < platform7_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform7_Y + 16*'h00);
	    end
        else if(DrawX >= platform7_X10 && DrawX < platform7_X10 + platform_size_X &&
			      DrawY >= platform7_Y && DrawY < platform7_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform7_Y + 16*'h00);
	    end
		
		 // drawing the platform8 sprite
		 else if(DrawX >= platform8_X1 && DrawX < platform8_X1 + platform_size_X &&
			      DrawY >= platform8_Y && DrawY < platform8_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform8_Y + 16*'h00);
	     end
        else if(DrawX >= platform8_X2 && DrawX < platform8_X2 + platform_size_X &&
			      DrawY >= platform8_Y && DrawY < platform8_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform8_Y + 16*'h00);
	    end
        else if(DrawX >= platform8_X3 && DrawX < platform8_X3 + platform_size_X &&
			      DrawY >= platform8_Y && DrawY < platform8_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform8_Y + 16*'h00);
	    end
        else if(DrawX >= platform8_X4 && DrawX < platform8_X4 + platform_size_X &&
			      DrawY >= platform8_Y && DrawY < platform8_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform8_Y + 16*'h00);
	    end
        else if(DrawX >= platform8_X5 && DrawX < platform8_X5 + platform_size_X &&
			      DrawY >= platform8_Y && DrawY < platform8_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform8_Y + 16*'h00);
	    end
        else if(DrawX >= platform8_X6 && DrawX < platform8_X6 + platform_size_X &&
			      DrawY >= platform8_Y && DrawY < platform8_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform8_Y + 16*'h00);
	    end
        else if(DrawX >= platform8_X7 && DrawX < platform8_X7 + platform_size_X &&
			      DrawY >= platform8_Y && DrawY < platform8_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform8_Y + 16*'h00);
	    end
        else if(DrawX >= platform8_X8 && DrawX < platform8_X8 + platform_size_X &&
			      DrawY >= platform8_Y && DrawY < platform8_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform8_Y + 16*'h00);
	    end
        else if(DrawX >= platform8_X9 && DrawX < platform8_X9 + platform_size_X &&
			      DrawY >= platform8_Y && DrawY < platform8_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform8_Y + 16*'h00);
	    end
        else if(DrawX >= platform8_X10 && DrawX < platform8_X10 + platform_size_X &&
			      DrawY >= platform8_Y && DrawY < platform8_Y + platform_size_Y)
		 begin
			ball_on = 1'b0;
			platform_on = 1'b1;
            sprite_addr = (DrawY - platform8_Y + 16*'h00);
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
        if ((ball_on == 1'b1) && (sprite_data[DrawX - BallX] == 1'b1)) 
        begin 
            Red = 8'h00;
            Green = 8'hff;
            Blue = 8'hff;
        end

        // display the platform1
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform1_X1] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform1_X2] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform1_X3] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform1_X4] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform1_X5] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform1_X6] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform1_X7] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform1_X8] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform1_X9] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform1_X10] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end

        // display the platform2
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform2_X1] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform2_X2] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform2_X3] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform2_X4] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform2_X5] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform2_X6] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform2_X7] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform2_X8] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform2_X9] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform2_X10] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        
        // display the platform3
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform3_X1] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform3_X2] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform3_X3] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform3_X4] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform3_X5] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform3_X6] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform3_X7] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform3_X8] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform3_X9] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform3_X10] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
		  
		  // display the platform4
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform4_X1] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform4_X2] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform4_X3] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform4_X4] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform4_X5] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform4_X6] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform4_X7] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform4_X8] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform4_X9] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform4_X10] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
		  
		  // display the platform5
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform5_X1] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform5_X2] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform5_X3] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform5_X4] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform5_X5] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform5_X6] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform5_X7] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform5_X8] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform5_X9] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform5_X10] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
		  
		  // display the platform6
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform6_X1] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform6_X2] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform6_X3] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform6_X4] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform6_X5] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform6_X6] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform6_X7] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform6_X8] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform6_X9] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform6_X10] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
		  
		  // display the platform7
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform7_X1] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform7_X2] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform7_X3] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform7_X4] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform7_X5] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform7_X6] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform7_X7] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform7_X8] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform7_X9] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform7_X10] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
		  
		  // display the platform8
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform8_X1] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform8_X2] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform8_X3] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform8_X4] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform8_X5] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform8_X6] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform8_X7] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform8_X8] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform8_X9] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
        end
        else if ((platform_on == 1'b1) && (sprite_data[DrawX - platform8_X10] == 1'b1))
        begin
            Red = 8'h00;
            Green = 8'h11;
            Blue = 8'h33;
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
