within BiChopper.Switching.PWMmode;
model TwoCHBuckBoost "Bidirectional chopper"
  extends Modelica.Electrical.PowerConverters.Interfaces.DCDC.DCtwoPin1;
  extends Modelica.Electrical.PowerConverters.Interfaces.DCDC.DCtwoPin2;
  parameter Boolean UseExtEnable "Use external Enable for CH1 and CH2"
  annotation (Dialog(tab="Enable"));
  parameter Boolean EnableCH1
  annotation (Dialog(tab="Enable", enable=not UseExtEnable));
  parameter Boolean EnableCH2
  annotation (Dialog(tab="Enable", enable=not UseExtEnable));
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T=293.15);
  import Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20;
  import BiChopper.Switching.PWMmode.SingleReferenceType;
  parameter Modelica.Units.SI.Frequency fS=40e3 "Swicthing frequency";
  parameter Modelica.Units.SI.Inductance L=4.7e-6 "Inductance";
  parameter Modelica.Units.SI.Resistance R=1e-3 "Resistance of inductor @TRef";
  parameter Modelica.Units.SI.Temperature TRef=293.15 "Reference temperature";
  parameter LinearTemperatureCoefficient20 alpha20=Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero
    "Temperature coefficient of resistance 20degC";
  parameter Modelica.Units.SI.Capacitance CLV=470e-6 "Low voltage capacitance";
  parameter Modelica.Units.SI.Capacitance CHV=100e-6 "High voltage capacitance";
  parameter Modelica.Units.SI.Resistance RonTransistor=1e-05
    "Transistor closed resistance"
    annotation(Dialog(tab="Semiconductors"));
  parameter Modelica.Units.SI.Conductance GoffTransistor=1e-05
    "Transistor opened conductance"
    annotation(Dialog(tab="Semiconductors"));
  parameter Modelica.Units.SI.Voltage VkneeTransistor=0
    "Transistor threshold voltage"
    annotation(Dialog(tab="Semiconductors"));
  parameter Modelica.Units.SI.Resistance RonDiode=1e-05
    "Diode closed resistance"
    annotation(Dialog(tab="Semiconductors"));
  parameter Modelica.Units.SI.Conductance GoffDiode=1e-05
    "Diode opened conductance"
    annotation(Dialog(tab="Semiconductors"));
  parameter Modelica.Units.SI.Voltage VkneeDiode=0
    "Diode threshold voltage"
    annotation(Dialog(tab="Semiconductors"));
  Modelica.Units.SI.Voltage V1(start=0)=dc_p1.v-dc_n1.v "input voltage";
  Modelica.Units.SI.Voltage Ch1V2(start=0)=CH1.V2 "output voltage CH1";
  Modelica.Units.SI.Voltage Ch2V2(start=0)=CH2.V2 "output voltage CH2";
  Modelica.Units.SI.Current Ch1I1(start=0)=CH1.I1 "input current CH1";
  Modelica.Units.SI.Current Ch2I1(start=0)=CH2.I1 "input current CH2";

  Modelica.Blocks.Interfaces.RealInput dutyCycleCH1 annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={80,-120})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=1, uMin=0) annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={80,-78})));
  PWMmode.ChopperBuckBoost CH1(
    useHeatPort=false,
    RonTransistor=RonTransistor,
    GoffTransistor=GoffTransistor,
    VkneeTransistor=VkneeTransistor,
    RonDiode=RonDiode,
    GoffDiode=GoffDiode,
    VkneeDiode=VkneeDiode,
    fS=fS,
    L=L,
    R=R,
    TRef=TRef,
    CHV=CHV,
    TDelay=0,
    TDelayMeas=0,
    useConstantEnable=not UseExtEnable,
    constantEnable=EnableCH1,
    zeroOrderHold)
    annotation (Placement(transformation(extent={{-10,32},{10,52}})));
  Modelica.Electrical.Analog.Basic.Capacitor capacitorLV(v(start=0),
                                                         C=CLV) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-90,0})));

  PWMmode.SignalPWM pwmCH1(useConstantDutyCycle=false, f=fS) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={50,10})));
  ChopperBuckBoost CH2(
    useHeatPort=false,
    RonTransistor=RonTransistor,
    GoffTransistor=GoffTransistor,
    VkneeTransistor=VkneeTransistor,
    RonDiode=RonDiode,
    GoffDiode=GoffDiode,
    VkneeDiode=VkneeDiode,
    fS=fS,
    L=L,
    R=R,
    TRef=TRef,
    CHV=CHV,
    TDelay=0,
    TDelayMeas=0.5/fS,
    useConstantEnable=not UseExtEnable,
    constantEnable=EnableCH2)
    annotation (Placement(transformation(extent={{-10,-30},{10,-50}})));
  Modelica.Blocks.Interfaces.RealOutput ILVCH1 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,-110})));
  SignalPWM pwmCH2(
    useConstantDutyCycle=false,
    f=fS,
    startTime=0.5/fS) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={50,-10})));
  Modelica.Blocks.Interfaces.RealOutput ILVCH2 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-40,-110})));
  Modelica.Blocks.Interfaces.RealInput dutyCycleCH2 annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={40,-120})));
  Modelica.Blocks.Nonlinear.Limiter limiter1(uMax=1, uMin=0)
                                                            annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={40,-78})));
  Modelica.Blocks.Interfaces.BooleanInput CH1Enable if UseExtEnable annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-40,120})));
  Modelica.Blocks.Interfaces.BooleanInput CH2Enable if UseExtEnable annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={40,120})));
