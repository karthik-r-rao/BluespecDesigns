// Module for an 8 bit up/down counter

interface Ifc_counter;
    method Bit#(8) read();                  // read current count
    method Action load(Bit#(8) newval);     // load counter with newval
    method Action increment();              // increment counter
    method Action decrement();              // decrement counter
endinterface

(* synthesize *)
(* always_ready *)
module counter(Ifc_counter);
    Reg#(Bit#(8)) value <- mkReg(0);        // synchronous reset

    method Bit#(8) read();
        return value;
    endmethod

    method Action load(Bit#(8) newval);
        value<=newval;
    endmethod

    method Action increment();
        value<=value+1;
    endmethod

    method Action decrement();
        value<=value-1;
    endmethod
endmodule
