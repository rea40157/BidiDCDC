within BidiDCDC.Examples;
model ControlledStepCoice "Step on an Controller"
  extends Modelica.Icons.Example;
  parameter Modelica.Units.SI.Voltage VLV=12 "LV voltage";
  parameter Modelica.Units.SI.Voltage VHV=24 "HV voltage";
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltageLV(V=
        controlledBiChopper.BiChopperData.VLV) annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-60,0})));
  Modelica.Electrical.Analog.Basic.Resistor resistorLV(R=0.01)
    annotation (Placement(transformation(extent={{-50,10},{-30,30}})));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-70,-40},{-50,-20}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltageHV(V=
        controlledBiChopper.BiChopperData.VHV) annotation (Placement(
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
  Components.ControlledBiChopper controlledBiChopper(
    chooseComponent=BidiDCDC.Types.ChooseComponent.DiodeEmulatedMode,
    EnableCH1=true,
    EnableCH2=true,
    BiChopperData=ParameterRecords.BiChopper()) annotation (Placement(transformation(extent={{-6,-8},{14,12}})));
  Modelica.Blocks.Sources.Step step1(height=-2, startTime=0.02) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={76,-50})));
  Modelica.Blocks.Sources.Step step2(height=2, startTime=0.03) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={64,-82})));
  Modelica.Blocks.Math.MultiSum multiSum(nu=3) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=180,
        origin={14,-66})));
  Modelica.Blocks.Sources.Step step3(height=2,
    offset=0,                                  startTime=0.01) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={50,-38})));
equation
  connect(constantVoltageLV.p,resistorLV. p)
    annotation (Line(points={{-60,10},{-60,20},{-50,20}}, color={0,0,255}));
  connect(constantVoltageLV.n,ground. p)
    annotation (Line(points={{-60,-10},{-60,-20}},           color={0,0,255}));
  connect(resistorHV.p,constantVoltageHV. p)
    annotation (Line(points={{50,20},{60,20},{60,10}}, color={0,0,255}));
  connect(resistorLV.n, controlledBiChopper.pin_pLV) annotation (Line(points={{
          -30,20},{-20,20},{-20,8},{-6,8}}, color={0,0,255}));
  connect(controlledBiChopper.pin_nLV, constantVoltageLV.n) annotation (Line(
        points={{-6,-4},{-20,-4},{-20,-20},{-60,-20},{-60,-10}}, color={0,0,255}));
  connect(step.y, controlledBiChopper.DirectionPin)
    annotation (Line(points={{-19,-40},{-2,-40},{-2,-10}}, color={0,0,127}));
  connect(resistorHV.n, controlledBiChopper.pin_pHV)
    annotation (Line(points={{30,20},{20,20},{20,8},{14,8}}, color={0,0,255}));
  connect(controlledBiChopper.pin_nHV, constantVoltageHV.n) annotation (Line(
        points={{14,-4},{20,-4},{20,-20},{60,-20},{60,-10}}, color={0,0,255}));
  connect(step1.y, multiSum.u[1])
    annotation (Line(points={{65,-50},{18,-50},{18,-68.8},{20,-68.8}}, color={0,0,127}));
  connect(step2.y, multiSum.u[2])
    annotation (Line(points={{53,-82},{34,-82},{34,-66},{20,-66}}, color={0,0,127}));
  connect(multiSum.y, controlledBiChopper.ISETA) annotation (Line(points={{6.98,
          -66},{4,-66},{4,-10},{10,-10}}, color={0,0,127}));
  connect(step3.y, multiSum.u[3])
    annotation (Line(points={{39,-38},{24,-38},{24,-63.2},{20,-63.2}}, color={0,0,127}));
  annotation (experiment(
      StopTime=0.04,
      Interval=2e-06,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"), Documentation(info="<html>
<p>This Example tests the Controlled BiChopper with a Step on the Controller.</p>
</html>"));
end ControlledStepCoice;
