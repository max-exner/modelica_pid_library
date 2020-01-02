package Control
  extends Modelica.Icons.Package;

  package Components
    extends Modelica.Icons.BasesPackage;

    block control_deviation
      Modelica.Blocks.Interfaces.RealInput w "Input" annotation(
        Placement(visible = true, transformation(origin = {-60, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-60, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput y "Output" annotation(
        Placement(visible = true, transformation(origin = {0, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 90), iconTransformation(origin = {0, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealOutput e "control_deviation" annotation(
        Placement(visible = true, transformation(origin = {60, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {60, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    equation
  e=w-y;
    annotation(
        Icon(graphics = {Ellipse(lineThickness = 1, extent = {{-40, 40}, {40, -40}}, endAngle = 360), Text(origin = {-23, -1}, extent = {{7, -15}, {-13, 21}}, textString = "+"), Text(origin = {3, -31}, extent = {{7, -15}, {-13, 21}}, textString = "-")}));
        end control_deviation;

    block P
    parameter Real k=1;
  Modelica.Blocks.Interfaces.RealInput u "Input" annotation(
        Placement(visible = true, transformation(origin = {-60, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-80, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y "Output" annotation(
        Placement(visible = true, transformation(origin = {60, 3.55271e-15}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {80, 3.55271e-15}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    equation
y=k*u;
    annotation(
        Icon(graphics = {Line(origin = {-0.22, 0}, points = {{-59.7774, 80}, {-59.7774, -80}, {60.2226, 0}, {-59.7774, 80}, {-59.7774, 80}}, thickness = 1), Text(origin = {6, -74}, extent = {{-26, -10}, {26, 10}}, textString = "k=%k")}));end P;

    block I
    parameter Real K_I_param=1 "Transmission constant";
    parameter Boolean use_trasconst = true "Switch to choose between the parameter";
    parameter Real T_I=1 "Integration time";
    Real K_I;
    Modelica.Blocks.Interfaces.RealInput u "Input" annotation(
        Placement(visible = true, transformation(origin = {-60, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-60, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y "Output" annotation(
        Placement(visible = true, transformation(origin = {60, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {60, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    initial equation
    y=0;
    equation
    K_I = noEvent(if use_trasconst then K_I_param elseif T_I <> 0 then 1/T_I else 0);
der(y)=K_I*u;
    annotation(
        Icon(graphics = {Rectangle(lineThickness = 1, extent = {{-40, 40}, {40, -40}}), Line(origin = {-2, 1}, points = {{-30, 33}, {-30, -33}, {30, -33}, {30, -33}}, thickness = 0.75), Line(origin = {-5, -6}, points = {{-27, -26}, {27, 26}}, thickness = 0.5), Line(origin = {-32, 32.78}, points = {{-2, -2.77639}, {0, 1.22361}, {2, -2.77639}}, thickness = 0.75), Line(origin = {26.9918, -32.0482}, rotation = -90, points = {{-2, -2.77639}, {0, 1.22361}, {2, -2.77639}}, thickness = 0.75), Text(origin = {1, -55}, extent = {{-23, 7}, {23, -7}}, textString = "K_I = %K_I")}, coordinateSystem(initialScale = 0.1)));end I;

    block ADD_3
    Modelica.Blocks.Interfaces.RealInput u1 "Input 1" annotation(
        Placement(visible = true, transformation(origin = {-60, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-80, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u2 "Input 2" annotation(
        Placement(visible = true, transformation(origin = {-60, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-80, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u3 "Input 3" annotation(
        Placement(visible = true, transformation(origin = {-60, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-80, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y "Output" annotation(
        Placement(visible = true, transformation(origin = {52, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {80, 3.55271e-15}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    equation
y= u1 + u2 + u3; 
    annotation(
        Diagram(graphics = {Rectangle(origin = {-54, 42}, extent = {{2, 0}, {-2, 0}})}),
        Icon(graphics = {Rectangle(extent = {{-60, 60}, {60, -60}}), Text(origin = {-48, 47}, extent = {{18, -19}, {-2, 7}}, textString = "+"), Text(origin = {-48, 7}, extent = {{18, -19}, {-2, 7}}, textString = "+"), Text(origin = {-48, -33}, extent = {{18, -19}, {-2, 7}}, textString = "+")}));end ADD_3;

    block D
    parameter Real K = 1 "Transmission constant";
    Modelica.Blocks.Interfaces.RealInput u annotation(
        Placement(visible = true, transformation(origin = {-58, -2}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-60, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y annotation(
        Placement(visible = true, transformation(origin = {64, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {60, 3.55271e-15}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    equation
y=K*der(u);
    annotation(
        Icon(graphics = {Rectangle(lineThickness = 1, extent = {{-40, 40}, {40, -40}}), Line(origin = {0.627148, 0.797251}, points = {{-32, 32}, {-32, -32}, {32, -32}}, thickness = 0.75), Text(origin = {-3, -60}, extent = {{27, -12}, {-27, 12}}, textString = "K_D = %K")}, coordinateSystem(initialScale = 0.1)));end D;

    block PID
    parameter Real K_P = 1 "Transmission constant P";
    parameter Real K_I_param = 0 "Transmission constant I";
    parameter Boolean use_trasconst = true "Enable the use of the Transmission constant for the I control";
    parameter Real T_I_param = 1 "Integration time";
    parameter Real K_D = 0 "Transmission constant D";
    Modelica.Blocks.Interfaces.RealInput u annotation(
        Placement(visible = true, transformation(origin = {-80, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-80, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y annotation(
        Placement(visible = true, transformation(origin = {90, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {80, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Control.Components.ADD_3 add_31 annotation(
        Placement(visible = true, transformation(origin = {52, 3.55271e-15}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Control.Components.P p(k = K_P)  annotation(
        Placement(visible = true, transformation(origin = {-21, 35}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
  Control.Components.I i(K_I_param = K_I_param, use_trasconst = use_trasconst, T_I = T_I_param)  annotation(
        Placement(visible = true, transformation(origin = {-20, -3.55271e-15}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Control.Components.D d(K = K_D)  annotation(
        Placement(visible = true, transformation(origin = {-20, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    equation
      connect(add_31.y, y) annotation(
        Line(points = {{68, 0}, {82, 0}, {82, 0}, {90, 0}}, color = {0, 0, 127}));
      connect(d.y, add_31.u3) annotation(
        Line(points = {{-8, -40}, {14, -40}, {14, -8}, {36, -8}, {36, -8}}, color = {0, 0, 127}));
      connect(i.y, add_31.u2) annotation(
        Line(points = {{-8, 0}, {36, 0}, {36, 0}, {36, 0}}, color = {0, 0, 127}));
      connect(p.y, add_31.u1) annotation(
        Line(points = {{-8, 36}, {22, 36}, {22, 8}, {36, 8}, {36, 8}}, color = {0, 0, 127}));
      connect(d.u, u) annotation(
        Line(points = {{-32, -40}, {-48, -40}, {-48, 0}, {-80, 0}, {-80, 0}}, color = {0, 0, 127}));
      connect(p.u, u) annotation(
        Line(points = {{-34, 36}, {-48, 36}, {-48, 0}, {-80, 0}, {-80, 0}}, color = {0, 0, 127}));
      connect(u, i.u) annotation(
        Line(points = {{-80, 0}, {-34, 0}, {-34, 0}, {-32, 0}}, color = {0, 0, 127}));
    annotation(
        Icon(graphics = {Rectangle(lineThickness = 1, extent = {{-60, 60}, {60, -60}}), Text(origin = {1, 0}, extent = {{17, -16}, {-17, 16}}, textString = "PID"), Text(origin = {-60, -72}, extent = {{14, -6}, {-14, 6}}, textString = "K_P=%K_P"), Text(origin = {-34, -88}, extent = {{14, -6}, {-14, 6}}, textString = "K_I=%K_I_param"), Text(origin = {60, -72}, extent = {{14, -6}, {-14, 6}}, textString = "K_D=%K_D"), Text(origin = {34, -88}, extent = {{14, -6}, {-14, 6}}, textString = "T_I=%T_I_param")}, coordinateSystem(initialScale = 0.1)));end PID;

    block min_max
    parameter Real min=-10 "Minimum Value";
    parameter Real max=10 "Minimum Value";
    Modelica.Blocks.Interfaces.RealInput u annotation(
        Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-80, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y annotation(
        Placement(visible = true, transformation(origin = {100, 3.55271e-15}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {80, 3.55271e-15}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    equation
      y= if u>max then max elseif u<min then min else u;

    annotation(
        Diagram,
        Icon(graphics = {Rectangle(origin = {-1, 1}, lineThickness = 1, extent = {{-59, 59}, {61, -61}}), Line(origin = {0.88, 0.15}, points = {{-50, 50}, {-50, -50}, {50, -50}}, thickness = 0.75), Line(origin = {1, 30.7973}, points = {{-50, 0}, {50, 0}}, color = {170, 0, 0}, thickness = 0.5), Line(origin = {1.38, -29.68}, points = {{-50, 0}, {50, 0}}, color = {0, 0, 255}, thickness = 0.5), Text(origin = {-111, -36}, extent = {{-33, 8}, {33, -8}}, textString = "min = %min"), Text(origin = {-109, 44}, extent = {{-37, 8}, {33, -8}}, textString = "max = %max")}, coordinateSystem(initialScale = 0.1)));end min_max;
  end Components;

  model Examples
  extends Modelica.Icons.ExamplesPackage;

    model Crane
    extends Modelica.Icons.Example;
    SimpleMechanic.Basis.dc_machine dc_machine1(k = 100)  annotation(
        Placement(visible = true, transformation(origin = {30, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 1.1)  annotation(
        Placement(visible = true, transformation(origin = {-88, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  SimpleMechanic.Basis.inertia_rot inertia_rot1(I = 10)  annotation(
        Placement(visible = true, transformation(origin = {50, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  SimpleMechanic.Basis.ideal_train ideal_train1 annotation(
        Placement(visible = true, transformation(origin = {70, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Control.Components.control_deviation control_deviation annotation(
        Placement(visible = true, transformation(origin = {-64, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Control.Components.PID pid(K_D = 30, K_P = 100, T_I_param = 25, use_trasconst = false)  annotation(
        Placement(visible = true, transformation(origin = {-34, 10}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
  Control.Components.min_max min_max1(max = 24, min = -24)  annotation(
        Placement(visible = true, transformation(origin = {4,10}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
  SimpleMechanic.Basis.inertia_trans inertia_trans1(M = 1, activate_gravity = false, init = true, s0 = 0.6, v0 = 0)  annotation(
        Placement(visible = true, transformation(origin = {90, 2}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
    equation
      connect(inertia_trans1.y, control_deviation.y) annotation(
        Line(points = {{90, -2}, {90, -2}, {90, -24}, {-64, -24}, {-64, 2}, {-64, 2}, {-64, 4}}, color = {0, 0, 127}));
      connect(ideal_train1.flangeT, inertia_trans1.flangeT_P) annotation(
        Line(points = {{74, 4}, {74, 2}, {84, 2}}, color = {0, 85, 0}));
      connect(ideal_train1.flangeR, inertia_rot1.flangeR_N) annotation(
        Line(points = {{64, 10}, {56, 10}}, color = {255, 0, 0}));
      connect(dc_machine1.flangeR, inertia_rot1.flangeR_P) annotation(
        Line(points = {{36, 10}, {44, 10}}, color = {255, 0, 0}));
      connect(min_max1.y, dc_machine1.u) annotation(
        Line(points = {{16, 10}, {25, 10}}, color = {0, 0, 127}));
      connect(pid.y, min_max1.u) annotation(
        Line(points = {{-22, 10}, {-10, 10}, {-10, 10}, {-8, 10}}, color = {0, 0, 127}));
      connect(control_deviation.e, pid.u) annotation(
        Line(points = {{-58, 10}, {-47, 10}}, color = {0, 0, 127}));
      connect(control_deviation.w, const.y) annotation(
        Line(points = {{-70, 10}, {-77, 10}}, color = {0, 0, 127}));
    annotation(
        experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-6, Interval = 0.02));end Crane;
  equation

  end Examples;
  annotation(
    uses(Modelica(version = "3.2.3")),
    Documentation(info = "<html><head></head><body>This libary is a simple implementation of the basic control elements. To use the example of this project the libarys SimpleElectric and SimpleMechanic are needed!<div>Have fun while using this libary.</div></body></html>"));
end Control;
