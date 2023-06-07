within BiChopper.Averaging.CurrentBalance;
model DutyCycleReiter
  extends Modelica.Blocks.Icons.Block;
  parameter Modelica.Units.SI.Resistance RonTransistor=1e-05 "Transistor closed resistance";
  Modelica.Blocks.Math.Product product2
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Modelica.Blocks.Math.Product product1 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-70,0})));
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
equation
  connect(realExpression.y, add.u1)
    annotation (Line(points={{-37,-80},{-12,-80},{-12,-62}}, color={0,0,127}));
  connect(add.u2, DutyCycle) annotation (Line(points={{-8.88178e-16,-62},{
          -8.88178e-16,-96},{0,-96},{0,-120}}, color={0,0,127}));
  connect(Current, product2.u1) annotation (Line(points={{-60,120},{-60,20},{40,
          20},{40,6},{58,6}}, color={0,0,127}));
  connect(add.y, product2.u2)
    annotation (Line(points={{-6,-39},{-6,-6},{58,-6}}, color={0,0,127}));
  connect(Voltage, product1.u2) annotation (Line(points={{60,120},{60,60},{-40,60},
          {-40,6},{-58,6}},     color={0,0,127}));
  connect(product1.u1, product2.u2)
    annotation (Line(points={{-58,-6},{58,-6}}, color={0,0,127}));
  connect(product2.y, DutyCurrent)
    annotation (Line(points={{81,0},{110,0}}, color={0,0,127}));
  connect(product1.y, DutyVoltage)
    annotation (Line(points={{-81,8.88178e-16},{-110,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>
Used to structure BuckBoostReiter. Calculates the Current and Voltage from the DutyCycle.
</p>
</html>"));
end DutyCycleReiter;
