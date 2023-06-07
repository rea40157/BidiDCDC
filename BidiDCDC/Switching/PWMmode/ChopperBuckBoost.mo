within BiChopper.Switching.PWMmode;
model ChopperBuckBoost "Bidirectional chopper"
  extends Modelica.Electrical.PowerConverters.Interfaces.DCDC.DCtwoPin1;
  extends Modelica.Electrical.PowerConverters.Interfaces.DCDC.DCtwoPin2;
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T=293.15);
  import Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20;
  parameter Modelica.Units.SI.Resistance RonTransistor=1e-05
    "Transistor closed resistance";
  parameter Modelica.Units.SI.Conductance GoffTransistor=1e-05
    "Transistor opened conductance";
  parameter Modelica.Units.SI.Voltage VkneeTransistor=0
    "Transistor threshold voltage";
  parameter Modelica.Units.SI.Resistance RonDiode=1e-05
    "Diode closed resistance";
  parameter Modelica.Units.SI.Conductance GoffDiode=1e-05
    "Diode opened conductance";
  parameter Modelica.Units.SI.Voltage VkneeDiode=0
    "Diode threshold voltage";
  parameter Modelica.Units.SI.Frequency fS=40e3 "Swicthing frequency";
  parameter Modelica.Units.SI.Inductance L=4.7e-6 "Inductance";
  parameter Modelica.Units.SI.Resistance R=1e-3 "Resistance of inductor @TRef";
  parameter Modelica.Units.SI.Temperature TRef=293.15 "Reference temperature";
  parameter LinearTemperatureCoefficient20 alpha20=Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero
    "Temperature coefficient of resistance 20degC";
  parameter Modelica.Units.SI.Capacitance CHV=100e-6 "High voltage capacitance";
  parameter Modelica.Units.SI.Time TDelay=0 "Delay of the Channel";
  parameter Modelica.Units.SI.Time TDelayMeas=0 "Delay of the Measurement";
  Modelica.Units.SI.Current I1(start=0)=dc_p1.i "input current";
  Modelica.Units.SI.Voltage V2(start=0)=dc_p2.v-dc_n2.v "output voltage";
  extends Modelica.Electrical.PowerConverters.Interfaces.Enable.Enable2;
  Modelica.Electrical.Analog.Ideal.IdealGTOThyristor transistorLS(
    useHeatPort=useHeatPort,
    Ron=RonTransistor,
    Goff=GoffTransistor,
    Vknee=VkneeTransistor) "Switching transistor low side" annotation (
      Placement(transformation(
        origin={0,2},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Electrical.Analog.Ideal.IdealDiode diodeLS(
    useHeatPort=useHeatPort,
    Ron=RonDiode,
    Goff=GoffDiode,
    Vknee=VkneeDiode) "Free wheeling diode low side" annotation (Placement(
        transformation(
        origin={20,2},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Electrical.Analog.Ideal.IdealGTOThyristor transistorHS(
    useHeatPort=useHeatPort,
    Ron=RonTransistor,
    Goff=GoffTransistor,
    Vknee=VkneeTransistor) "Switching transistor hugh side" annotation (
      Placement(transformation(
        origin={50,60},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Electrical.Analog.Ideal.IdealDiode diodeHS(
    useHeatPort=useHeatPort,
    Ron=RonDiode,
    Goff=GoffDiode,
    Vknee=VkneeDiode) "Free wheeling diode high side" annotation (Placement(
        transformation(
        origin={50,80},
        extent={{-10,10},{10,-10}},
        rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor resistor(
    R=R,
    T_ref=TRef,
    alpha=alpha20,
    useHeatPort=false)
    annotation (Placement(transformation(extent={{-90,50},{-70,70}})));
  Modelica.Electrical.Analog.Basic.Inductor inductor(i(fixed=false), L=L)
    annotation (Placement(transformation(extent={{-60,50},{-40,70}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-20,60})));
  Modelica.Blocks.Discrete.ZeroOrderHold zeroOrderHold(samplePeriod=0.5/fS,
      startTime=TDelayMeas + 0.5/fS)
               annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-20,30})));
  Modelica.Blocks.Interfaces.RealOutput ILV annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-20,-110})));
  Modelica.Electrical.Analog.Basic.Capacitor capacitorHV(C=CHV) annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={80,0})));
  LogicalDelay logicalDelayLV(delayTime=TDelay) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-60,-30})));
  LogicalDelay logicalDelayHV(delayTime=TDelay) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={60,-30})));
