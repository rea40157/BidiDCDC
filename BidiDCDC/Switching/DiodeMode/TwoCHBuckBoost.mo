within BiChopper.Switching.DiodeMode;
model TwoCHBuckBoost

  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T=293.15);
    parameter Boolean UseExtEnable=false "Use external Enable for CH1 and CH2"
  annotation (Dialog(tab="Enable"));
  parameter Boolean EnableCH1
  annotation (Dialog(tab="Enable", enable=not UseExtEnable));
  parameter Boolean EnableCH2
  annotation (Dialog(tab="Enable", enable=not UseExtEnable));
  parameter Modelica.Units.SI.Frequency fS=40e3 "Swicthing frequency";
  parameter Modelica.Units.SI.Inductance L=4.7e-6 "Inductance";
  parameter Modelica.Units.SI.Resistance R=1e-3 "Resistance of inductor @TRef";
  parameter Modelica.Units.SI.Temperature TRef=293.15 "Reference temperature";
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
//  Modelica.Units.SI.Current iLV(start=0)=inductor.i "LV current";
//  Modelica.Units.SI.Voltage vLV(start=0)=capacitorLV.v "LV voltage";
//  Modelica.Units.SI.Voltage vHV(start=0)=capacitorHV.v "HV voltage";
  Modelica.Units.SI.Voltage V1(start=0)=dc_p1.v-dc_n1.v "input voltage";
  Modelica.Units.SI.Voltage Ch1V2(start=0)=CH1.V2 "output voltage CH1";
  Modelica.Units.SI.Voltage Ch2V2(start=0)=CH2.V2 "output voltage CH2";
  Modelica.Units.SI.Current Ch1I1(start=0)=CH1.I1 "input current CH1";
  Modelica.Units.SI.Current Ch2I1(start=0)=CH2.I1 "input current CH2";

  Modelica.Blocks.Nonlinear.Limiter limiter1(uMax=1, uMin=0) annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={80,-80})));
  Modelica.Electrical.Analog.Basic.Capacitor capacitorLV(C=CLV) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,0})));
  Modelica.Electrical.Analog.Interfaces.PositivePin dc_p1
    "Positive DC input"
    annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin dc_n1
    "Negative DC input"
    annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin dc_p2
    "Positive DC output"
    annotation (Placement(transformation(extent={{90,50},{110,70}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin dc_n2
    "Negative DC output"
    annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
  Modelica.Blocks.Interfaces.RealInput dutyCycleCH1 annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={80,-120})));
  Modelica.Blocks.Interfaces.RealOutput ILVCH1 "Sampled low voltage current" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,-110})));
  Modelica.Blocks.Interfaces.BooleanInput Direction "0=boost; 1=buck" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120})));
  CHBuckBoost CH1(
    UseExtEnable=UseExtEnable,
    EnableCH=EnableCH1,
    fS=fS,
    L=L,
    R=R,
    TRef=TRef,
    CLV=CLV,
    CHV=CHV) annotation (Placement(transformation(extent={{-10,44},{10,64}})));
  CHBuckBoost CH2(
    UseExtEnable=UseExtEnable,
    EnableCH=EnableCH2,
    fS=fS,
    L=L,
    R=R,
    TRef=TRef,
    CLV=CLV,
    CHV=CHV,
    startTime=0.5/fS)
             annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={0,-40})));
  Modelica.Blocks.Interfaces.RealOutput ILVCH2 "Sampled low voltage current" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-40,-110})));
  Modelica.Blocks.Interfaces.RealInput dutyCycleCH2 annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={40,-120})));
  Modelica.Blocks.Nonlinear.Limiter limiter2(uMax=1, uMin=0)
                                                            annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={40,-80})));
  Modelica.Blocks.Interfaces.BooleanInput CH1Enable if  UseExtEnable annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-40,120})));
  Modelica.Blocks.Interfaces.BooleanInput CH2Enable if  UseExtEnable annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={40,120})));
