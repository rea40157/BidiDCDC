within BidiDCDC.Examples;
model ParallelCircuit "Two Parallel Controllers"
  extends Modelica.Icons.Example;
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltageLV(V=
        controlledBiChopper.dcdc.BiChopperData.VLV) annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-60,0})));
  Modelica.Electrical.Analog.Basic.Resistor resistorLV(R=0.01)
    annotation (Placement(transformation(extent={{-50,10},{-30,30}})));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-70,-40},{-50,-20}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltageHV(V=
        controlledBiChopper.dcdc.BiChopperData.VHV) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={60,0})));
  Modelica.Electrical.Analog.Basic.Resistor resistorHV(R=0.02)
    annotation (Placement(transformation(extent={{50,10},{30,30}})));
  Modelica.Blocks.Sources.Step step(height=2.5, startTime=0.025)
                                                               annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-30,-40})));
  Components.ControlledBiChopperHaa controlledBiChopper(redeclare Components.Averaging.CurrentBalance.ControlledBuckBoost dcdc "Averaging - fastest model") annotation (Placement(transformation(extent={{-10,-8},{10,12}})));
  Modelica.Blocks.Sources.Step step1(height=-2, startTime=0.02) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={6,-82})));
  Modelica.Blocks.Sources.Step step2(height=2, startTime=0.03) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={36,-82})));
  Modelica.Blocks.Math.MultiSum multiSum(nu=3) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={6,-54})));
  Modelica.Blocks.Sources.Step step3(height=2,
    offset=0,                                  startTime=0.01) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-24,-82})));
  Components.ControlledBiChopperHaa controlledBiChopper1(redeclare Components.Averaging.CurrentBalance.ControlledBuckBoost dcdc "Averaging - fastest model") annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={0,40})));
  Modelica.Blocks.Math.Gain gain(k=0.7) annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=90,
        origin={6,-24})));
  Modelica.Blocks.Math.Gain gain1(k=0.3) annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=270,
        origin={6,66})));
equation
  connect(constantVoltageLV.p,resistorLV. p)
    annotation (Line(points={{-60,10},{-60,20},{-50,20}}, color={0,0,255}));
  connect(constantVoltageLV.n,ground. p)
    annotation (Line(points={{-60,-10},{-60,-20}},           color={0,0,255}));
  connect(resistorHV.p,constantVoltageHV. p)
    annotation (Line(points={{50,20},{60,20},{60,10}}, color={0,0,255}));
  connect(resistorLV.n, controlledBiChopper.pin_pLV) annotation (Line(points={{-30,20},
          {-20,20},{-20,8},{-10,8}},        color={0,0,255}));
  connect(controlledBiChopper.pin_nLV, constantVoltageLV.n) annotation (Line(
        points={{-10,-4},{-24,-4},{-24,-20},{-60,-20},{-60,-10}},color={0,0,255}));
  connect(step.y, controlledBiChopper.DirectionPin)
    annotation (Line(points={{-19,-40},{-6,-40},{-6,-10}}, color={0,0,127}));
  connect(resistorHV.n, controlledBiChopper.pin_pHV)
    annotation (Line(points={{30,20},{20,20},{20,8},{10,8}}, color={0,0,255}));
  connect(controlledBiChopper.pin_nHV, constantVoltageHV.n) annotation (Line(
        points={{10,-4},{20,-4},{20,-20},{60,-20},{60,-10}}, color={0,0,255}));
  connect(step1.y, multiSum.u[1])
    annotation (Line(points={{6,-71},{6,-60},{3.2,-60}},               color={0,0,127}));
  connect(step2.y, multiSum.u[2])
    annotation (Line(points={{36,-71},{36,-66},{6,-66},{6,-60}},   color={0,0,127}));
  connect(step3.y, multiSum.u[3])
    annotation (Line(points={{-24,-71},{-24,-66},{6,-66},{6,-60},{8.8,-60}},
                                                                       color={0,0,127}));
  connect(controlledBiChopper1.pin_pLV, controlledBiChopper.pin_pLV)
    annotation (Line(points={{-10,34},{-20,34},{-20,8},{-10,8}}, color={0,0,255}));
  connect(controlledBiChopper1.pin_pHV, controlledBiChopper.pin_pHV)
    annotation (Line(points={{10,34},{20,34},{20,8},{10,8}}, color={0,0,255}));
  connect(controlledBiChopper1.pin_nLV, constantVoltageLV.n) annotation (Line(
        points={{-10,46},{-24,46},{-24,-20},{-60,-20},{-60,-10}}, color={0,0,
          255}));
  connect(controlledBiChopper1.DirectionPin, controlledBiChopper.DirectionPin)
    annotation (Line(points={{-6,52},{-6,60},{-80,60},{-80,-60},{-6,-60},{-6,
          -10}}, color={0,0,127}));
  connect(multiSum.y, gain.u)
    annotation (Line(points={{6,-46.98},{6,-33.6}}, color={0,0,127}));
  connect(controlledBiChopper.ISETA, gain.y)
    annotation (Line(points={{6,-10},{6,-15.2}}, color={0,0,127}));
  connect(gain1.y, controlledBiChopper1.ISETA)
    annotation (Line(points={{6,57.2},{6,52}}, color={0,0,127}));
  connect(gain1.u, gain.u) annotation (Line(points={{6,75.6},{6,80},{80,80},{80,
          -40},{6,-40},{6,-33.6}}, color={0,0,127}));
  annotation (experiment(
      StopTime=0.04,
      Interval=2e-06,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"), Documentation(info="<html>
<p>This Examples features two ControlledBiChopper with an Power split of 70&percnt; to 30&percnt;.</p>
</html>"));
end ParallelCircuit;
