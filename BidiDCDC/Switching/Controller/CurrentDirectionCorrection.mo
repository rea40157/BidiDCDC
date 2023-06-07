within BiChopper.Switching.Controller;
model CurrentDirectionCorrection
  extends Modelica.Blocks.Icons.Block;
  Modelica.Blocks.Interfaces.BooleanInput u1 annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{42,-10},{62,10}})));
  Modelica.Blocks.Math.Gain gain(k=-1)
    annotation (Placement(transformation(extent={{-72,-18},{-52,2}})));
  Modelica.Blocks.Interfaces.RealInput u
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput y
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  connect(switch1.u2, u1) annotation (Line(points={{40,0},{0,0},{0,-120}},
                     color={255,0,255}));
  connect(u, gain.u) annotation (Line(points={{-120,0},{-80,0},{-80,-8},{-74,-8}},
        color={0,0,127}));
  connect(gain.y, switch1.u3)
    annotation (Line(points={{-51,-8},{40,-8}},  color={0,0,127}));
  connect(switch1.u1, gain.u)
    annotation (Line(points={{40,8},{-80,8},{-80,-8},{-74,-8}},  color={0,0,127}));
  connect(switch1.y, y) annotation (Line(points={{63,0},{110,0}}, color={0,0,127}));
end CurrentDirectionCorrection;
