within BiChopper.Averaging.CurrentBalance;
block CHCompensation "Halfs the DutyCycle if the two ch are active"
  extends Modelica.Blocks.Icons.Block;
  Modelica.Blocks.Logical.And and1
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Blocks.Interfaces.BooleanInput EnableCH1
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.BooleanInput EnableCH2
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Interfaces.RealInput u2 annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120})));
  Modelica.Blocks.Interfaces.RealOutput y annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,110})));
  Modelica.Blocks.Logical.Switch switch1 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,50})));
  Modelica.Blocks.Math.Gain gain(k=0.5) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-8,-20})));
equation
  connect(EnableCH1, and1.u1)
    annotation (Line(points={{-120,60},{-80,60},{-80,0},{-62,0}}, color={255,0,255}));
  connect(EnableCH2, and1.u2)
    annotation (Line(points={{-120,-60},{-80,-60},{-80,-8},{-62,-8}}, color={255,0,255}));
  connect(and1.y, switch1.u2)
    annotation (Line(points={{-39,0},{0,0},{0,38}}, color={255,0,255}));
  connect(switch1.u1, gain.y) annotation (Line(points={{-8,38},{-8,-9}}, color={0,0,127}));
  connect(gain.u, u2)
    annotation (Line(points={{-8,-32},{-8,-80},{0,-80},{0,-120}}, color={0,0,127}));
  connect(switch1.u3, u2)
    annotation (Line(points={{8,38},{8,-80},{0,-80},{0,-120}}, color={0,0,127}));
  connect(switch1.y, y) annotation (Line(points={{0,61},{0,110}}, color={0,0,127}));
end CHCompensation;
