within BiChopper.Switching.DiodeMode;
model CurrentDirectionCorrection
  extends Modelica.Blocks.Icons.Block;
  Modelica.Blocks.Interfaces.BooleanInput u1 annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120})));
  Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold(threshold
      =0.4)
    annotation (Placement(transformation(extent={{46,-10},{66,10}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
  Modelica.Blocks.Math.Gain gain(k=-1)
    annotation (Placement(transformation(extent={{-72,-18},{-52,2}})));
  Modelica.Blocks.Interfaces.RealInput u
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.BooleanOutput y
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  connect(switch1.u2, u1) annotation (Line(points={{-10,0},{-40,0},{-40,-80},{0,-80},
          {0,-120}}, color={255,0,255}));
  connect(u, gain.u) annotation (Line(points={{-120,0},{-80,0},{-80,-8},{-74,-8}},
        color={0,0,127}));
  connect(gain.y, switch1.u3)
    annotation (Line(points={{-51,-8},{-10,-8}}, color={0,0,127}));
  connect(switch1.u1, gain.u)
    annotation (Line(points={{-10,8},{-80,8},{-80,-8},{-74,-8}}, color={0,0,127}));
  connect(switch1.y, greaterEqualThreshold.u)
    annotation (Line(points={{13,0},{44,0}}, color={0,0,127}));
  connect(greaterEqualThreshold.y, y)
    annotation (Line(points={{67,0},{110,0}}, color={255,0,255}));
end CurrentDirectionCorrection;
