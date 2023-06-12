// Semaphore access with 2 keys

module semaphore_ex;
  semaphore sema; //declaring semaphore sema

  initial begin
    sema=new(4); //creating sema with '4' keys
    fork
      display(); //process-1
      display(); //process-2
      display(); //process-3
    join
  end

  //display method
  task automatic display();
    sema.get(2); //getting '2' keys from sema
    $display($time,"Current Simulation Time");
    #30;
    sema.put(2); //putting '2' keys to sema
  endtask
endmodule

// 0 Current Simulation Time
// 0 Current Simulation Time
// 30 Current Simulation Time


//---------------------------------------------------------------------------------------

// Putting back more keys

module semaphore_ex;
  semaphore sema; //declaring semaphore sema

  initial begin
    sema=new(1); //creating sema with '1' keys
    fork
      display(1); //process-1
      display(2); //process-2
      display(3); //process-3
    join
  end

  //display method
  task automatic display(int key);
    sema.get(key); //getting 'key' number of keys from sema
    $display($time,"Current Simulation Time, Got %d keys",key);
    #30;
    sema.put(key+1); //putting 'key' number of keys to sema
  endtask
endmodule


//---------------------------------------------------------------------------------------


// Mailbox example

// Packet 
class packet;
  rand bit [7:0] addr;
  rand bit [7:0] data;

  //Displaying randomized values
  function void post_randomize();
    $display("Packet::Packet Generated");
    $display("Packet::Addr=%0d,Data=%0d",addr,data);
  endfunction
endclass

//Generator - Generates the transaction packet and send to driver
class generator;
  packet pkt;
  mailbox m_box;
  //constructor, getting mailbox handle
  function new(mailbox m_box);
    this.m_box = m_box;
  endfunction
  task run;
    repeat(2) begin
      pkt = new();
      pkt.randomize(); //generating packet
      m_box.put(pkt);  //putting packet into mailbox
      $display("Generator::Packet Put into Mailbox");
      #5;
    end
  endtask
endclass

// Driver - Gets the packet from generator and display's the packet items
class driver;
  packet pkt;
  mailbox m_box;

  //constructor, getting mailbox handle
  function new(mailbox m_box);
    this.m_box = m_box;
  endfunction

  task run;
    repeat(2) begin
      m_box.get(pkt); //getting packet from mailbox
      $display("Driver::Packet Recived");
      $display("Driver::Addr=%0d,Data=%0d\n",pkt.addr,pkt.data);
    end
  endtask
endclass

// tbench_top  
module mailbox_ex;
  generator gen;
  driver    dri;
  mailbox m_box; //declaring mailbox m_box

  initial begin
    //Creating the mailbox, Passing the same handle to generator and driver, 
    //because same mailbox should be shared in-order to communicate.
    m_box = new(); //creating mailbox

    gen = new(m_box); //creating generator and passing mailbox handle
    dri = new(m_box); //creating driver and passing mailbox handle
    fork
      gen.run(); //Process-1
      dri.run(); //Process-2
    join
  end
endmodule

// Packet::Packet Generated
// Packet::Addr=3,Data=38
// Generator::Packet Put into Mailbox
// Driver::Packet Recived
// Driver::Addr=3,Data=38

// Packet::Packet Generated
// Packet::Addr=118,Data=92
// Generator::Packet Put into Mailbox
// Driver::Packet Recived
// Driver::Addr=118,Data=92


//---------------------------------------------------------------------------------------

// Event waiting with @ operator
module events_ex;
  event ev_1; //declaring event ev_1

  initial begin
    fork
      //process-1, triggers the event
      begin
        #40;
        $display($time,"\tTriggering The Event");
        ->ev_1;
      end
    
      //process-2, wait for the event to trigger
      begin
        $display($time,"\tWaiting for the Event to trigger");
        @(ev_1.triggered);
        $display($time,"\tEvent triggered");
      end
    join
  end
endmodule

// 0 Waiting for the Event to trigger
// 40 Triggering The Event
// 40 Event triggered




module main;
event e;
initial
repeat(4)
begin
#20;
->e ;
$display(" e is triggered at %t ",$time);
end

initial
#100 $finish;
always
begin
#10;
if(e.triggered)
$display(" e is TRUE at %t",$time);
else
$display(" e is FALSE at %t",$time);
end
endmodule




module main;
event e1,e2;

initial
repeat(4)
begin
#20;
->e1 ;
@(e1)
$display(" e1 is triggered at %t ",$time);
end

initial
repeat(4)
begin
#20;
->e2 ;
wait(e2.triggered);
$display(" e2 is triggered at %t ",$time);
end

endmodule

// e2 is triggered at 20
// e2 is triggered at 40
// e2 is triggered at 60
// e2 is triggered at 80





module main;
event e1,e2,e3;
initial begin
#10;
-> e1;
-> e2;
-> e3;
#10;
-> e3;
-> e1;
-> e2;
end
always  begin
if (wait_order(e1,e2,e3)) $display("Events are in order");
else $display("Events are out of order");
end
endmodule

// Events are in order
// Events are out of order




// trigger and wait for an event at the same time

module events_ex;
  event ev_1; //declaring event ev_1

  initial begin
    fork
      //process-1, triggers the event
      begin
         $display($time,"Triggering The Event");
        ->ev_1;
      end
   
      //process-2, wait for the event to trigger
      begin
        $display($time,"Waiting for the Event to trigger");
        wait(ev_1.triggered);
        $display($time,"Event triggered");
      end
    join
  end
endmodule

// 0 Triggering The Event
// 0 Waiting for the Event to trigger
// 0 Event triggered



//---------------------------------------------------------------------------------------

// Interface example
// Writing interface
interface intf;
  //declaring the signals
  logic [3:0] a;
  logic [3:0] b;
  logic [6:0] c;
endinterface

// Interface declaration. creatinng instance of interface
intf i_intf();

// Connecting interface with design. DUT instance
adder DUT (
  .a(i_intf.a),
  .b(i_intf.b),
  .c(i_intf.c)
);

// Accessing interface signal
module interface_signal;
  i_intf.a = 6;
  i_intf.b = 4;
    
  $display("Value of a = %0d, b = %0d",i_intf.a,i_intf.b);
  #5;
  $display("Sum of a and b, c = %0d",i_intf.c);
endmodule


// Value of a = 6, b = 4
// Sum of a and b, c = 10





//---------------------------------------------------------------------------------------

