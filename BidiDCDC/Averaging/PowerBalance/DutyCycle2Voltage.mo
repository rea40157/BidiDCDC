within BiChopper.Averaging.PowerBalance;
block DutyCycle2Voltage
  extends Modelica.Blocks.Interfaces.SISO;
  parameter Modelica.Units.SI.Frequency fS=40e3 "Swicthing frequency";
  Modelica.Blocks.Interfaces.RealInput v2 annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(
    k=1,
    T=0.5/fS,
    initType=Modelica.Blocks.Types.Init.InitialState,
    y_start=0)
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Modelica.Blocks.Math.Product product1
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=1, uMin=0) annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={-82,0})));
  Modelica.Blocks.Math.Abs abs1
    annotation (Placement(transformation(extent={{-32,-10},{-12,10}})));
  Modelica.Blocks.Math.Add add(k1=-1)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=1)
    annotation (Placement(transformation(extent={{-96,16},{-76,36}})));
equation
  connect(firstOrder.y, product1.u1)
    annotation (Line(points={{21,0},{50,0},{50,6},{58,6}},color={0,0,127}));
  connect(v2, product1.u2)
    annotation (Line(points={{0,-120},{0,-60},{40,-60},{40,-6},{58,-6}},
                                                       color={0,0,127}));
  connect(product1.y, y)
    annotation (Line(points={{81,0},{110,0}}, color={0,0,127}));
  connect(limiter.u, u)
    annotation (Line(points={{-94,0},{-120,0}}, color={0,0,127}));
  connect(limiter.y, add.u2)
    annotation (Line(points={{-71,0},{-68,0},{-68,-6},{-62,-6}},
                                               color={0,0,127}));
  connect(add.y, abs1.u) annotation (Line(points={{-39,0},{-34,0}},
               color={0,0,127}));
  connect(abs1.y, firstOrder.u)
    annotation (Line(points={{-11,0},{-2,0}}, color={0,0,127}));
  connect(realExpression.y, add.u1)
    annotation (Line(points={{-75,26},{-68,26},{-68,6},{-62,6}},
                                                          color={0,0,127}));
  annotation (Documentation(info="<html>
<p>
U1=dutyCycle*U
</p>
</html>"));
end DutyCycle2Voltage;