equation
  if not useHeatPort then
    LossPower = CH1.LossPower+CH2.LossPower;
  end if;
  connect(dutyCycleCH1, limiter1.u)
    annotation (Line(points={{80,-120},{80,-92}}, color={0,0,127}));
  connect(dc_p1,capacitorLV. p)
    annotation (Line(points={{-100,60},{-80,60},{-80,10}}, color={0,0,255}));
  connect(dc_n1,capacitorLV. n) annotation (Line(points={{-100,-60},{-80,-60},{-80,
          -10}}, color={0,0,255}));
  connect(CH1.dc_p1, capacitorLV.p)
    annotation (Line(points={{-10,60},{-80,60},{-80,10}}, color={0,0,255}));
  connect(CH1.dc_p2, dc_p2) annotation (Line(points={{10,60},{100,60}}, color={0,0,255}));
  connect(CH1.dc_n1, capacitorLV.n) annotation (Line(points={{-10,48},{-60,48},{-60,-60},{-80,
          -60},{-80,-10}}, color={0,0,255}));
  connect(dc_n2, capacitorLV.n)
    annotation (Line(points={{100,-60},{-80,-60},{-80,-10}}, color={0,0,255}));
  connect(limiter1.y, CH1.dutyCycle)
    annotation (Line(points={{80,-69},{80,30},{-2,30},{-2,42}}, color={0,0,127}));
  connect(CH2.dc_p1, capacitorLV.p) annotation (Line(points={{-10,-34},{-32,-34},{-32,60},{
          -80,60},{-80,10}}, color={0,0,255}));
  connect(CH2.dc_n1, capacitorLV.n) annotation (Line(points={{-10,-46},{-32,-46},{-32,-60},
          {-80,-60},{-80,-10}}, color={0,0,255}));
  connect(CH2.dc_p2, dc_p2)
    annotation (Line(points={{10,-34},{20,-34},{20,60},{100,60}}, color={0,0,255}));
  connect(CH2.ILV, ILVCH2)
    annotation (Line(points={{-6,-51},{-6,-80},{-40,-80},{-40,-110}}, color={0,0,127}));
  connect(CH1.ILV, ILVCH1) annotation (Line(points={{-6,43},{-6,0},{-48,0},{-48,-80},{-80,-80},
          {-80,-110}},                color={0,0,127}));
  connect(dutyCycleCH2,limiter2. u)
    annotation (Line(points={{40,-120},{40,-92}}, color={0,0,127}));
  connect(limiter2.y, CH2.dutyCycle)
    annotation (Line(points={{40,-69},{40,-56},{-2,-56},{-2,-52}},
                                                          color={0,0,127}));
  connect(CH2.Direction, Direction)
    annotation (Line(points={{6,-52},{6,-80},{0,-80},{0,-120}}, color={255,0,255}));
  connect(CH1.Direction, Direction) annotation (Line(points={{6,42},{6,20},{24,20},{24,-80},
          {0,-80},{0,-120}}, color={255,0,255}));
  connect(CH1.EnableCh, CH1Enable)
    annotation (Line(points={{-4,66},{-4,84},{-40,84},{-40,120}}, color={255,0,255}));
  connect(CH2.EnableCh, CH2Enable)
    annotation (Line(points={{-4,-28},{-4,-20},{40,-20},{40,120}}, color={255,0,255}));
  annotation (defaultComponentName="dcdc", Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Line(points={{-100,100},{100,100}}, color={28,108,200}),
        Rectangle(extent={{-100,100},{100,-100}}, lineColor={28,108,200}),
        Rectangle(
          extent={{-74,68},{-34,52}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
                   Line(points={{6,0},{-4,0},{-4,20},{-4,-20},{-4,-4},{-20,-20},
              {-14,-8},{-8,-14},{-20,-20},{-24,-24},{-24,-60},{-24,-24},{-34,
              -24},{-34,8},{-24,-8},{-44,-8},{-34,8},{-24,8},{-44,8},{-34,8},{
              -34,24},{-24,24},{-24,60},{-24,24},{-4,4}},
                                   color={238,46,47}),  Line(
          points={{0,-25},{0,-15},{20,-15},{-20,-15},{-4,-15},{-20,1},{-8,-5},{
              -14,-11},{-20,1},{-24,5},{-70,5},{-24,5},{-24,15},{8,15},{-8,5},{
              -8,25},{8,15},{8,5},{8,25},{8,15},{24,15},{24,5},{54,5},{24,5},{4,
              -15}},
          color={238,46,47},
          origin={36,55},
          rotation=360),
        Line(points={{-74,60},{-92,60}}, color={238,46,47}),
        Line(points={{-90,-60},{90,-60}}, color={238,46,47}),
        Text(
          extent={{-64,136},{66,102}},
          textColor={28,108,200},
          textString="%name")}),                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end TwoCHBuckBoost;
