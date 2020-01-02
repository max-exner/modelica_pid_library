package SimpleElectric
  extends Modelica.Icons.Package;
  import SI = Modelica.SIunits;

  package BasisElements
    extends Modelica.Icons.BasesPackage;
    model Resistance
      SI.Voltage u;
      extends Interface.TwoPin;
      parameter Modelica.SIunits.Resistance R;
    equation
      u = R * p.i;
      annotation(
        Icon(graphics = {Rectangle(extent = {{-20, 10}, {20, -10}}), Line(origin = {19.6235, -0.0367685}, points = {{0, 0}, {18, 0}}), Line(origin = {-30.3809, -0.0679384}, points = {{-10, 0}, {10, 0}, {10, 0}, {10, 0}}), Text(origin = {2, 15}, extent = {{-8, 5}, {8, -5}}, textString = "%name"), Text(origin = {2, -17}, extent = {{-8, 3}, {8, -3}}, textString = "R=%R")}, coordinateSystem(initialScale = 0.1)));
    end Resistance;

    model Capacity
      //Modelica.SIunits.Voltage u;
      extends Interface.TwoPin;
      parameter Modelica.SIunits.Capacitance C;
    equation
      C * der(u) = p.i;
      annotation(
        Icon(graphics = {Line(origin = {-7.31485, 0.00481869}, points = {{0, 8}, {0, -8}}), Line(origin = {6.68515, 0.00481869}, points = {{0, 8}, {0, -8}}), Line(origin = {-23.6685, -0.373251}, points = {{-16, 0}, {16, 0}}), Line(origin = {22.3315, -0.373251}, points = {{16, 0}, {-16, 0}}), Text(origin = {0, 22}, extent = {{-22, 8}, {22, -8}}, textString = "%name"), Text(origin = {0, -16}, extent = {{-16, 6}, {16, -6}}, textString = "C=%C")}, coordinateSystem(initialScale = 0.1)));
    end Capacity;

    model GND
      Interface.Pin PinP annotation(
        Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      PinP.u = 0;
      annotation(
        Icon(graphics = {Line(origin = {0, -9}, points = {{0, 5}, {0, -5}}), Line(origin = {0, -14}, points = {{-14, 0}, {14, 0}, {14, 0}, {14, 0}}), Line(origin = {0, -20}, points = {{-10, 0}, {10, 0}, {10, 0}}), Line(origin = {-0.164633, -24.9878}, points = {{-5.83537, 0}, {6.16463, 0}, {6.16463, 0}, {6.16463, 0}, {6.16463, 0}})}));
    end GND;

    model Inductance
      extends Interface.TwoPin;
      SI.Voltage u "Voltage";
      parameter Modelica.SIunits.Inductance L "Inductance";
      SI.Current i (start=0) "Current";
    equation
      i = p.i;
      u = L * der(i);
      annotation(
        Diagram,
        Icon(graphics = {Ellipse(origin = {-19, -1}, extent = {{-5, -5}, {7, 7}}, endAngle = 180), Ellipse(origin = {-7, -1}, extent = {{-5, -5}, {7, 7}}, endAngle = 180), Ellipse(origin = {5, -1}, extent = {{-5, -5}, {7, 7}}, endAngle = 180), Ellipse(origin = {17, -1}, extent = {{-5, -5}, {7, 7}}, endAngle = 180), Line(origin = {26.7073, -8.62256e-07}, points = {{-2, 0}, {6, 0}, {12, 0}}), Line(origin = {-24.7318, 0.164629}, points = {{-16, 0}, {2, 0}}), Polygon(origin = {2, 4}, points = {{-24, 0}, {-24, 0}, {-24, 0}, {-24, 0}, {-24, 0}}), Text(origin = {-1, 22}, extent = {{-21, 6}, {21, -6}}, textString = "%name"), Text(origin = {2, -12}, extent = {{-12, 6}, {12, -6}}, textString = "L=%L")}, coordinateSystem(initialScale = 0.1)));
    end Inductance;

    model Voltage_Source
      extends Interface.TwoPin;
      Modelica.SIunits.Voltage u;
      parameter Modelica.SIunits.Voltage A;
      parameter Modelica.SIunits.Frequency f;
      import pi = Modelica.Constants.pi;
    equation
      u = A * Modelica.Math.sin(2 * pi * f * time);
      annotation(
        Diagram(graphics = {Polygon(points = {{-20, 0}, {-20, 0}, {-20, 0}})}),
        Icon(graphics = {Ellipse(extent = {{-10, -10}, {10, 10}}, endAngle = 360), Line(points = {{-36, 0}, {36, 0}, {36, 0}}), Line(origin = {0.02, 0}, points = {{-20.0241, 0}, {-16.0241, -12}, {-10.0241, -20}, {-6.02408, -14}, {-0.0240766, 0}, {3.97592, 12}, {9.97592, 20}, {13.9759, 14}, {19.9759, 0}, {19.9759, 0}}, color = {173, 173, 173}), Text(origin = {-1, 35}, extent = {{17, -9}, {-17, 9}}, textString = "%name"), Text(origin = {-27, -27}, extent = {{-11, 5}, {11, -5}}, textString = "A=%A"), Text(origin = {31, -28}, extent = {{-11, 6}, {9, -2}}, textString = "f=%f")}, coordinateSystem(initialScale = 0.1)));
    end Voltage_Source;

    model Voltage_Source_real_input 
      extends Interface.TwoPin;  
      Modelica.Blocks.Interfaces.RealInput u_soll annotation(
        Placement(visible = true, transformation(origin = {0, -62}, extent = {{20, -20}, {-20, 20}}, rotation = -90), iconTransformation(origin = {0, -30}, extent = {{20, -20}, {-20, 20}}, rotation = -90)));
    equation
      u = u_soll;
      annotation(
        Diagram(graphics = {Polygon(points = {{-20, 0}, {-20, 0}, {-20, 0}})}),
        Icon(graphics = {Ellipse(extent = {{-10, -10}, {10, 10}}, endAngle = 360), Line(points = {{-36, 0}, {36, 0}, {36, 0}}), Text(origin = {-1, 35}, extent = {{17, -9}, {-17, 9}}, textString = "%name")}, coordinateSystem(initialScale = 0.1)));
    end Voltage_Source_real_input;

    model switch
    extends Interface.TwoPin;
    SI.Voltage u;
    //Real t0;
    Real sign_i;
    Boolean off;
      Modelica.Blocks.Interfaces.BooleanInput b annotation(
        Placement(visible = true, transformation(origin = {-4, 0}, extent = {{-12, -12}, {12, 12}}, rotation = 0), iconTransformation(origin = {1.11022e-16, 12}, extent = {{-8, -8}, {8, 8}}, rotation = -90)));
    equation
    
    when (edge(b)) then
      sign_i = if p.i>0 then 1 else -1;
    end when;
    
    off = if (sign_i*p.i<0 and b) then true else false;
    
    0 = if off then p.i else u; 
    annotation(
        Icon(graphics = {Line(origin = {-13.84, 4.01259}, points = {{-22.16, -4.15998}, {3.84002, -4.15998}, {21.84, 3.84002}, {21.84, 3.84002}}, color = {0, 0, 127}), Line(origin = {22, 0}, points = {{-14, 0}, {14, 0}, {14, 0}}, color = {0, 0, 127}), Ellipse(origin = {-11, 1}, lineColor = {0, 0, 127}, extent = {{-1, 1}, {3, -3}}, endAngle = 360), Ellipse(origin = {7, 1}, lineColor = {0, 0, 127}, extent = {{-1, 1}, {3, -3}}, endAngle = 360)}));end switch;
  end BasisElements;

  package Interface
    extends Modelica.Icons.InterfacesPackage;
    connector Pin
      Modelica.SIunits.Voltage u;
      flow Modelica.SIunits.Current i;
      annotation(
        Diagram,
        Icon(graphics = {Rectangle(fillColor = {0, 0, 127}, fillPattern = FillPattern.Solid, extent = {{-40, 40}, {40, -40}})}));
    end Pin;

    connector NPin
      Modelica.SIunits.Voltage u;
      flow Modelica.SIunits.Current i;
      annotation(
        Diagram,
        Icon(graphics = {Rectangle(fillColor = {0, 0, 127}, extent = {{-40, 40}, {40, -40}})}, coordinateSystem(initialScale = 0.1)));
    end NPin;

    partial model TwoPin
      Modelica.SIunits.Voltage u;
      SimpleElectric.Interface.Pin p annotation(
        Placement(visible = true, transformation(origin = {-40, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-40, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      SimpleElectric.Interface.NPin n annotation(
        Placement(visible = true, transformation(origin = {40, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {40, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      0 = p.i + n.i;
      u = p.u - n.u;
    end TwoPin;
  end Interface;

  package Komponents
    extends Modelica.Icons.UtilitiesPackage;
    model LowPass
      parameter SI.Resistance R;
      parameter SI.Capacitance C;
      Interface.Pin p0 annotation(
        Placement(visible = true, transformation(origin = {-60, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-60, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      SimpleElectric.Interface.Pin p1 annotation(
        Placement(visible = true, transformation(origin = {60, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {60, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Interface.NPin n0 annotation(
        Placement(visible = true, transformation(origin = {-60, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-60, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Interface.NPin n1 annotation(
        Placement(visible = true, transformation(origin = {60, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {60, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    protected
      SimpleElectric.BasisElements.Capacity capacity(C = C) annotation(
        Placement(visible = true, transformation(origin = {0, -2}, extent = {{-28, -28}, {28, 28}}, rotation = -90)));
      SimpleElectric.BasisElements.Resistance resistance(R = R) annotation(
        Placement(visible = true, transformation(origin = {-20, 40}, extent = {{-28, -28}, {28, 28}}, rotation = 0)));
    equation
      connect(resistance.n, capacity.p) annotation(
        Line(points = {{-9, 40}, {0, 40}, {0, 9}}));
      connect(p0, resistance.p) annotation(
        Line(points = {{-60, 40}, {-31, 40}}));
      connect(n0, capacity.n) annotation(
        Line(points = {{-60, -40}, {0, -40}, {0, -13}}));
      connect(capacity.n, n1) annotation(
        Line(points = {{0, -13}, {0, -40}, {60, -40}}));
      connect(p1, capacity.p) annotation(
        Line(points = {{60, 40}, {0, 40}, {0, 9}}));
      annotation(
        Icon(graphics = {Rectangle(origin = {1, -1}, fillColor = {0, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-41, 53}, {39, -51}}), Text(origin = {-3, 63}, extent = {{-13, 7}, {13, -7}}, textString = "%name"), Text(origin = {-1, 23}, extent = {{-27, 7}, {27, -7}}, textString = "Low-Pass"), Line(origin = {-48, 40}, points = {{-8, 0}, {8, 0}, {8, 0}}), Line(origin = {48, 40}, points = {{8, 0}, {-8, 0}, {-8, 0}}), Line(origin = {-48, -40}, points = {{-8, 0}, {8, 0}, {8, 0}}), Line(origin = {48, -40}, points = {{-8, 0}, {8, 0}})}));
    end LowPass;

    model HighPass
      parameter SI.Resistance R;
      parameter SI.Capacitance C;
      Interface.Pin p0 annotation(
        Placement(visible = true, transformation(origin = {-60, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-60, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      SimpleElectric.Interface.Pin p1 annotation(
        Placement(visible = true, transformation(origin = {60, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {60, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Interface.NPin n0 annotation(
        Placement(visible = true, transformation(origin = {-60, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-60, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Interface.NPin n1 annotation(
        Placement(visible = true, transformation(origin = {60, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {60, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      SimpleElectric.BasisElements.Resistance resistance(R = R) annotation(
        Placement(visible = true, transformation(origin = {14, 10}, extent = {{-28, -28}, {28, 28}}, rotation = -90)));
      SimpleElectric.BasisElements.Capacity capacity(C = C) annotation(
        Placement(visible = true, transformation(origin = {-20, 40}, extent = {{-28, -28}, {28, 28}}, rotation = 180)));
    equation
      connect(n0, resistance.n) annotation(
        Line(points = {{-60, -40}, {14, -40}, {14, -2}, {14, -2}}));
      connect(resistance.n, n1) annotation(
        Line(points = {{14, -2}, {14, -2}, {14, -40}, {60, -40}, {60, -40}}));
      connect(resistance.p, capacity.p) annotation(
        Line(points = {{14, 22}, {14, 22}, {14, 40}, {-8, 40}, {-8, 40}}));
      connect(capacity.p, p1) annotation(
        Line(points = {{-8, 40}, {60, 40}, {60, 40}, {60, 40}}));
      connect(p0, capacity.n) annotation(
        Line(points = {{-60, 40}, {-32, 40}, {-32, 40}, {-32, 40}}));
      annotation(
        Icon(graphics = {Rectangle(origin = {1, -1}, fillColor = {255, 170, 0}, fillPattern = FillPattern.Solid, extent = {{-41, 53}, {39, -51}}), Text(origin = {-3, 63}, extent = {{-13, 7}, {13, -7}}, textString = "%name"), Text(origin = {-1, 23}, extent = {{-27, 7}, {27, -7}}, textString = "High-Pass"), Line(origin = {-48, 40}, points = {{-8, 0}, {8, 0}, {8, 0}}), Line(origin = {48, 40}, points = {{8, 0}, {-8, 0}, {-8, 0}}), Line(origin = {-48, -40}, points = {{-8, 0}, {8, 0}, {8, 0}}), Line(origin = {48, -40}, points = {{-8, 0}, {8, 0}})}, coordinateSystem(initialScale = 0.1)));
    end HighPass;
  end Komponents;

  package Examples
    extends Modelica.Icons.ExamplesPackage;
    model TestModel
      extends Modelica.Icons.Example;
      SimpleElectric.Komponents.LowPass lowPass1(C = 0.001, R = 100) annotation(
        Placement(visible = true, transformation(origin = {1, 73}, extent = {{-39, -39}, {39, 39}}, rotation = 0)));
      SimpleElectric.BasisElements.Voltage_Source voltage_Source1(A = 5, f = 5) annotation(
        Placement(visible = true, transformation(origin = {-72, 56}, extent = {{-26, -26}, {26, 26}}, rotation = -90)));
      SimpleElectric.BasisElements.Voltage_Source voltage_Source2(A = 1, f = 100) annotation(
        Placement(visible = true, transformation(origin = {-72, 8}, extent = {{-26, -26}, {26, 26}}, rotation = -90)));
      SimpleElectric.BasisElements.Resistance resistance1(R = 100) annotation(
        Placement(visible = true, transformation(origin = {73, 47}, extent = {{-23, -23}, {23, 23}}, rotation = -90)));
      SimpleElectric.BasisElements.GND gnd1 annotation(
        Placement(visible = true, transformation(origin = {-71, -37}, extent = {{-21, -21}, {21, 21}}, rotation = 0)));
    equation
      connect(gnd1.PinP, voltage_Source2.n) annotation(
        Line(points = {{-70, -36}, {-72, -36}, {-72, -2}, {-72, -2}}));
      connect(lowPass1.n1, resistance1.n) annotation(
        Line(points = {{24, 58}, {46, 58}, {46, 38}, {74, 38}, {74, 38}}));
      connect(lowPass1.p1, resistance1.p) annotation(
        Line(points = {{24, 88}, {74, 88}, {74, 56}, {74, 56}}));
      connect(voltage_Source2.n, lowPass1.n0) annotation(
        Line(points = {{-72, -2}, {-72, -2}, {-72, -20}, {-40, -20}, {-40, 58}, {-22, 58}, {-22, 58}, {-22, 58}, {-22, 58}}));
      connect(voltage_Source1.n, voltage_Source2.p) annotation(
        Line(points = {{-72, 46}, {-72, 46}, {-72, 18}, {-72, 18}}));
      connect(lowPass1.p0, voltage_Source1.p) annotation(
        Line(points = {{-22, 88}, {-72, 88}, {-72, 66}, {-72, 66}}));
    end TestModel;

    model TestSwitch
    extends Modelica.Icons.Example;
    SimpleElectric.BasisElements.switch switch1 annotation(
        Placement(visible = true, transformation(origin = {0, 0}, extent = {{-40, -40}, {40, 40}}, rotation = 0)));
  SimpleSignal.Elements.delay delay1(t_delay = 0.6)  annotation(
        Placement(visible = true, transformation(origin = {-30, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant1 annotation(
        Placement(visible = true, transformation(origin = {-78, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  SimpleElectric.BasisElements.Voltage_Source voltage_Source1(A = 12, f = 3)  annotation(
        Placement(visible = true, transformation(origin = {-60, -20}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
  SimpleElectric.BasisElements.GND gnd1 annotation(
        Placement(visible = true, transformation(origin = {-1.77636e-15, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  SimpleElectric.BasisElements.Resistance resistance1(R = 2)  annotation(
        Placement(visible = true, transformation(origin = {60, -20}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
    equation
      connect(booleanConstant1.y, delay1.u) annotation(
        Line(points = {{-67, 50}, {-36, 50}}, color = {255, 0, 255}));
      connect(gnd1.PinP, resistance1.n) annotation(
        Line(points = {{0, -40}, {60, -40}, {60, -28}, {60, -28}, {60, -28}}));
      connect(gnd1.PinP, voltage_Source1.n) annotation(
        Line(points = {{0, -40}, {-60, -40}, {-60, -28}, {-60, -28}, {-60, -28}}));
      connect(switch1.n, resistance1.p) annotation(
        Line(points = {{16, 0}, {60, 0}, {60, -12}, {60, -12}}));
      connect(voltage_Source1.p, switch1.p) annotation(
        Line(points = {{-60, -12}, {-60, -12}, {-60, 0}, {-16, 0}, {-16, 0}}));
      connect(delay1.y, switch1.b) annotation(
        Line(points = {{-24, 50}, {0, 50}, {0, 4}, {0, 4}}, color = {255, 0, 255}));
    end TestSwitch;
  end Examples;
  annotation(
    uses(Modelica(version = "3.2.3")));
end SimpleElectric;
