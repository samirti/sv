// Class declaration example
class sv_class;
  // class properties
  int x;
  // setter getter example below for encapsulated classes
  // method-1
  task set(int i);
    x = i;
  endtask
  // method-2
  function int get();
    return x;
  endfunction
endclass

// Creating Object accessing Class methods
module sv_class_object;
  sv_class object_1; // Creating Handle 

  initial begin
    sv_class object_2 = new();
    object_1 = new();
    object_1.set(10);
    object_2.set(20);
    $display("object_1 :: Value of x = %d",object_1.get());
    $display("object_2 :: Value of x = %d",object_2.get());
  end
endmodule

// object_1 :: Value of x = 10
// object_2 :: Value of x = 20




// Class Assignment
class packet;
  // class properties
  bit [31:0] addr;
  bit [31:0] data;
  bit write;
  string pkt_type;
  // constructor
  function new();
    addr  = 32'h10;
    data  = 32'hFF;
    write = 1;
    pkt_type = "GOOD_PKT";
  endfunction

  // method to display class properties
  function void display();
    $display("addr  = %d",addr);
    $display("data  = %h",data);
    $display("write = %d",write);
    $display("pkt_type  = %s",pkt_type);
  endfunction
endclass

module class_assignment;
  packet pkt_1;
  packet pkt_2;

  initial begin
    pkt_1 = new();
    $display("****  calling pkt_1 display  ****");
    pkt_1.display();

    // assigning pkt_1 to pkt_2
    pkt_2 = pkt_1;
    $display("****  calling pkt_2 display  ****");
    pkt_2.display();

    // changing values with pkt_2 handle
    pkt_2.addr = 32'hAB;
    pkt_2.pkt_type = "BAD_PKT";

    // changes made with pkt_2 handle will reflect on pkt_1
    $display("****  calling pkt_1 display  ****");
    pkt_1.display();
  end
endmodule


//  ****calling pkt_1 display****
// addr = 16
// data = ff
// write = 1
// pkt_type = GOOD_PKT

// ****calling pkt_2 display****
// addr = 16
// data = ff
// write = 1
// pkt_type = GOOD_PKT

// ****calling pkt_1 display****
// addr = 171
// data = ff
// write = 1
// pkt_type = BAD_PKT




// Class Inheritance
class parent_class;
  bit [31:0] addr;
endclass

class child_class extends parent_class;
  bit [31:0] data;
endclass

module inheritence;
  initial begin
    child_class c = new();
    c.addr = 10;
    c.data = 20;
    $display("Value of addr = %d data = %d",c.addr,c.data);
  end
endmodule



// Polymorphism

// base class 
class base_class;
  virtual function void display();
    $display("Inside base class");
  endfunction
endclass

// extended class 1
class ext_class_1 extends base_class;
  function void display();
    $display("Inside extended class 1");  // form 1
  endfunction
endclass

// extended class 2
class ext_class_2 extends base_class;
  function void display();
    $display("Inside extended class 2"); // form 2
  endfunction
endclass

// module
module class_polymorphism;

  initial begin 
    //declare and create extended class
    ext_class_1 ec_1 = new();
    ext_class_2 ec_2 = new();
    //base class handle
    base_class bc[3];
    
    //assigning extended class to base class
    bc[0] = ec_1;
    bc[1] = ec_2;
    
    //accessing extended class methods using base class handle
    bc[0].display();
    bc[1].display();
  end
endmodule

// Inside extended class 1
// Inside extended class 2




// Overriding class members
class parent_class;
  bit [31:0] addr;
  function display();
    $display("Addr = %d",addr);
  endfunction
endclass

class child_class extends parent_class;
  bit [31:0] data;
  // modifying the display function with data
  function display();
    $display("Data = %d",data);  
  endfunction
endclass

module inheritence;
  initial begin
    child_class c = new();
    c.addr = 10;
    c.data = 20;
    c.display();
  end
endmodule

// Data = 20



// Super keyword example

class parent_class;
  bit [31:0] addr;
  function display();
    $display("Addr = %d", addr);
  endfunction
endclass

class child_class extends parent_class;
  bit [31:0] data;
  function display();
    super.display();
    $display("Data = %d",data);
  endfunction
endclass

module inheritence;
  initial begin
    child_class c = new();
    c.addr = 10;
    c.data = 20;
    c.display();
  end
endmodule



// Data hiding and Encapsulation

// Local Class members examples
class parent_class;
  local bit [31:0] tmp_addr;

  function new(bit [31:0] r_addr);
    tmp_addr = r_addr + 10;
  endfunction

  function display();
    $display("tmp_addr = %0d",tmp_addr);
  endfunction
endclass

//   module
module encapsulation;
  initial begin
    parent_class p_c = new(5);
    p_c.tmp_addr = 20;  //Accessing local variable outside the class => Error
    p_c.display();
  end
endmodule

   




// Protected class member
class parent_class;
  protected bit [31:0] tmp_addr;
  
  function new(bit [31:0] r_addr);
    tmp_addr = r_addr + 10;
  endfunction
  function display();
    $display("tmp_addr = %d", tmp_addr);
  endfunction
endclass

class child_class extends parent_class;
  function new(bit [31:0] r_addr);
    super.new(r_addr);
  endfunction
  function void incr_addr();
    tmp_addr++;
  endfunction  
endclass

// module
module encapsulation;
  initial begin
    child_class  c_c = new(10);
    c_c.incr_addr();  //Accessing protected variable in extended class
    c_c.display();
  end
endmodule

// Output: tmp_addr = 21




// abstract class

virtual class packet;
  bit [31:0] addr;
endclass
 
class extended_packet extends packet;
  function void display;
    $display("Value of addr is %d", addr);
  endfunction
endclass
 
module virtual_class;
  initial begin
    extended_packet p;
    p = new();
    p.addr = 10;
    p.display();
  end
endmodule


// Value of addr is 10
