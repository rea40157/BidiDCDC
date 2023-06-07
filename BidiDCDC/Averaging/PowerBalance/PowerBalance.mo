within BiChopper.Averaging.PowerBalance;
block PowerBalance
  extends Modelica.Blocks.Interfaces.SISO;
  parameter Modelica.Units.SI.Time Ti=1e-6 "Integral time constant of power balance";
  Modelica.Blocks.Math.Feedback feedback
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Continuous.Integrator integrator(
    k=1/Ti,
    initType=Modelica.Blocks.Types.Init.InitialState,
    y_start=0)
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  Modelica.Blocks.Interfaces.RealInput u2 annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120})));
equation
  connect(u, feedback.u1)
    annotation (Line(points={{-120,0},{-8,0}}, color={0,0,127}));
  connect(feedback.y, integrator.u)
    annotation (Line(points={{9,0},{28,0}}, color={0,0,127}));
  connect(integrator.y, y)
    annotation (Line(points={{51,0},{110,0}}, color={0,0,127}));
  connect(u2, feedback.u2)
    annotation (Line(points={{0,-120},{0,-8}}, color={0,0,127}));
  annotation (Documentation(info="<html>
<p>
P3=P1-P0
</html>"));
end PowerBalance;
