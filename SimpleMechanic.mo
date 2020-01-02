package SimpleMechanic
  extends Modelica.Icons.Package;
  import SI = Modelica.SIunits;

  package Interfaces
    extends Modelica.Icons.InterfacesPackage;

    connector FlangeR "rotation flange"
      SI.Angle phi "angle";
      flow SI.Torque tau "torque";
      annotation(
        Diagram(coordinateSystem(initialScale = 0.1)));
    end FlangeR;

    connector FlangeT "translation flange"
      SI.Position s "position";
      flow SI.Force f "force";
    end FlangeT;

    connector FlangeR_N
      extends FlangeR;
      annotation(
        Diagram,
        Icon(graphics = {Ellipse(lineColor = {255, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-80, 80}, {80, -80}}, endAngle = 360)}, coordinateSystem(initialScale = 0.1)));
    end FlangeR_N;

    connector FlangeR_P
      extends FlangeR;
      annotation(
        Diagram(coordinateSystem(initialScale = 0.1)),
        Icon(graphics = {Ellipse(lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-80, 80}, {80, -80}}, endAngle = 360)}));
    end FlangeR_P;

    connector FlangeT_N
      extends FlangeT;
      annotation(
        Diagram,
        Icon(graphics = {Rectangle(lineColor = {0, 85, 0}, extent = {{-60, 60}, {60, -60}})}));
    end FlangeT_N;

    connector FlangeT_P
      extends SimpleMechanic.Interfaces.FlangeT;
      annotation(
        Diagram(coordinateSystem(initialScale = 0.1)),
        Icon(graphics = {Rectangle(lineColor = {0, 85, 0}, fillColor = {0, 85, 0}, fillPattern = FillPattern.Solid, extent = {{-60, 60}, {60, -60}})}));
    end FlangeT_P;
  end Interfaces;

  package Basis
    extends Modelica.Icons.BasesPackage;

    model inertia_trans
      parameter SI.Mass M = 1 "Mass";
      parameter Boolean activate_gravity = true "switch to activate the gravity";
      parameter Boolean init = false "switch to activate the init";
      parameter SI.Length s0 = 0 "Init value position";
      parameter SI.Velocity v0 = 0 "Init value velocity";
      import Modelica.Constants.g_n;
      SI.Velocity v "Position";
      SI.Force f "Force";
      SI.Length s "Position";
      Interfaces.FlangeT_P flangeT_P annotation(
        Placement(visible = true, transformation(origin = {-60, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      SimpleMechanic.Interfaces.FlangeT_N flangeT_N annotation(
        Placement(visible = true, transformation(origin = {60, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {60, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput y "Output" annotation(
        Placement(visible = true, transformation(origin = {10, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    initial equation
      if init then
        s = s0;
        v = v0;
      end if;
    equation
      flangeT_P.s = flangeT_N.s;
      s = flangeT_P.s;
      v = der(s);
      f = if activate_gravity then M * (der(v) - g_n) else M * der(v);
      f = flangeT_P.f + flangeT_N.f;
      y = s;
      annotation(
        Diagram,
        Icon(graphics = {Rectangle(fillColor = {115, 115, 115}, pattern = LinePattern.None, fillPattern = FillPattern.Sphere, extent = {{-40, 20}, {40, -20}}), Line(origin = {-47, 0}, points = {{-7, 0}, {7, 0}}), Line(origin = {47, 0}, points = {{-7, 0}, {7, 0}}), Text(origin = {1, -40}, extent = {{-19, 8}, {19, -8}}, textString = "m=%M")}, coordinateSystem(initialScale = 0.1)));
    end inertia_trans;

    model inertia_rot
      parameter Modelica.SIunits.MomentOfInertia I = 1 "Moment of Inertia";
      parameter Boolean init = false "switch to activate the init";
      parameter SI.Angle phi0 = 0 "Init value angular";
      parameter SI.AngularVelocity w0 = 0 "Init value angular velocity";
      Modelica.SIunits.Torque tau "Torque";
      Modelica.SIunits.AngularVelocity w "Angular Velocity";
      Modelica.SIunits.Angle phi "Angle";
      SimpleMechanic.Interfaces.FlangeR_N flangeR_N annotation(
        Placement(visible = true, transformation(origin = {60, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {60, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      SimpleMechanic.Interfaces.FlangeR_P flangeR_P annotation(
        Placement(visible = true, transformation(origin = {-60, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-60, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    initial equation
      if init then
        phi = phi0;
        w = w0;
      end if;
    equation
      tau = I * der(w);
      phi = flangeR_N.phi;
      w = der(phi);
      flangeR_N.phi = flangeR_P.phi;
      tau = flangeR_N.tau + flangeR_P.tau;
      annotation(
        Diagram,
        Icon(graphics = {Rectangle(fillColor = {216, 216, 216}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-36, 34}, {36, -34}}), Rectangle(origin = {-48, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-12, 8}, {12, -8}}), Rectangle(origin = {48, -2}, fillColor = {255, 255, 255}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-12, 8}, {12, -8}}), Text(origin = {2, -50}, extent = {{-14, 8}, {14, -8}}, textString = "I=%I")}, coordinateSystem(initialScale = 0.1)));
    end inertia_rot;

    model EMF
      //Electromotive Force
      parameter Real k = 1;
      extends SimpleElectric.Interface.TwoPin annotation(
        Placement(visible = true, transformation(origin = {-24, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      SimpleMechanic.Interfaces.FlangeR_N flangeR_N annotation(
        Placement(visible = true, transformation(origin = {0, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      k * der(flangeR_N.phi) = u;
      flangeR_N.tau = -k * p.i;
      annotation(
        Diagram,
        Icon(graphics = {Line(origin = {-28, 0}, points = {{-8, 0}, {8, 0}}, color = {0, 0, 127}), Line(origin = {28, 0}, points = {{-8, 0}, {8, 0}}, color = {0, 0, 127}), Rectangle(origin = {0, 34}, fillColor = {255, 255, 255}, fillPattern = FillPattern.VerticalCylinder, extent = {{-8, -16}, {8, 16}}), Ellipse(origin = {0, -1}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-20, -19}, {20, 21}}, endAngle = 360)}));
    end EMF;

    model ideal_train
      parameter Real k = 1;
      SimpleMechanic.Interfaces.FlangeR_P flangeR annotation(
        Placement(visible = true, transformation(origin = {-60, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-60, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      SimpleMechanic.Interfaces.FlangeT_N flangeT annotation(
        Placement(visible = true, transformation(origin = {40, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {40, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      flangeT.s = flangeR.phi * k;
      k * flangeT.f = flangeR.tau;
      annotation(
        Icon(graphics = {Line(origin = {40.1906, -20}, points = {{0, 20}, {0, -34}}, color = {0, 85, 0}, thickness = 1), Rectangle(origin = {-44, 0}, lineColor = {140, 140, 140}, fillColor = {255, 255, 255}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-16, 8}, {16, -8}}), Ellipse(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{40, -40}, {-40, 40}}, endAngle = 360), Ellipse(fillPattern = FillPattern.Solid, extent = {{12, -12}, {-12, 12}}, endAngle = 360), Text(origin = {-35, -59}, extent = {{-17, 9}, {17, -9}}, textString = "k=%k")}, coordinateSystem(initialScale = 0.1)));
    end ideal_train;

    model dc_machine
      parameter Modelica.SIunits.Resistance r = 100;
      parameter Modelica.SIunits.Inductance l = 0.01;
      parameter Real k = 10;
      SimpleElectric.BasisElements.Resistance R(R = r) annotation(
        Placement(visible = true, transformation(origin = {-18, 20}, extent = {{-32, -32}, {32, 32}}, rotation = 0)));
      SimpleElectric.BasisElements.Inductance L(L = l, i(fixed = true, start = 0)) annotation(
        Placement(visible = true, transformation(origin = {20, 20}, extent = {{-36, -36}, {36, 36}}, rotation = 0)));
      SimpleElectric.BasisElements.GND gnd annotation(
        Placement(visible = true, transformation(origin = {0, -56}, extent = {{-22, -22}, {22, 22}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput u annotation(
        Placement(visible = true, transformation(origin = {-80, -20}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-52, 0}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
      SimpleMechanic.Basis.EMF emf1(k = k) annotation(
        Placement(visible = true, transformation(origin = {40, -20}, extent = {{20, 20}, {-20, -20}}, rotation = 90)));
      SimpleElectric.BasisElements.Voltage_Source_real_input voltage_Source annotation(
        Placement(visible = true, transformation(origin = {-40, -20}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
      SimpleMechanic.Interfaces.FlangeR_N flangeR annotation(
        Placement(visible = true, transformation(origin = {80, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {60, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(emf1.n, gnd.PinP) annotation(
        Line(points = {{40, -28}, {40, -28}, {40, -40}, {0, -40}, {0, -56}, {0, -56}}));
      connect(gnd.PinP, voltage_Source.n) annotation(
        Line(points = {{0, -56}, {0, -56}, {0, -40}, {-40, -40}, {-40, -28}, {-40, -28}}));
      connect(emf1.flangeR_N, flangeR) annotation(
        Line(points = {{50, -20}, {72, -20}, {72, -20}, {80, -20}}, color = {255, 0, 0}));
      connect(emf1.p, L.n) annotation(
        Line(points = {{40, -12}, {40, -12}, {40, 20}, {34, 20}, {34, 20}}));
      connect(voltage_Source.p, R.p) annotation(
        Line(points = {{-40, -12}, {-40, -12}, {-40, 20}, {-30, 20}, {-30, 20}}));
      connect(voltage_Source.u_soll, u) annotation(
        Line(points = {{-46, -20}, {-62, -20}, {-62, -20}, {-80, -20}}, color = {0, 0, 127}));
      connect(R.n, L.p) annotation(
        Line(points = {{-5, 20}, {6, 20}}));
      annotation(
        uses(Modelica(version = "3.2.3")),
        Icon(graphics = {Rectangle(origin = {1, -35}, fillPattern = FillPattern.Solid, extent = {{-29, -9}, {29, 9}}), Rectangle(origin = {0, -1}, lineColor = {35, 35, 35}, fillColor = {255, 0, 0}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-40, 29}, {40, -31}}), Rectangle(origin = {50, 0}, lineColor = {111, 111, 111}, fillColor = {255, 255, 255}, fillPattern = FillPattern.HorizontalCylinder, extent = {{10, 8}, {-10, -8}}), Text(origin = {-65, -69}, extent = {{-15, 7}, {15, -7}}, textString = "R=%r R"), Text(origin = {-1, -69}, extent = {{-15, 7}, {15, -7}}, textString = "L=%l H"), Text(origin = {65, -69}, extent = {{-15, 7}, {15, -7}}, textString = "k=%k")}, coordinateSystem(initialScale = 0.1)));
    end dc_machine;
  end Basis;

  package Examples
    extends Modelica.Icons.ExamplesPackage;

    model Test
      extends Modelica.Icons.Example;
      SimpleMechanic.Basis.dc_machine dc_machine annotation(
        Placement(visible = true, transformation(origin = {-26, 64}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      SimpleMechanic.Basis.inertia_rot inertia_rot(I = 10) annotation(
        Placement(visible = true, transformation(origin = {20, 64}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant const(k = 120) annotation(
        Placement(visible = true, transformation(origin = {-68, 64}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      SimpleMechanic.Basis.ideal_train ideal_train annotation(
        Placement(visible = true, transformation(origin = {66, 64}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      SimpleMechanic.Basis.inertia_trans inertia_trans(M = 1, activate_gravity = true, s(fixed = true), v(fixed = true)) annotation(
        Placement(visible = true, transformation(origin = {74, 16}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
    equation
      connect(inertia_trans.flangeT_P, ideal_train.flangeT) annotation(
        Line(points = {{74, 28}, {74, 28}, {74, 52}, {74, 52}}, color = {0, 85, 0}));
      connect(ideal_train.flangeR, inertia_rot.flangeR_N) annotation(
        Line(points = {{54, 64}, {32, 64}, {32, 64}, {32, 64}}, color = {255, 0, 0}));
      connect(const.y, dc_machine.u) annotation(
        Line(points = {{-57, 64}, {-39, 64}, {-39, 64}, {-37, 64}}, color = {0, 0, 127}));
      connect(inertia_rot.flangeR_P, dc_machine.flangeR) annotation(
        Line(points = {{8, 64}, {-14, 64}, {-14, 64}, {-14, 64}}, color = {255, 0, 0}));
    end Test;

    model MachineTest
      extends Modelica.Icons.Example;
      SimpleMechanic.Basis.dc_machine dc_machine1 annotation(
        Placement(visible = true, transformation(origin = {-1, -1}, extent = {{-31, -31}, {31, 31}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant const(k = 12) annotation(
        Placement(visible = true, transformation(origin = {-70, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(dc_machine1.u, const.y) annotation(
        Line(points = {{-18, 0}, {-60, 0}, {-60, 0}, {-58, 0}}, color = {0, 0, 127}));
    end MachineTest;
  end Examples;
  annotation(
    uses(Modelica(version = "3.2.3")));
end SimpleMechanic;
