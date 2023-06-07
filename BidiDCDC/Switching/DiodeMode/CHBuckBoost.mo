within BiChopper.Switching.DiodeMode;
model CHBuckBoost "Compact model for one Channel"
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T=293.15);
  parameter Boolean UseExtEnable "Use external Enable for CH1 and CH2"
  annotation (Dialog(tab="Enable"));
  parameter Boolean EnableCH
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
    parameter Modelica.Units.SI.Time startTime=0 "start Time for the sampler";
  Modelica.Units.SI.Current I1(start=0)=dc_p1.i "input current";
  Modelica.Units.SI.Voltage V2(start=0)=dc_p2.v-dc_n2.v "output voltage";

  Modelica.Electrical.Analog.Interfaces.PositivePin dc_p1
    "Positive DC input"
    annotation (Placement(transformation(extent={{-110,50},{-90,70}}), iconTransformation(
          extent={{-110,50},{-90,70}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin dc_n1
    "Negative DC input"
    annotation (Placement(transformation(extent={{-110,-70},{-90,-50}}),
        iconTransformation(extent={{-110,-70},{-90,-50}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin dc_p2
    "Positive DC output"
    annotation (Placement(transformation(extent={{90,50},{110,70}}), iconTransformation(
          extent={{90,50},{110,70}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin dc_n2
    "Negative DC output"
    annotation (Placement(transformation(extent={{90,-70},{110,-50}}), iconTransformation(
          extent={{90,-70},{110,-50}})));
  Modelica.Blocks.Interfaces.RealInput dutyCycle annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-20,-120}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-20,-120})));
  Modelica.Blocks.Interfaces.RealOutput ILV "Sampled low voltage current"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60,-110}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60,-110})));
  Modelica.Blocks.Interfaces.BooleanInput Direction "0=boost; 1=buck" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={60,-120}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={60,-120})));
  ChopperBuckBoost         dcdc(
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
    CHV=CHV,
    useConstantEnable=not UseExtEnable,
    constantEnable=EnableCH)
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  DiodeModeGen diodeModeGen(fS=fS, startTime=startTime)
                            annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-40})));
  Modelica.Blocks.Interfaces.BooleanInput EnableCh if  UseExtEnable annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-40,120})));
  Modelica.Blocks.Discrete.ZeroOrderHold zeroOrderHold(samplePeriod=0.5/fS,
      startTime=0.5/fS)
               annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60,-70})));
  Modelica.Blocks.Discrete.ZeroOrderHold zeroOrderHold1(samplePeriod=0.01/fS)
               annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-32,-10})));
equation
  if not useHeatPort then
    LossPower = dcdc.LossPower;
  end if;

  connect(diodeModeGen.fireLV, dcdc.fire_p)
    annotation (Line(points={{-6,-29},{-6,28}}, color={255,0,255}));
  connect(diodeModeGen.fireHV, dcdc.fire_n)
    annotation (Line(points={{6,-29},{6,28}}, color={255,0,255}));
  connect(dutyCycle, diodeModeGen.dutyCycle)
    annotation (Line(points={{-20,-120},{-20,-60},{-4,-60},{-4,-52}}, color={0,0,127}));
  connect(diodeModeGen.Direction, Direction)
    annotation (Line(points={{4,-52},{4,-60},{60,-60},{60,-120}}, color={255,0,255}));
  connect(dc_n1, dcdc.dc_n1)
    annotation (Line(points={{-100,-60},{-80,-60},{-80,34},{-10,34}}, color={0,0,255}));
  connect(dcdc.dc_p1, dc_p1)
    annotation (Line(points={{-10,46},{-80,46},{-80,60},{-100,60}}, color={0,0,255}));
  connect(dcdc.dc_p2, dc_p2)
    annotation (Line(points={{10,46},{80,46},{80,60},{100,60}}, color={0,0,255}));
  connect(dcdc.dc_n2, dc_n2)
    annotation (Line(points={{10,34},{80,34},{80,-60},{100,-60}}, color={0,0,255}));
  connect(dcdc.enable, EnableCh)
    annotation (Line(points={{10,28},{10,24},{-40,24},{-40,120}},
                                                           color={255,0,255}));
  connect(dcdc.ILV, zeroOrderHold.u) annotation (Line(points={{-2,29},{-2,16},{
          -60,16},{-60,-58}},                     color={0,0,127}));
  connect(zeroOrderHold.y, ILV)
    annotation (Line(points={{-60,-81},{-60,-110}}, color={0,0,127}));
  connect(dcdc.ILV, zeroOrderHold1.u) annotation (Line(points={{-2,29},{-2,16},
          {-32,16},{-32,2}}, color={0,0,127}));
  connect(zeroOrderHold1.y, diodeModeGen.current)
    annotation (Line(points={{-32,-21},{-32,-40},{-12,-40}}, color={0,0,127}));
                             annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={100,-120}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={100,-120})),
              Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Line(points={{-100,100},{100,100}}, color={28,108,200}),
        Rectangle(extent={{-100,100},{100,-100}}, lineColor={28,108,200}),
        Rectangle(
          extent={{-74,68},{-34,52}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
                   Line(points={{6,0},{-4,0},{-4,20},{-4,-20},{-4,-4},{-20,-20},{-14,-8},{-8,
              -14},{-20,-20},{-24,-24},{-24,-60},{-24,-24},{-34,-24},{-34,8},{-24,-8},{-44,
              -8},{-34,8},{-24,8},{-44,8},{-34,8},{-34,24},{-24,24},{-24,60},{-24,24},{-4,4}},
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
          textString="%name")}), Diagram(coordinateSystem(preserveAspectRatio=false)));
end CHBuckBoost;
