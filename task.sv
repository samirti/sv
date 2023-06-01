// task arguments in parentheses
module sv_task;
  int x;

  //task to add two integer numbers.
  task sum(input int a,b,output int c);
    c = a+b;   
  endtask

  initial begin
    sum(10,5,x);
    $display("Value of x = %d",x);
  end
endmodule

// Value of x=15




// task arguments in declarations and mentioning directions
module sv_task;
  int x;

  // task to add two integer numbers.
  task sum;
    input int a,b;
    output int c;
    c = a+b;   
  endtask

  initial begin
    sum(10,5,x);
    $display("Value of x = %d",x);
  end
endmodule

// Value of x=15
