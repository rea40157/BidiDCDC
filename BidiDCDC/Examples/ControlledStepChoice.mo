within BidiDCDC.Examples;
model ControlledStepChoice "Step on an Controller"
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
  Components.ControlledBiChopperHaa controlledBiChopper(redeclare Components.Switching.DiodeMode.ControlledBuckBoost dcdc(UseExtEnable=false) "DiodeMode - most accurate") annotation (Placement(transformation(extent={{-10,-8},{10,12}})));
  Modelica.Blocks.Sources.Step step1(height=-2, startTime=0.02) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={80,-60})));
  Modelica.Blocks.Sources.Step step2(height=2, startTime=0.03) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={50,-80})));
  Modelica.Blocks.Math.MultiSum multiSum(nu=3) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={6,-26})));
  Modelica.Blocks.Sources.Step step3(height=2,
    offset=0,                                  startTime=0.01) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={50,-40})));
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
        points={{-10,-4},{-20,-4},{-20,-20},{-60,-20},{-60,-10}},color={0,0,255}));
  connect(step.y, controlledBiChopper.DirectionPin)
    annotation (Line(points={{-19,-40},{-6,-40},{-6,-10}}, color={0,0,127}));
  connect(resistorHV.n, controlledBiChopper.pin_pHV)
    annotation (Line(points={{30,20},{20,20},{20,8},{10,8}}, color={0,0,255}));
  connect(controlledBiChopper.pin_nHV, constantVoltageHV.n) annotation (Line(
        points={{10,-4},{20,-4},{20,-20},{60,-20},{60,-10}}, color={0,0,255}));
  connect(step1.y, multiSum.u[1])
    annotation (Line(points={{69,-60},{6,-60},{6,-32},{3.2,-32}},      color={0,0,127}));
  connect(step2.y, multiSum.u[2])
    annotation (Line(points={{39,-80},{6,-80},{6,-32}},            color={0,0,127}));
  connect(multiSum.y, controlledBiChopper.ISETA) annotation (Line(points={{6,
          -18.98},{6,-10}},               color={0,0,127}));
  connect(step3.y, multiSum.u[3])
    annotation (Line(points={{39,-40},{6,-40},{6,-32},{8.8,-32}},      color={0,0,127}));
  annotation (experiment(
      StopTime=0.04,
      Interval=2e-07,
      Tolerance=1e-07,
      __Dymola_Algorithm="Dassl"), Documentation(info="<html>
<p>This Example tests the Controlled BiChopper with a Step on the Controller.</p>
</html>"));
end ControlledStepChoice;