equation
  if not useHeatPort then
     LossPower = CH1.LossPower;
  end if;
  connect(dutyCycleCH1, limiter.u)
    annotation (Line(points={{80,-120},{80,-90}},          color={0,0,127}));
  connect(dc_p1, capacitorLV.p)
    annotation (Line(points={{-100,60},{-90,60},{-90,10}}, color={0,0,255}));
  connect(dc_n1, capacitorLV.n) annotation (Line(points={{-100,-60},{-90,-60},{
          -90,-10}},
                 color={0,0,255}));
  connect(CH1.heatPort, heatPort) annotation (Line(points={{0,32},{0,12},{-60,
          12},{-60,-80},{0,-80},{0,-100}},
                             color={191,0,0}));
  connect(dc_n1, CH1.dc_n1)
    annotation (Line(points={{-100,-60},{-20,-60},{-20,36},{-10,36}}, color={0,0,255}));
  connect(CH1.dc_p2, dc_p2)
    annotation (Line(points={{10,48},{30,48},{30,60},{100,60}}, color={0,0,255}));
  connect(heatPort, heatPort)
    annotation (Line(points={{0,-100},{0,-100}}, color={191,0,0}));
  connect(CH2.heatPort, heatPort) annotation (Line(points={{0,-30},{0,-14},{-60,
          -14},{-60,-80},{0,-80},{0,-100}},
                             color={191,0,0}));
  connect(CH2.dc_p2, dc_p2)
    annotation (Line(points={{10,-46},{30,-46},{30,60},{100,60}}, color={0,0,255}));
  connect(CH2.dc_n1, CH1.dc_n1)
    annotation (Line(points={{-10,-34},{-20,-34},{-20,36},{-10,36}}, color={0,0,255}));
  connect(CH1.fire_p, pwmCH1.fire)
    annotation (Line(points={{-6,30},{-6,4},{39,4}}, color={255,0,255}));
  connect(pwmCH1.notFire, CH1.fire_n)
    annotation (Line(points={{39,16},{6,16},{6,30}}, color={255,0,255}));
  connect(CH2.fire_p, pwmCH2.fire)
    annotation (Line(points={{-6,-28},{-6,-4},{39,-4}}, color={255,0,255}));
  connect(CH2.fire_n, pwmCH2.notFire)
    annotation (Line(points={{6,-28},{6,-16},{39,-16}}, color={255,0,255}));
  connect(limiter.y, pwmCH1.dutyCycle) annotation (Line(points={{80,-67},{80,10},
          {62,10}},         color={0,0,127}));
  connect(CH1.dc_n2, dc_n2)
    annotation (Line(points={{10,36},{20,36},{20,-60},{100,-60}}, color={0,0,255}));
  connect(CH2.dc_p1, capacitorLV.p) annotation (Line(points={{-10,-46},{-32,-46},
          {-32,48},{-90,48},{-90,10}},
                              color={0,0,255}));
  connect(CH1.dc_p1, capacitorLV.p) annotation (Line(points={{-10,48},{-90,48},
          {-90,10}},         color={0,0,255}));
  connect(CH1.ILV, ILVCH1) annotation (Line(points={{-2,31},{-2,6},{-80,6},{-80,
          -110}},           color={0,0,127}));
  connect(CH2.ILV, ILVCH2) annotation (Line(points={{-2,-29},{-2,-12},{-40,-12},
          {-40,-110}},           color={0,0,127}));
  connect(pwmCH2.dutyCycle, limiter1.y) annotation (Line(points={{62,-10},{70,
          -10},{70,-52},{40,-52},{40,-67}},
                              color={0,0,127}));
  connect(limiter1.u, dutyCycleCH2)
    annotation (Line(points={{40,-90},{40,-120}}, color={0,0,127}));
  connect(CH1Enable, CH1.enable) annotation (Line(points={{-40,120},{-40,80},{
          16,80},{16,26},{10,26},{10,30}},
                        color={255,0,255}));
  connect(CH2Enable, CH2.enable)
    annotation (Line(points={{40,120},{32,120},{32,90},{24,90},{24,-24},{10,-24},
          {10,-28}},                                               color={255,0,255}));
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
                                   color={217,67,180}), Line(
          points={{0,-25},{0,-15},{20,-15},{-20,-15},{-4,-15},{-20,1},{-8,-5},{-14,
              -11},{-20,1},{-24,5},{-130,5},{-24,5},{-24,15},{8,15},{-8,5},{-8,25},
              {8,15},{8,5},{8,25},{8,15},{24,15},{24,5},{50,5},{24,5},{4,-15}},
          color={217,67,180},
          origin={40,55},
          rotation=360),
        Rectangle(
          extent={{-70,68},{-30,52}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Line(points={{-90,-60},{90,-60}}, color={217,67,180}),
        Text(
          extent={{-150,148},{150,108}},
          textString="%name",
          textColor={0,0,255})}),
    Documentation(info="<html>
<p>
This is a bidirectional buck / boost - converter with 2 transistors and 2 freewheeling diodes.
</p>
</html>"));
end TwoCHBuckBoost;
