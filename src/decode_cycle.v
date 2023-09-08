module   decode_cycle(clk,rst,instrd,pcd,pcplus4d,
regwritew,rdw,resultw,regwritee,alusrce,memwritee,resultsrce,branche,
alucontrole,rd1_e, rd2_e, imm_ext_e,rs1_e, rs2_e, rd_e,pce, pcplus4e);

input clk,rst,regwritew;
input [31:0] instrd,pcd,pcplus4d,resultw;
input [4:0] rdw;

output regwritee,alusrce,memwritee,resultsrce,branche;
output [2:0] alucontrole;
output [31:0] rd1_e, rd2_e, imm_ext_e;
output [4:0] rs1_e, rs2_e, rd_e;
output [31:0] pce, pcplus4e;


wire regwrited,alusrcd,memwrited,resultsrcd,branchd;
wire [1:0] immsrcd;
wire [2:0] alucontrold;
wire [31:0] rd1_d,rd2_d,immext_d;

reg regwrited_r,alusrcd_r,memwrited_r,resultsrcd_r,branchd_r;
reg [2:0] alucontrold_r;
reg [31:0] rd1_d_r, rd2_d_r, imm_ext_d_r;
reg [4:0] rd_d_r, rs1_d_r, rs2_d_r;
reg [31:0] pcd_r, pcplus4d_r;


control_unit_top c1(.op(instrd[6:0]),.regwrite(regwrited),
.immsrc(immsrcd),.alusrc(alusrcd),.memwrite(memwrited),
.resultsrc(resultsrcd),.branch(branchd),.funct3(instrd[14:12]),.funct7(instrd[31:25]),.alucontrol(alucontrold));

reg_file r1(.a1(instrd[19:15]),.a2(instrd[24:20]),
.a3(rdw),.wd3(resultw),.we3(regwritew),.clk(clk),.rst(rst),.rd1(rd1_d),.rd2(rd2_d));

sign_extend s1(.in(instrd[31:0]),
.imm_ext(immext_d),.immsrc(imsrcd));

always @(posedge clk or posedge rst) 
begin
        if(rst == 1'b1) 
        begin
            regwrited_r <= 1'b0;
            alusrcd_r <= 1'b0;
            memwrited_r <= 1'b0;
            resultsrcd_r <= 1'b0;
            branchd_r <= 1'b0;
            alucontrold_r <= 3'b000;
            rd1_d_r <= 32'h00000000; 
            rd2_d_r <= 32'h00000000; 
            imm_ext_d_r <= 32'h00000000;
            rd_d_r <= 5'h00;
            pcd_r <= 32'h00000000; 
            pcplus4d_r <= 32'h00000000;
            rs1_d_r <= 5'h00;
            rs2_d_r <= 5'h00;
        end
        else 
        begin
            regwrited_r <= regwrited;
            alusrcd_r <= alusrcd;
            memwrited_r <= memwrited;
            resultsrcd_r <= resultsrcd;
            branchd_r <= branchd;
            alucontrold_r <= alucontrold;
            rd1_d_r <= rd1_d; 
            rd2_d_r <= rd2_d; 
            imm_ext_d_r <= immext_d;
            rd_d_r <= instrd[11:7];
            pcd_r <= pcd; 
            pcplus4d_r <= pcplus4d;
            rs1_d_r <= instrd[19:15];
            rs2_d_r <= instrd[24:20];
        end
end

    // Output asssign statements
    assign regwritee = regwrited_r;
    assign alusrce = alusrcd_r;
    assign memwritee = memwrited_r;
    assign resultsrce = resultsrcd_r;
    assign branche = branchd_r;
    assign alucontrole = alucontrold_r;
    assign rd1_e = rd1_d_r;
    assign rd2_e = rd2_d_r;
    assign imm_ext_e = imm_ext_d_r;
    assign rd_e = rd_d_r;
    assign pce = pcd_r;
    assign pcplus4e = pcplus4d_r;
    assign rs1_e = rs1_d_r;
    assign rs2_e = rs2_d_r;
  
endmodule





