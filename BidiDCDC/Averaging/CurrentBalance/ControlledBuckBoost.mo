within BiChopper.Averaging.CurrentBalance;
model ControlledBuckBoost "Controlled averaging BiChopper"
  extends PartialControlledBuckBoost;
  import Modelica.Units.SI;
  constant String mode="Averaging";
//  initialization
  parameter Modelica.Units.SI.Current Ch1I10=0 "Initial input current CH1"
    annotation(Dialog(group="Initialization", enable=EnableCH1));
  parameter Boolean Ch1I1Fixed=false "Fixed initial input current CH1"
    annotation(Dialog(group="Initialization", enable=EnableCH1), choices(checkBox=true));
  parameter Modelica.Units.SI.Current Ch2I10=0 "Initial input current CH2"
    annotation(Dialog(group="Initialization", enable=EnableCH2));
  parameter Boolean Ch2I1Fixed=false "Fixed initial input current CH2"
    annotation(Dialog(group="Initialization", enable=EnableCH2), choices(checkBox=true));
  Modelica.Units.SI.Voltage vLV=pin_pLV.v - pin_nLV.v "LV voltage";
  Modelica.Units.SI.Current iLV=pin_pLV.i "LV current";
  Modelica.Units.SI.Power powerLV=vLV*iLV "LV power";
  Modelica.Units.SI.Voltage vHV=pin_pHV.v - pin_nHV.v "HV voltage";
  Modelica.Units.SI.Current iHV=pin_pHV.i "HV current";
  Modelica.Units.SI.Power powerHV=vHV*iHV "HV power";
  /*
  Modelica.Blocks.Sources.RealExpression mean_vLV(y=pin_pLV.v)
    annotation (Placement(transformation(extent={{-80,78},{-60,100}})));
  Modelica.Blocks.Sources.RealExpression mean_iLV(y=pin_pLV.i)
    annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
  Modelica.Blocks.Sources.RealExpression mean_pLV(y=pin_pLV.v*pin_pLV.i)
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Modelica.Blocks.Sources.RealExpression mean_vHV(y=pin_pHV.v)
    annotation (Placement(transformation(extent={{80,80},{60,100}})));
  Modelica.Blocks.Sources.RealExpression mean_iHV(y=pin_pHV.i)
    annotation (Placement(transformation(extent={{80,50},{60,70}})));
  Modelica.Blocks.Sources.RealExpression mean_pHV(y=pin_pHV.v*pin_pHV.i)
    annotation (Placement(transformation(extent={{80,20},{60,40}})));
  */
  BuckBoostReiter CH1(
    iDC1(start=Ch1I10, fixed=Ch1I1Fixed),
    fS=BiChopperData.fS,
    L=BiChopperData.L,
    R=BiChopperData.R,
    TRef=BiChopperData.TRef,
    alpha20=BiChopperData.alpha20,
    RonTransistor=BiChopperData.RonTransistor) if EnableCH1
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  BuckBoostReiter CH2(
    iDC1(start=Ch2I10, fixed=Ch2I1Fixed),
    fS=BiChopperData.fS,
    L=BiChopperData.L,
    R=BiChopperData.R,
    TRef=BiChopperData.TRef,
    alpha20=BiChopperData.alpha20,
    RonTransistor=BiChopperData.RonTransistor) if EnableCH2
    annotation (Placement(transformation(extent={{-58,70},{-38,90}})));
  Controller.Controller controllerCH1(VLV=BiChopperData.VLV, VHV=BiChopperData.VHV,
    k=BiChopperData.kAverage,
    Ti=BiChopperData.TiAverage,
    wp=BiChopperData.wpAverage) if EnableCH1
    annotation (Placement(transformation(extent={{-16,-40},{4,-20}})));
  Controller.Controller controllerCH2(VLV=BiChopperData.VLV, VHV=BiChopperData.VHV,
    k=BiChopperData.kAverage,
    Ti=BiChopperData.TiAverage,
    wp=BiChopperData.wpAverage) if EnableCH2
    annotation (Placement(transformation(extent={{-64,38},{-44,58}})));
  CHCompensation cHCompensation
    annotation (Placement(transformation(extent={{50,-90},{70,-70}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant[2](k={EnableCH1, EnableCH2})
    annotation (Placement(transformation(extent={{12,-90},{32,-70}})));
  Modelica.Electrical.Analog.Ideal.Idle idle
    annotation (Placement(transformation(extent={{70,10},{90,30}})));
equation
  connect(CH1.ILV, controllerCH1.measuredCurrent)
    annotation (Line(points={{-6,-11},{-6,-18}}, color={0,0,127}));
  connect(controllerCH1.y, CH1.dutyCycle)
    annotation (Line(points={{5,-30},{6,-30},{6,-12}}, color={0,0,127}));
  connect(controllerCH1.DirectionPin, DirectionPin)
    annotation (Line(points={{-12,-42},{-12,-50},{-60,-50},{-60,-120}}, color={0,0,127}));
  connect(CH1.dc_n1, pin_nLV)
    annotation (Line(points={{-10,-6},{-100,-6},{-100,-60}},color={0,0,255}));
  connect(CH1.dc_p2, pin_pHV)
    annotation (Line(points={{10,6},{100,6},{100,60}}, color={0,0,255}));
  connect(CH2.ILV, controllerCH2.measuredCurrent)
    annotation (Line(points={{-54,69},{-54,60}},
                                               color={0,0,127}));
  connect(CH2.dutyCycle, controllerCH2.y)
    annotation (Line(points={{-42,68},{-42,48},{-43,48}},
                                                    color={0,0,127}));
  connect(CH2.dc_n1, pin_nLV) annotation (Line(points={{-58,74},{-80,74},{-80,
          -6},{-100,-6},{-100,-60}},
                       color={0,0,255}));
  connect(CH2.dc_p2, pin_pHV)
    annotation (Line(points={{-38,86},{100,86},{100,60}},              color={0,0,255}));
  connect(ISETA, cHCompensation.u2)
    annotation (Line(points={{60,-120},{60,-92}}, color={0,0,127}));
  connect(cHCompensation.y, controllerCH1.DutyCycle)
    annotation (Line(points={{60,-69},{60,-50},{0,-50},{0,-42}}, color={0,0,127}));
  connect(booleanConstant[2].y, cHCompensation.EnableCH2)
    annotation (Line(points={{33,-80},{40,-80},{40,-86},{48,-86}},
                                                 color={255,0,255}));
  connect(booleanConstant[1].y, cHCompensation.EnableCH1) annotation (Line(
        points={{33,-80},{40,-80},{40,-74},{48,-74}}, color={255,0,255}));
  connect(DirectionPin, controllerCH2.DirectionPin) annotation (Line(points={{-60,
          -120},{-60,36}},                                           color={0,0,
          127}));
  connect(cHCompensation.y, controllerCH2.DutyCycle) annotation (Line(points={{60,-69},
          {60,30},{-48,30},{-48,36}},                       color={0,0,127}));
  connect(pin_nLV, pin_nHV)
    annotation (Line(points={{-100,-60},{100,-60}}, color={0,0,255}));
  connect(idle.n, pin_pHV)
    annotation (Line(points={{90,20},{100,20},{100,60}}, color={0,0,255}));
  connect(pin_pLV, CH1.dc_p1)
    annotation (Line(points={{-100,60},{-100,6},{-10,6}}, color={0,0,255}));
  connect(pin_pLV, idle.p)
    annotation (Line(points={{-100,60},{-100,20},{70,20}}, color={0,0,255}));
  connect(pin_pLV, CH2.dc_p1) annotation (Line(points={{-100,60},{-100,86},{-58,
          86}},               color={0,0,255}));
  annotation (defaultComponentName="dcdc", Icon(graphics={                           Line(
          points={{0,-25},{0,-15},{20,-15},{-20,-15},{-4,-15},{-20,1},{-8,-5},{-14,
              -11},{-20,1},{-24,5},{-130,5},{-24,5},{-24,15},{8,15},{-8,5},{-8,25},
              {8,15},{8,5},{8,25},{8,15},{24,15},{24,5},{50,5},{24,5},{4,-15}},
          color={28,108,200},
          origin={40,55},
          rotation=360),
                   Line(points={{10,0},{0,0},{0,20},{0,-20},{0,-4},{-16,-20},{-10,
              -8},{-4,-14},{-16,-20},{-20,-24},{-20,-60},{-20,-24},{-30,-24},{-30,8},
              {-20,-8},{-40,-8},{-30,8},{-20,8},{-40,8},{-30,8},{-30,24},{-20,24},{
              -20,60},{-20,24},{0,4}},
                                   color={28,108,200}),
        Line(points={{-94,-60},{94,-60},{92,-60}}, color={28,108,200}),
        Rectangle(extent={{28,4},{80,-36}}, lineColor={0,0,0}),
        Text(
          extent={{30,0},{76,-32}},
          textColor={0,0,0},
          textString="PI"),
        Line(points={{-60,-112},{-60,-80},{38,-80},{38,-36}}, color={0,0,0}),
        Polygon(
          points={{38,-36},{34,-46},{34,-46},{42,-46},{38,-36}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{68,-36},{64,-46},{64,-46},{72,-46},{68,-36}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(points={{60,-114},{60,-80}}, color={0,0,0}),
        Line(points={{60,-80},{62,-80},{68,-80},{68,-44}}, color={0,0,0}),
        Line(points={{54,4},{54,18},{40,18},{40,30}}, color={0,0,0})}));
end ControlledBuckBoost;
