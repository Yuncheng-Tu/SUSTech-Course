// The multiplier template is provided, and you should modify it to the improved one and share the hardware resource to implement division.
module MCycle
#(
    parameter WIDTH = 32  // 32-bits for ARMv3
) 
(
    input CLK,   // Connect to CPU clock
    input RESET, // Connect to the reset of the ARM processor.
    input Start, // Multi-cycle Enable. The control unit should assert this when MUL or DIV instruction is detected.
    input [1:0] MCycleOp, // Multi-cycle Operation. "0" for unsigned multiplication, "1" for unsigned division. Generated by Control unit. "2" for floating add "3" for floating multiply
    input [WIDTH-1:0] Operand1, // Multiplicand / Dividend
    input [WIDTH-1:0] Operand2, // Multiplier / Divisor

    input Stall,

    output reg [WIDTH-1:0] Result,  //For MUL, assign the lower-32bits result; For DIV, assign the quotient.
    output reg Busy, // Set immediately when Start is set. Cleared when the Results become ready. This bit can be used to stall the processor while multi-cycle operations are on.
    input i_MCycle_signal
);

    localparam IDLE = 1'b0;
    localparam COMPUTING = 1'b1;
    localparam ADD_LATENCY = 3;
    localparam MUL_LATENCY = 26;
    localparam EXP_WIDTH = 8;
    localparam FRAC_WIDTH = 24;
    localparam EXP_MAX = 2 ** EXP_WIDTH - 1;

    reg state, n_state;
    reg done;
    reg [1:0] reg_op;
    // reg Busy;

    reg signal_reg;
    always @(posedge CLK or posedge RESET) begin
      if(RESET) begin
        signal_reg <= 1'b0;
      end
      else begin
        signal_reg <= i_MCycle_signal;
      end
    end
    // state machine
    always @(posedge CLK or posedge RESET) begin
      if(RESET)
        state <= IDLE;
      else
        state <= n_state;
    end

    always @(*) begin
      case(state)
        IDLE: begin
          if(Start & ~signal_reg) begin
            n_state = COMPUTING;
            Busy = 1'b1;
          end
          else  begin
            n_state = IDLE;
            Busy = 1'b0;
          end
        end

        COMPUTING:  begin
          if(~done) begin
            n_state = COMPUTING;
            Busy = 1'b1;
          end
          else begin
            n_state = IDLE;
            Busy = 1'b0;
          end
        end
      endcase
    end

    reg [5:0] count = 0 ; // assuming no computation takes more than 64 cycles.
    // reg [2*WIDTH-1:0] temp_sum = 0 ;
    reg [2*WIDTH-1:0] shifted_op1 = 0;
    reg [WIDTH-1:0] op2 = 0 ;
    
    // assign shifted_op1_ready = MCycleOp ? {{(WIDTH-1){1'b0}}, Operand1, 1'b0}:{{(WIDTH){1'b0}}, Operand1};

    // reg sign_extend = 0;
    // wire sign_extend_re;

    wire DIVIDE_READY = (op2 <= shifted_op1[2*WIDTH-2:WIDTH-1]) ? 1: 0;
    wire [WIDTH-1:0] divide_temp_result = (DIVIDE_READY) ? shifted_op1[2*WIDTH-2:WIDTH-1] - op2 : shifted_op1[2*WIDTH-2:WIDTH-1];
    
    // Multi-cycle Multiplier & divider
    always@(posedge CLK or posedge RESET) begin: COMPUTING_PROCESS // process which does the actual computation
      if(RESET) begin
        count <= 0 ;
        shifted_op1 <= {{(WIDTH-1){1'b0}},Operand1};
        op2 <= Operand2;
        done <= 0;
        // sign_extend <= 1'b0;
      end
      // state: IDLE
      else if(state == IDLE) begin
        if(n_state == COMPUTING) begin
          count <= 0 ;
          shifted_op1 <= {{(WIDTH-1){1'b0}},Operand1};
          op2 <= Operand2;
          done <= 0;
          reg_op <= MCycleOp;
          // sign_extend <= 1'b0;
        end
        // else IDLE->IDLE: registers unchanged
      end
      // state: COMPUTINGq
      else if(n_state == COMPUTING)
      begin
        case (reg_op)
          2'd0: begin
            if(count == WIDTH-1) begin // last cycle
                done <= 1'b1;
                count <= 0;
              end else begin 
                done <= 1'b0;
                count <= count + 1;
              end 
              if(shifted_op1[0])  begin
                shifted_op1 <= {op2, {(WIDTH-1){1'b0}}} + shifted_op1[2*WIDTH-1:1];
              end
              else  begin
                shifted_op1 <= {1'b0, shifted_op1[2*WIDTH-1:1]};
              end
              // else temp_sum unchanged
              op2 <= op2;
          end
          2'd1: begin
            if(count == WIDTH-1) begin // last cycle
              done <= 1'b1;
              count <= 0;
            end else begin
              done <= 1'b0;
              count <= count + 1;
            end
            shifted_op1 <= {divide_temp_result, shifted_op1[WIDTH-2:0], DIVIDE_READY};
            op2 <= op2;
          end
          2'd2: begin
            if(count == ADD_LATENCY-2) begin // last cycle
              done <= 1'b1;
              count <= 0;
            end else begin
              done <= 1'b0;
              count <= count + 1;
            end
            shifted_op1 <= shifted_op1;
            op2 <= op2;
          end
          2'd3: begin
            if(count == MUL_LATENCY-2) begin // last cycle
              done <= 1'b1;
              count <= 0;
            end else begin
              done <= 1'b0;
              count <= count + 1;
            end
            shifted_op1 <= shifted_op1;
            op2 <= op2;
          end
        endcase
      end
      // else COMPUTING->IDLE: registers unchanged
    end
    wire [WIDTH-1:0] test = shifted_op1[2*WIDTH-2:WIDTH-1];

/////////////////////////////////floating point part////////////////////////////////////


    wire zero_sig1,zero_sig2; // we take denorm number as zero
    assign zero_sig1 = (Operand1[WIDTH-2-:EXP_WIDTH] == 0) ;
    assign zero_sig2 = (Operand2[WIDTH-2-:EXP_WIDTH] == 0) ;
    
    wire sign1,sign2;
    wire [EXP_WIDTH-1:0] exp1,exp2;
    wire [FRAC_WIDTH-2:0] frac1,frac2;
    wire inf_sig1,inf_sig2,nan_sig1,nan_sig2;

    assign {sign1,exp1,frac1} = Operand1;
    assign {sign2,exp2,frac2} = Operand2[EXP_WIDTH+FRAC_WIDTH-1:0];

    assign inf_sig1 = (exp1==EXP_MAX)&&(frac1=={(FRAC_WIDTH-1){1'b0}});
    assign nan_sig1 = (exp1==EXP_MAX)&&(frac1!={(FRAC_WIDTH-1){1'b0}});

    assign inf_sig2 = (exp2==EXP_MAX)&&(frac2=={(FRAC_WIDTH-1){1'b0}});
    assign nan_sig2 = (exp2==EXP_MAX)&&(frac2!={(FRAC_WIDTH-1){1'b0}});

////////////////////add part/////////////////////////////

    wire [EXP_WIDTH -1:0] exp_b = exp1> exp2 ? exp1 : exp2;
    wire [EXP_WIDTH - 1:0] shift_num1 = exp_b - exp1; // must >= 0 
    wire [EXP_WIDTH - 1:0] shift_num2 = exp_b - exp2; // must >= 0
    wire [FRAC_WIDTH - 1 : 0] shift_data1= {1'b1,frac1} >>shift_num1;
    wire [FRAC_WIDTH - 1 : 0] shift_data2= {1'b1,frac2} >>shift_num2;

    reg signed [FRAC_WIDTH + 1 : 0] fix_num1 ;
    reg signed [FRAC_WIDTH + 1 : 0] fix_num2 ;
    wire [FRAC_WIDTH  : 0] shift_data1_comp = ~shift_data1 + 1;
    wire [FRAC_WIDTH  : 0] shift_data2_comp = ~shift_data2 + 1;

    always @(posedge CLK) begin
        if(zero_sig1)
            fix_num1 <= 0;
        else if(sign1)
            fix_num1 <= { sign1,shift_data1_comp};
        else
            fix_num1 <= { sign1,1'b0,shift_data1}; // avoid data overflow add one bit
    end
    always @(posedge CLK) begin
        if(zero_sig2)
            fix_num2 <= 0;
        else if(sign2)
            fix_num2 <= { sign2,shift_data2_comp};
        else
            fix_num2 <= { sign2,1'b0,shift_data2}; // avoid data overflow add one bit
    end
    
    reg signed [FRAC_WIDTH + 1 : 0] add_num_out_comp ; 
    wire [FRAC_WIDTH : 0] add_num_out_signed = ~add_num_out_comp[FRAC_WIDTH : 0] + 1;
    always @(posedge CLK) begin
        add_num_out_comp <= fix_num1 + fix_num2;; 
    end
    reg signed [FRAC_WIDTH + 1 : 0] add_num_out ; 
    always @(*) begin
        if(add_num_out_comp[FRAC_WIDTH + 1] )
          add_num_out = { add_num_out_comp[FRAC_WIDTH + 1],add_num_out_signed};
        else
          add_num_out = add_num_out_comp;
    end
    wire [31:0] a = add_num_out[FRAC_WIDTH : 0]; // needs zero padding

    wire [4:0] one_location;

    wire [1:0] find_one1;
    wire [3:0] find_one2;
    wire [7:0] find_one3;
    wire [15:0] find_one4;
    assign one_location[4] = (|a[31:16]);
    assign find_one4 = one_location[4] ? a[31:16] : a[15:0];
    assign one_location[3] = (|find_one4[15:8]);
    assign find_one3 = one_location[3] ? find_one4[15:8] : find_one4[7:0];
    assign one_location[2] = (|find_one3[7:4]);
    assign find_one2 = one_location[2] ? find_one3[7:4] : find_one3[3:0];
    assign one_location[1] = (|find_one2[3:2]);
    assign find_one1 = one_location[1] ? find_one2[3:2] : find_one2[1:0];
    assign one_location[0] = find_one1[1];
    wire zero_judge_add = (one_location == 1'b0) && (find_one1[0] == 1'b0) ? 1'b1 : 1'b0; 

    wire [EXP_WIDTH -1:0] exp_b_delay;
    shiftregister #( 2, EXP_WIDTH)  u_reg_exp_b (
          .din(exp_b),
          .clk(CLK),
          .rst(RESET),
          .dout(exp_b_delay)
      );

    wire [EXP_WIDTH - 1:0] exp_o_add = exp_b_delay + one_location - 23; // when exp b == 127 expo = 128 there has a accum overflow 
    // this problem can be solve with a judgement in output like if expo==128 output nan
    wire [EXP_WIDTH - 1:0] shift_num = 25 - one_location;
    wire [FRAC_WIDTH : 0] shift_data = add_num_out << shift_num; // shift one to highest width
    reg [WIDTH - 1:0] fl_out_add;
    wire inf_sig1_add,inf_sig2_add,nan_sig1_add,nan_sig2_add;
    wire sign1_add,sign2_add;
    shiftregister #( 2, 6)  u_reg_sig_add (
          .din({inf_sig1,inf_sig2,nan_sig1,nan_sig2,sign1,sign2}),
          .clk(CLK),
          .rst(RESET),
          .dout({inf_sig1_add,inf_sig2_add,nan_sig1_add,nan_sig2_add,sign1_add,sign2_add})
      );
    always @(posedge CLK) begin
        if(nan_sig1_add ||nan_sig2_add || ( inf_sig1_add && inf_sig2_add && sign1_add !=sign2_add )   ) 
            fl_out_add <= {1'b0, {EXP_WIDTH{1'b1}}, 1'b1, {(FRAC_WIDTH-2){1'b0}}}; //   frac != 0 NaN
        else if(  (inf_sig1_add && !sign1_add ) || (inf_sig2_add && !sign2_add ) )
            fl_out_add <= {1'b0, {EXP_WIDTH{1'b1}}, {(FRAC_WIDTH-1){1'b0}}}; // pos inf
        else if(  (inf_sig1_add && sign1_add ) || (inf_sig2_add && sign2_add ) )
            fl_out_add <= {1'b1, {EXP_WIDTH{1'b1}}, {(FRAC_WIDTH-1){1'b0}}}; // neg inf
        else if(zero_judge_add)
            fl_out_add <= 32'b0; // zero
        else
            fl_out_add <= {add_num_out[FRAC_WIDTH + 1],exp_o_add,shift_data[FRAC_WIDTH  : 2]};
    end


///////////////////////////mul part//////////////////////////////


    wire [FRAC_WIDTH - 1 : 0] mul_num1= zero_sig1 ? 0 : {1'b1,frac1};
    wire [FRAC_WIDTH - 1 : 0] mul_num2= zero_sig2 ? 0 : {1'b1,frac2};
    wire [FRAC_WIDTH * 2 -1 : 0] mul_num_out;

    wire  add_one_sig = mul_num_out[FRAC_WIDTH * 2 -1];

    wire sign_mul = sign1 + sign2; //equals xor a delay is needed
    mul u_mul(
      .clk(CLK),
      .RESET(RESET),
      .Start(Start&( &MCycleOp )),
      .a(mul_num1),
      .b(mul_num2),
      .c(mul_num_out)
    );
    wire [EXP_WIDTH-1:0] exp1_delay,exp2_delay;

    shiftregister #(25, EXP_WIDTH *2)  u_reg_exp_in (
        .din({exp1,exp2}),
        .clk(CLK),
        .rst(RESET),
        .dout({exp1_delay,exp2_delay})
    );
    wire inf_sig1_mul,inf_sig2_mul,nan_sig1_mul,nan_sig2_mul;
    wire sign_mul_delay;
    shiftregister #( 25, 5)  u_reg_sig_mul (
          .din({sign_mul,inf_sig1,inf_sig2,nan_sig1,nan_sig2}),
          .clk(CLK),
          .rst(RESET),
          .dout({sign_mul_delay,inf_sig1_mul,inf_sig2_mul,nan_sig1_mul,nan_sig2_mul})
      );

    wire [EXP_WIDTH : 0] exp_mul = exp1_delay + exp2_delay - 127; // supposed to limited in range 0 - 255, a delay is needed  if highest bit is 1 means it's bigger than 255 or smaller than 0 we take it as nan
    wire [EXP_WIDTH : 0] exp_mul_p = exp_mul + 1;
    wire inf_judge = add_one_sig ? exp_mul_p[EXP_WIDTH] : exp_mul[EXP_WIDTH];
    wire [FRAC_WIDTH -2 :0] mantissa_mul = add_one_sig? mul_num_out[FRAC_WIDTH * 2 -2 -: (FRAC_WIDTH -1) ] : mul_num_out[FRAC_WIDTH * 2 -3 -: (FRAC_WIDTH -1)  ];
    wire [EXP_WIDTH -1 :0] exp_o_mul = add_one_sig? exp_mul_p[EXP_WIDTH -1 :0] : exp_mul[EXP_WIDTH -1 :0];
    reg [WIDTH - 1:0] fl_out_mul;


    always @(posedge CLK) begin
        if(nan_sig1_mul ||nan_sig2_mul   ) 
            fl_out_mul <= {1'b0, {EXP_WIDTH{1'b1}}, 1'b1, {(FRAC_WIDTH-2){1'b0}}}; //  NaN
        else if(  inf_sig1_mul || inf_sig2_mul || inf_judge)
            fl_out_mul <= {sign_mul_delay, {EXP_WIDTH{1'b1}}, {(FRAC_WIDTH-1){1'b0}}}; // inf
        else
            fl_out_mul <= {sign_mul_delay, exp_o_mul  , mantissa_mul };
    end

///////////////////////////////////result control part////////////////////////////////////////////////////
    // reg [31:0] Result_temp;
    // reg [31:0] Result_reg;
    reg Busy_reg;

    always @(*) begin
        case (reg_op)
          2'd0: Result = shifted_op1[WIDTH-1:0];
          2'd1: Result = shifted_op1[WIDTH-1:0];
          2'd2: Result = fl_out_add;
          2'd3: Result = fl_out_mul;
        endcase
    end

    // always @(posedge CLK or negedge RESET)  begin
    //     if(RESET) begin
    //         Result_reg <= 32'd0; 
    //     end
    //     else if(done) begin
    //         Result_reg <= Result_temp;
    //     end
    // end

    // always @(posedge CLK or negedge RESET)  begin
    //     if(RESET) begin
    //         Busy_reg <= 1'd0; 
    //     end
    //     else if(done) begin
    //         Busy_reg <= Busy;
    //     end
    // end

    // assign Result = (Stall) ?  Result_reg : Result_temp;
    // assign Busy = (Stall) ?  Busy_reg :  Busy;
endmodule