equation
  if not useHeatPort then
    LossPower = diodeLS.LossPower + transistorLS.LossPower
              + diodeHS.LossPower + transistorHS.LossPower;
  end if;
  connect(transistorLS.p, diodeLS.n)
    annotation (Line(points={{0,12},{20,12}},    color={0,0,255}));
  connect(dc_n1, transistorLS.n) annotation (Line(points={{-100,-60},{0,-60},{0,-8}},
                     color={0,0,255}));
  connect(transistorLS.n, diodeLS.p)
    annotation (Line(points={{0,-8},{20,-8}},      color={0,0,255}));
  connect(diodeHS.p, transistorHS.n)
    annotation (Line(points={{40,80},{40,60}}, color={0,0,255}));
  connect(diodeHS.n, transistorHS.p)
    annotation (Line(points={{60,80},{60,60}}, color={0,0,255}));
  connect(transistorHS.p, dc_p2)
    annotation (Line(points={{60,60},{100,60}}, color={0,0,255}));
  connect(dc_n1, dc_n2)
    annotation (Line(points={{-100,-60},{100,-60}}, color={0,0,255}));
  connect(diodeLS.heatPort, heatPort) annotation (Line(points={{30,2},{30,-20},{34,-20},{34,
          -68},{0,-68},{0,-100}},
                             color={191,0,0}));
  connect(transistorLS.heatPort, heatPort) annotation (Line(points={{10,2},{10,-20},{34,-20},
          {34,-68},{0,-68},{0,-100}},
                                  color={191,0,0}));
  connect(diodeHS.heatPort, heatPort)
    annotation (Line(points={{50,90},{34,90},{34,-68},{0,-68},{0,-100}},
                                                       color={191,0,0}));
  connect(transistorHS.heatPort, heatPort)
    annotation (Line(points={{50,70},{34,70},{34,-68},{0,-68},{0,-100}},
                                                       color={191,0,0}));
  connect(dc_p1, resistor.p)
    annotation (Line(points={{-100,60},{-90,60}}, color={0,0,255}));
  connect(inductor.p, resistor.n)
    annotation (Line(points={{-60,60},{-70,60}}, color={0,0,255}));
  connect(inductor.n, currentSensor.p)
    annotation (Line(points={{-40,60},{-30,60}}, color={0,0,255}));
  connect(currentSensor.n, transistorHS.n)
    annotation (Line(points={{-10,60},{40,60}}, color={0,0,255}));
  connect(transistorLS.p, transistorHS.n)
    annotation (Line(points={{0,12},{0,60},{40,60}}, color={0,0,255}));
  connect(currentSensor.i, zeroOrderHold.u)
    annotation (Line(points={{-20,49},{-20,42}},                   color={0,0,127}));
  connect(resistor.heatPort, heatPort)
    annotation (Line(points={{-80,50},{-80,-68},{0,-68},{0,-100}}, color={191,0,0}));
  connect(zeroOrderHold.y, ILV)
    annotation (Line(points={{-20,19},{-20,-110}},                     color={0,0,127}));
  connect(capacitorHV.p, dc_p2)
    annotation (Line(points={{80,10},{80,60},{100,60}}, color={0,0,255}));
  connect(capacitorHV.n, dc_n2)
    annotation (Line(points={{80,-10},{80,-60},{100,-60}}, color={0,0,255}));
  connect(logicalDelayLV.u, andCondition_p.y)
    annotation (Line(points={{-60,-42},{-60,-69}}, color={255,0,255}));
  connect(logicalDelayLV.y, transistorLS.fire)
    annotation (Line(points={{-60,-19},{-60,-8},{-12,-8}}, color={255,0,255}));
  connect(andCondition_n.y, logicalDelayHV.u)
    annotation (Line(points={{60,-69},{60,-42}}, color={255,0,255}));
  connect(logicalDelayHV.y, transistorHS.fire)
    annotation (Line(points={{60,-19},{60,40},{40,40},{40,48}}, color={255,0,255}));
  annotation (defaultComponentName="dcdc",
    Icon(graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
                   Line(points={{10,0},{0,0},{0,20},{0,-20},{0,-4},{-16,-20},{-10,
              -8},{-4,-14},{-16,-20},{-20,-24},{-20,-60},{-20,-24},{-30,-24},{-30,
              8},{-20,-8},{-40,-8},{-30,8},{-20,8},{-40,8},{-30,8},{-30,24},{-20,
              24},{-20,60},{-20,24},{0,4}},
                                   color={217,67,180}), Line(
          points={{0,-25},{0,-15},{20,-15},{-20,-15},{-4,-15},{-20,1},{-8,-5},{-14,
              -11},{-20,1},{-24,5},{-130,5},{-24,5},{-24,15},{8,15},{-8,5},{-8,25},
              {8,15},{8,5},{8,25},{8,15},{24,15},{24,5},{50,5},{24,5},{4,-15}},
          color={217,67,180},
          origin={40,55},
          rotation=360),
        Line(points={{-90,-60},{90,-60}}, color={217,67,180}),
        Text(
          extent={{-150,148},{150,108}},
          textString="%name",
          textColor={0,0,255})}),
    Documentation(info="<html>
<p>
This is a bidirectional buck / boost - converter with 2 transistors and 2 freewheeling diodes.
</p>
</html>"),
    Diagram(graphics={
        Rectangle(extent={{30,92},{64,46}}, lineColor={28,108,200}),
        Text(
          extent={{30,98},{70,92}},
          textColor={28,108,200},
          textString="MosfetHS"),
        Text(
          extent={{-20,3},{20,-3}},
          textColor={28,108,200},
          origin={12,23},
          rotation=180,
          textString="MosfetLS"),
        Rectangle(
          extent={{-17,23},{17,-23}},
          lineColor={28,108,200},
          origin={9,1},
          rotation=90)}));
end ChopperBuckBoost;
