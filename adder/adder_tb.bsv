import adder :: *;
import LFSR :: *;

(* synthesize *)
module adder_tb();
    Adder_ifc a1 <- mkAdder();
    LFSR#(Bit#(8)) lfsr1 <- mkLFSR_8;
    LFSR#(Bit#(8)) lfsr2 <- mkFeedLFSR(8'b10011110);
    Reg#(Bit#(4)) count <- mkReg(0);

    rule init(count==0);
        $dumpfile("dump.vcd");
        $dumpvars();
    endrule

    rule counting;
        count<=count+1;
        lfsr1.next;
        lfsr2.next;
    endrule

    rule testadd(count<5);
        $display("%t %8b %8b %8b", $time, lfsr1.value(), lfsr2.value(), a1.add(0, lfsr1.value(), lfsr2.value()));
    endrule

		rule testsub(count>=5 && count<10);
        $display("%t %8b %8b %8b", $time, lfsr1.value(), lfsr2.value(), a1.add(1, lfsr1.value(), lfsr2.value()));
    endrule

    rule done(count==10);
        $finish(0);
    endrule
endmodule
