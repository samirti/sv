module sv_function;
  int x;
  //function to add two integer numbers.
  function int sum(input int a,b);
    sum = a+b;   
  endfunction

  initial begin
    x=sum(10,5);
    $display("Value of x = %d",x);
  end
endmodule

// Output: Value of x=15



// function arguments in declarations and mentioning directions
module sv_function;
  int x;
  //function to add two integer numbers.
  function int sum;
    input int a,b;
    sum = a+b;   
  endfunction
  initial begin
    x=sum(10,5);
    $display("Value of x = %d",x);
  end
endmodule

// Output: Value of x = 15



// function with return value with the return keyword
module sv_function;
  int x;
  //function to add two integer numbers.
  function int sum;
    input int a,b;
    return a+b;   
  endfunction

  initial begin
    x=sum(10,5);
    $display("Value of x = %d",x);
  end
endmodule

// Output: Value of x = 15



// Void function
module sv_function;
    int x;
    //void function to display current simulation time 
    function void current_time;
        $display("Current simulation time is %d",$time);    
    endfunction

    initial begin
        #10;
        current_time();
        #20;
        current_time();
    end
endmodule

// Current simulation time is 10
// Current simulation time is 30



// an argument with default value example
module argument_passing;
  int q;
  // function to add three integer numbers.
  function int sum(int x=5, y=10, z=20);
    return x+y+z;   
  endfunction

  initial begin
    q = sum( , ,10);
    $display("Value of z = %d",q);
  end
endmodule

// Value of z = 25




// argument pass by name example
module argument_passing;
  int x,y,z;

  function void display(int x,string y);
    $display("Value of x = %0d, y = %s",x,y);   
  endfunction

  initial begin
    display(.y("Hello World"),.x(2016));
  end
endmodule

// Value of x = 2016, y = Hello World
