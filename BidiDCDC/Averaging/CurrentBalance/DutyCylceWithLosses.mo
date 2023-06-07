within BiChopper.Averaging.CurrentBalance;
block DutyCylceWithLosses
  extends Modelica.Blocks.Icons.Block;
  parameter Modelica.Units.SI.Resistance RonTransistor=3.8e-03 "Transistor closed resistance";
  Modelica.Blocks.Math.Product product2
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Modelica.Blocks.Math.Product product1 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-36,0})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=1)
    annotation (Placement(transformation(extent={{-58,-90},{-38,-70}})));
  Modelica.Blocks.Math.Add add(k1=+1, k2=-1) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-6,-50})));
  Modelica.Blocks.Interfaces.RealInput DutyCycle annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120})));
  Modelica.Blocks.Interfaces.RealOutput DutyCurrent
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealOutput DutyVoltage annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-110,0})));
  Modelica.Blocks.Interfaces.RealInput Current annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-60,120})));
  Modelica.Blocks.Interfaces.RealInput Voltage annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={60,120})));
  Modelica.Blocks.Math.Add add1(k1=+1, k2=+1)
                                             annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-82,0})));
  Modelica.Blocks.Sources.Constant const(k=2*RonTransistor)
    annotation (Placement(transformation(extent={{-94,46},{-74,66}})));
  Modelica.Blocks.Math.Product product3 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-50,30})));
equation
  connect(realExpression.y,add. u1)
    annotation (Line(points={{-37,-80},{-12,-80},{-12,-62}}, color={0,0,127}));
  connect(add.u2,DutyCycle)  annotation (Line(points={{0,-62},{0,-120}},
                                               color={0,0,127}));
  connect(Current,product2. u1) annotation (Line(points={{-60,120},{-60,80},{40,
          80},{40,6},{58,6}}, color={0,0,127}));
  connect(add.y,product2. u2)
    annotation (Line(points={{-6,-39},{-6,-6},{58,-6}}, color={0,0,127}));
  connect(Voltage,product1. u2) annotation (Line(points={{60,120},{60,60},{0,60},
          {0,6},{-24,6}},       color={0,0,127}));
  connect(product1.u1,product2. u2)
    annotation (Line(points={{-24,-6},{58,-6}}, color={0,0,127}));
  connect(product2.y,DutyCurrent)
    annotation (Line(points={{81,0},{110,0}}, color={0,0,127}));
  connect(add1.y, DutyVoltage)
    annotation (Line(points={{-93,8.88178e-16},{-110,0}}, color={0,0,127}));
  connect(add1.u1, product1.y) annotation (Line(points={{-70,-6},{-52,-6},{-52,
          8.88178e-16},{-47,8.88178e-16}}, color={0,0,127}));
  connect(const.y, product3.u2)
    annotation (Line(points={{-73,56},{-56,56},{-56,42}}, color={0,0,127}));
  connect(product3.u1, product2.u1) annotation (Line(points={{-44,42},{-44,80},{
          40,80},{40,6},{58,6}}, color={0,0,127}));
  connect(product3.y, add1.u2)
    annotation (Line(points={{-50,19},{-50,6},{-70,6}}, color={0,0,127}));
end DutyCylceWithLosses;
