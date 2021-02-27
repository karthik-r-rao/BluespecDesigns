import StmtFSM::*;
import counter::*;

(* synthesize *)
module counter_tb();
    Ifc_counter count <- counter();
    Reg#(Bit#(8)) state <- mkReg(69);

    Stmt test_seq = seq 
        action count.load(254); $display($time, "\tCurrent value of counter:%d", count.read()); endaction //clk0
        count.increment(); //clk1
        action $display($time, "\tCurrent value of counter:%d", count.read()); count.increment(); endaction  //clk2
        action $display($time, "\tCurrent value of counter:%d", count.read()); count.increment(); endaction  //clk3 and so on
        action $display($time, "\tCurrent value of counter:%d", count.read()); count.increment(); endaction
        action $display($time, "\tCurrent value of counter:%d", count.read()); count.decrement(); endaction
        action $display($time, "\tCurrent value of counter:%d", count.read()); count.decrement(); endaction
        $display($time, "\tCurrent value of counter:%d", count.read());
        action $display("TESTS DONE."); $finish(0); endaction
    endseq;

    mkAutoFSM(test_seq);
endmodule