within BiChopper.Averaging.PowerBalance;
model BuckBoost "Bidirectional chopper"
  extends Modelica.Electrical.PowerConverters.Interfaces.DCDC.DCtwoPin1;
  extends Modelica.Electrical.PowerConverters.Interfaces.DCDC.DCtwoPin2;
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T=293.15);
  import Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20;
  import BiChopper.Switching.PWMmode.SingleReferenceType;
  parameter Modelica.Units.SI.Frequency fS=40e3 "Swicthing frequency";
  parameter Modelica.Units.SI.Inductance L=4.7e-6 "Inductance";
  parameter Modelica.Units.SI.Resistance R=1e-3 "Resistance of inductor @TRef";
  parameter Modelica.Units.SI.Temperature TRef=293.15 "Reference temperature";
  parameter LinearTemperatureCoefficient20 alpha20=Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero
    "Temperature coefficient of resistance 20degC";
  parameter Modelica.Units.SI.Time Ti=1e-6 "Integral time constant of power balance";
  Modelica.Units.SI.Current iLV(start=0)=inductor.i "LV current";
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
  Modelica.Electrical.Analog.Basic.Inductor inductor(i(fixed=false), L=L)
    annotation (Placement(transformation(extent={{-70,70},{-50,90}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor(
    R=R,
    T_ref=TRef,
    alpha=alpha20,
    useHeatPort=false)
    annotation (Placement(transformation(extent={{-100,70},{-80,90}})));

  Modelica.Electrical.Analog.Sensors.MultiSensor multiSensorLV
    annotation (Placement(transformation(extent={{-40,70},{-20,90}})));
  Modelica.Electrical.Analog.Sensors.MultiSensor multiSensorHV
    annotation (Placement(transformation(extent={{60,70},{80,90}})));
  Modelica.Electrical.Analog.Sources.SignalVoltage signalVoltage annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-10,-20})));
  Modelica.Electrical.Analog.Sources.SignalCurrent signalCurrent annotation (
      Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=270,
        origin={50,40})));
  Modelica.Blocks.Continuous.FirstOrder  firstOrder(
    k=1,
    T=0.5/fS,
    initType=Modelica.Blocks.Types.Init.InitialState,
    y_start=0)                                     annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60,0})));
  PowerBalance powerBalance(Ti=Ti)
    annotation (Placement(transformation(extent={{10,50},{30,30}})));
  DutyCycle2Voltage dutyCycle2Voltage(fS=fS)
    annotation (Placement(transformation(extent={{30,-10},{10,-30}})));
equation
  if not useHeatPort then
    LossPower = resistor.LossPower;
  end if;
  connect(dc_p1, resistor.p)
    annotation (Line(points={{-100,60},{-100,80}},color={0,0,255}));
  connect(resistor.n, inductor.p)
    annotation (Line(points={{-80,80},{-70,80}}, color={0,0,255}));
  connect(heatPort, resistor.heatPort) annotation (Line(points={{0,-100},{0,-80},
          {-90,-80},{-90,70}}, color={191,0,0}));
  connect(heatPort, heatPort)
    annotation (Line(points={{0,-100},{0,-100}}, color={191,0,0}));
  connect(dc_n1, dc_n2)
    annotation (Line(points={{-100,-60},{100,-60}}, color={0,0,255}));
  connect(inductor.n, multiSensorLV.pc)
    annotation (Line(points={{-50,80},{-40,80}}, color={0,0,255}));
  connect(multiSensorLV.pv, multiSensorLV.pc)
    annotation (Line(points={{-30,90},{-40,90},{-40,80}}, color={0,0,255}));
  connect(dc_n2, multiSensorHV.nv)
    annotation (Line(points={{100,-60},{70,-60},{70,70}}, color={0,0,255}));
  connect(dc_n1, multiSensorLV.nv)
    annotation (Line(points={{-100,-60},{-30,-60},{-30,70}}, color={0,0,255}));
  connect(multiSensorLV.nc, signalVoltage.p)
    annotation (Line(points={{-20,80},{-10,80},{-10,-10}},
                                                  color={0,0,255}));
  connect(dc_n1, signalVoltage.n) annotation (Line(points={{-100,-60},{-10,-60},
          {-10,-30}}, color={0,0,255}));
  connect(firstOrder.y, ILV)
    annotation (Line(points={{-60,-11},{-60,-110}}, color={0,0,127}));
  connect(multiSensorLV.i, firstOrder.u) annotation (Line(points={{-36,69},{-36,
          60},{-60,60},{-60,12}}, color={0,0,127}));
  connect(multiSensorHV.pc, multiSensorHV.pv)
    annotation (Line(points={{60,80},{60,90},{70,90}}, color={0,0,255}));
  connect(multiSensorHV.nc, dc_p2)
    annotation (Line(points={{80,80},{100,80},{100,60}}, color={0,0,255}));
  connect(signalCurrent.n, multiSensorHV.pc)
    annotation (Line(points={{50,50},{50,80},{60,80}}, color={0,0,255}));
  connect(dc_n2, signalCurrent.p)
    annotation (Line(points={{100,-60},{50,-60},{50,30}}, color={0,0,255}));
  connect(multiSensorLV.power, powerBalance.u) annotation (Line(points={{-41,74},
          {-50,74},{-50,40},{8,40}}, color={0,0,127}));
  connect(multiSensorHV.power, powerBalance.u2)
    annotation (Line(points={{59,74},{20,74},{20,52}}, color={0,0,127}));
  connect(powerBalance.y, signalCurrent.i)
    annotation (Line(points={{31,40},{38,40}}, color={0,0,127}));
  connect(dutyCycle2Voltage.y, signalVoltage.v)
    annotation (Line(points={{9,-20},{2,-20}}, color={0,0,127}));
  connect(multiSensorHV.v, dutyCycle2Voltage.v2) annotation (Line(points={{76,69},
          {76,10},{20,10},{20,-8}}, color={0,0,127}));
  connect(dutyCycle2Voltage.u, dutyCycle)
    annotation (Line(points={{32,-20},{60,-20},{60,-120}}, color={0,0,127}));
  annotation (defaultComponentName="dcdc",
    Icon(graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
                   Line(points={{10,0},{0,0},{0,20},{0,-20},{0,-4},{-16,-20},{-10,
              -8},{-4,-14},{-16,-20},{-20,-24},{-20,-60},{-20,-24},{-30,-24},{-30,
              8},{-20,-8},{-40,-8},{-30,8},{-20,8},{-40,8},{-30,8},{-30,24},{-20,
              24},{-20,60},{-20,24},{0,4}},
                                   color={28,108,200}), Line(
          points={{0,-25},{0,-15},{20,-15},{-20,-15},{-4,-15},{-20,1},{-8,-5},{-14,
              -11},{-20,1},{-24,5},{-130,5},{-24,5},{-24,15},{8,15},{-8,5},{-8,25},
              {8,15},{8,5},{8,25},{8,15},{24,15},{24,5},{50,5},{24,5},{4,-15}},
          color={28,108,200},
          origin={40,55},
          rotation=360),
        Rectangle(
          extent={{-70,68},{-30,52}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Line(points={{-90,-60},{90,-60}}, color={28,108,200}),
        Text(
          extent={{-150,148},{150,108}},
          textString="%name",
          textColor={0,0,255})}),
    Documentation(info="<html>
<p>
This is a bidirectional buck / boost - converter with 2 transistors and 2 freewheeling diodes.
</p>
</html>"));
end BuckBoost;
