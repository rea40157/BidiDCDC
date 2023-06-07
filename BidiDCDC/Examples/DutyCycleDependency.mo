within BidiDCDC.Examples;
model DutyCycleDependency
  extends Modelica.Icons.Example;
  parameter Modelica.Units.SI.Voltage VLV=12 "LV voltage";
  parameter Modelica.Units.SI.Voltage VHV=24 "HV voltage";
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltageLV(V=VLV)
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-60,-30})));
  Modelica.Electrical.Analog.Basic.Resistor resistorLV(R=0.01)
    annotation (Placement(transformation(extent={{-50,-20},{-30,0}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltageHV(V=VHV)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={60,-30})));
  Modelica.Electrical.Analog.Basic.Resistor resistorHV(R=0.02)
    annotation (Placement(transformation(extent={{50,-20},{30,0}})));
  Modelica.Blocks.Sources.Ramp dutyCycle(
    height=1,
    duration=1,
    offset=0,
    startTime=0.5)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-10,-70})));
  Modelica.Blocks.Sources.RealExpression vLV(y=dcdc.dc_p1.v)
    annotation (Placement(transformation(extent={{-80,70},{-60,90}})));
  Modelica.Blocks.Sources.RealExpression pLV(y=iLV.y*vLV.y)
    annotation (Placement(transformation(extent={{-80,10},{-60,30}})));
  Modelica.Blocks.Sources.RealExpression vHV(y=dcdc.dc_p2.v)
    annotation (Placement(transformation(extent={{80,70},{60,90}})));
  Modelica.Blocks.Sources.RealExpression iHV(y=dcdc.dc_p2.i)
    annotation (Placement(transformation(extent={{80,40},{60,60}})));
  Modelica.Blocks.Sources.RealExpression pHV(y=vHV.y*iHV.y)
    annotation (Placement(transformation(extent={{80,10},{60,30}})));
  Modelica.Blocks.Math.Mean mean_vLV(f=dcdc.fS)
    annotation (Placement(transformation(extent={{-50,70},{-30,90}})));
  Modelica.Blocks.Math.Mean mean_pLV(f=dcdc.fS)
    annotation (Placement(transformation(extent={{-50,10},{-30,30}})));
  Modelica.Blocks.Math.Mean mean_vHV(f=dcdc.fS)
    annotation (Placement(transformation(extent={{50,70},{30,90}})));
  Modelica.Blocks.Math.Mean mean_iHV(f=dcdc.fS)
    annotation (Placement(transformation(extent={{50,40},{30,60}})));
  Modelica.Blocks.Math.Mean mean_pHV(f=dcdc.fS)
    annotation (Placement(transformation(extent={{50,10},{30,30}})));
  Modelica.Blocks.Sources.RealExpression iLV(y=dcdc.dc_p1.i)
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  Modelica.Blocks.Math.Mean mean_iLV(f=dcdc.fS)
    annotation (Placement(transformation(extent={{-50,40},{-30,60}})));
  Components.Averaging.CurrentBalance.BuckBoostReiter dcdc annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-52,-60},{-32,-40}})));
equation
  connect(constantVoltageLV.p,resistorLV. p)
    annotation (Line(points={{-60,-20},{-60,-10},{-50,-10}},
                                                          color={0,0,255}));
  connect(resistorHV.p,constantVoltageHV. p)
    annotation (Line(points={{50,-10},{60,-10},{60,-20}},
                                                       color={0,0,255}));
  connect(vLV.y,mean_vLV. u)
    annotation (Line(points={{-59,80},{-52,80}}, color={0,0,127}));
  connect(mean_iHV.u,iHV. y)
    annotation (Line(points={{52,50},{59,50}}, color={0,0,127}));
  connect(vHV.y,mean_vHV. u)
    annotation (Line(points={{59,80},{52,80}}, color={0,0,127}));
  connect(pLV.y,mean_pLV. u)
    annotation (Line(points={{-59,20},{-52,20}}, color={0,0,127}));
  connect(mean_pHV.u,pHV. y)
    annotation (Line(points={{52,20},{59,20}}, color={0,0,127}));
  connect(iLV.y,mean_iLV. u)
    annotation (Line(points={{-59,50},{-52,50}}, color={0,0,127}));
  connect(dutyCycle.y, dcdc.dutyCycle)
    annotation (Line(points={{1,-70},{6,-70},{6,-42}}, color={0,0,127}));
  connect(resistorLV.n, dcdc.dc_p1)
    annotation (Line(points={{-30,-10},{-20,-10},{-20,-24},{-10,-24}}, color={0,0,255}));
  connect(dcdc.dc_p2, resistorHV.n)
    annotation (Line(points={{10,-24},{22,-24},{22,-10},{30,-10}}, color={0,0,255}));
  connect(constantVoltageHV.n, dcdc.dc_n2)
    annotation (Line(points={{60,-40},{34,-40},{34,-36},{10,-36}}, color={0,0,255}));
  connect(dcdc.dc_n1, constantVoltageLV.n)
    annotation (Line(points={{-10,-36},{-36,-36},{-36,-40},{-60,-40}}, color={0,0,255}));
  connect(dcdc.dc_n1, ground.p)
    annotation (Line(points={{-10,-36},{-36,-36},{-36,-40},{-42,-40}}, color={0,0,255}));
  annotation (experiment(
      StopTime=2,
      Interval=2e-06,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"), Documentation(info="<html>
<p>This Examples tests the uncontrolled behavior of the BiChopper.</p>
</html>"));
end DutyCycleDependency;
