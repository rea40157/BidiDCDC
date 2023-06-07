within BiChopper.Averaging.CurrentBalance;
model BuckBoostReiter
  extends Modelica.Blocks.Icons.Block;
  extends Modelica.Electrical.PowerConverters.Interfaces.DCDC.DCtwoPin1(iDC1(start=0));
  extends Modelica.Electrical.PowerConverters.Interfaces.DCDC.DCtwoPin2;
  import Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20;
  parameter Modelica.Units.SI.Frequency fS=40e3 "Switching frequency";
  parameter Modelica.Units.SI.Inductance L=4.7e-6 "Inductance";
  parameter Modelica.Units.SI.Resistance R=1e-3 "Resistance of inductor @TRef";
  parameter Modelica.Units.SI.Temperature TRef=293.15 "Reference temperature";
  parameter Modelica.Units.SI.LinearTemperatureCoefficient alpha20=Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero "Temperature coefficient of resistance 20degC";
  parameter Modelica.Units.SI.Time Ti=1e-6 "Integral time constant of power balance";
  parameter Modelica.Units.SI.Resistance RonTransistor=3.8e-03 "Transistor closed resistance";
  Modelica.Electrical.Analog.Basic.Inductor inductor(i(fixed=false),L=L)
    annotation (Placement(transformation(extent={{-60,70},{-40,90}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor(
    R=R,
    T_ref=TRef,
    alpha=alpha20,
    useHeatPort=false)
    annotation (Placement(transformation(extent={{-90,70},{-70,90}})));
  Modelica.Electrical.Analog.Sources.SignalVoltage signalVoltage annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-10,-10})));
  Modelica.Electrical.Analog.Sources.SignalCurrent signalCurrent annotation (
      Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=270,
        origin={80,-10})));
  Modelica.Blocks.Interfaces.RealInput dutyCycle annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={60,-120})));
  Modelica.Blocks.Interfaces.RealOutput ILV "Sampled low voltage current"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60,-110})));
  Modelica.Electrical.Analog.Sensors.PotentialSensor potentialSensor
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={70,80})));
  DutyCylceWithLosses
                  dutyCylceWithLosses(RonTransistor=3.8e-3)
    annotation (Placement(transformation(extent={{20,20},{40,40}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
    annotation (Placement(transformation(extent={{-30,70},{-10,90}})));
  Modelica.Blocks.Continuous.FirstOrder  firstOrder(
    k=1,
    T=0.5/fS,
    initType=Modelica.Blocks.Types.Init.InitialState,
    y_start=0)                                     annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60,-2})));
equation
  connect(resistor.n,inductor. p)
    annotation (Line(points={{-70,80},{-60,80}}, color={0,0,255}));
  connect(dutyCylceWithLosses.DutyVoltage, signalVoltage.v)
    annotation (Line(points={{19,30},{10,30},{10,-10},{2,-10}},  color={0,0,127}));
  connect(dutyCylceWithLosses.DutyCurrent, signalCurrent.i)
    annotation (Line(points={{41,30},{60,30},{60,-10},{68,-10}}, color={0,0,127}));
  connect(dutyCylceWithLosses.Voltage, potentialSensor.phi)
    annotation (Line(points={{36,42},{36,80},{59,80}}, color={0,0,127}));
  connect(inductor.n, currentSensor.p)
    annotation (Line(points={{-40,80},{-30,80}}, color={0,0,255}));
  connect(signalVoltage.p, currentSensor.n) annotation (Line(points={{-10,0},{-10,
          80}},                                    color={0,0,255}));
  connect(currentSensor.i, dutyCylceWithLosses.Current)
    annotation (Line(points={{-20,69},{-20,60},{24,60},{24,42}}, color={0,0,127}));
  connect(dutyCycle, dutyCylceWithLosses.DutyCycle) annotation (Line(points={{60,-120},
          {60,-20},{30,-20},{30,18}},       color={0,0,127}));
  connect(ILV, firstOrder.y)
    annotation (Line(points={{-60,-110},{-60,-13}}, color={0,0,127}));
  connect(firstOrder.u, dutyCylceWithLosses.Current)
    annotation (Line(points={{-60,10},{-60,60},{24,60},{24,42}}, color={0,0,127}));
  connect(dc_p1, resistor.p)
    annotation (Line(points={{-100,60},{-100,80},{-90,80}}, color={0,0,255}));
  connect(potentialSensor.p, dc_p2)
    annotation (Line(points={{80,80},{100,80},{100,60}}, color={0,0,255}));
  connect(dc_p2, signalCurrent.n) annotation (Line(points={{100,60},{80,60},{80,
          3.55271e-15}}, color={0,0,255}));
  connect(dc_n2, signalCurrent.p)
    annotation (Line(points={{100,-60},{80,-60},{80,-20}}, color={0,0,255}));
  connect(dc_n1, dc_n2)
    annotation (Line(points={{-100,-60},{100,-60}}, color={0,0,255}));
  connect(dc_n1, signalVoltage.n) annotation (Line(points={{-100,-60},{-10,-60},
          {-10,-20}}, color={0,0,255}));
  annotation (defaultComponentName="dcdc", Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-70,68},{-30,52}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
                   Line(points={{10,0},{0,0},{0,20},{0,-20},{0,-4},{-16,-20},
              {-10,-8},{-4,-14},{-16,-20},{-20,-24},{-20,-60},{-20,-24},{-30,
              -24},{-30,8},{-20,-8},{-40,-8},{-30,8},{-20,8},{-40,8},{-30,8},
              {-30,24},{-20,24},{-20,60},{-20,24},{0,4}},
                                   color={28,108,200}), Line(
          points={{0,-25},{0,-15},{20,-15},{-20,-15},{-4,-15},{-20,1},{-8,-5},{-14,
              -11},{-20,1},{-24,5},{-130,5},{-24,5},{-24,15},{8,15},{-8,5},{-8,25},
              {8,15},{8,5},{8,25},{8,15},{24,15},{24,5},{50,5},{24,5},{4,-15}},
          color={28,108,200},
          origin={40,55},
          rotation=360),
        Line(points={{-90,-60},{90,-60}}, color={28,108,200})}),
      Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>
Buck Boost model according Reiter without losses.
Reiter: Reglerentwicklung und Opitmierungsmethoden für DC/DC-Wandler im Kraftfahrzeug, 2010, München
I2=(1-D)*IL
U1=(1-D)*UCHv
</html>"));
end BuckBoostReiter;
