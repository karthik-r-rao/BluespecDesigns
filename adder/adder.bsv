// 8 bit adder subtractor

function Bit#(8) fn_adder(Bit#(1) fn, Bit#(8) op1, Bit#(8) op2);
    Bit#(9) inv = signExtend(fn);
    let inv_op2 = {op2,1'b0}^inv;
    Bit#(8) sum = truncateLSB({op1,1'b1} + inv_op2);
    return sum;
endfunction

interface Adder_ifc;
    method Bit#(8) add(Bit#(1) fn, Bit#(8) op1, Bit#(8) op2);
endinterface

(* synthesize *)
(* always_ready *)
module mkAdder(Adder_ifc);
    method Bit#(8) add(Bit#(1) fn, Bit#(8) op1, Bit#(8) op2);
        return fn_adder(fn, op1, op2);
    endmethod
endmodule