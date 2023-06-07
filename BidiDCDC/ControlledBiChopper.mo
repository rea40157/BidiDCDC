within BiChopper;
model ControlledBiChopper
  "Contains three choosable variants of the BiChopper"
  parameter BiChopper.ChooseComponent chooseComponent=ChooseComponent.Averaging
    annotation (Dialog(group="Auswahl Betriebsmodus"));
  parameter Boolean EnableCH1=true
  annotation (Dialog(group="Enable"), choices(checkBox=true));
  parameter Boolean EnableCH2=true
  annotation (Dialog(group="Enable"), choices(checkBox=true));

  Switching.PWMmode.ControlledBuckBoost dcdcPWM(
    BiChopperData=BiChopperData,                UseExtEnable=false,
    EnableCH1=EnableCH1,
    EnableCH2=EnableCH2) if chooseComponent == ChooseComponent.PWMMode
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  Averaging.CurrentBalance.ControlledBuckBoost dcdcAvg(
    BiChopperData=BiChopperData,                       EnableCH1=EnableCH1,
      EnableCH2=EnableCH2) if chooseComponent == ChooseComponent.Averaging
    annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
  Modelica.Blocks.Interfaces.RealInput DirectionPin "<1V=boost mode; >2V=buck mode"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-60,-120}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-60,-120})));
  Modelica.Blocks.Interfaces.RealInput ISETA "1Vin=20A" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={60,-120}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={60,-120})));
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_pLV
    annotation (Placement(transformation(extent={{-110,50},{-90,70}}),
        iconTransformation(extent={{-110,50},{-90,70}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_pHV
    annotation (Placement(transformation(extent={{90,50},{110,70}}),
        iconTransformation(extent={{90,50},{110,70}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_nLV
    annotation (Placement(transformation(extent={{-110,-70},{-90,-50}}),
        iconTransformation(extent={{-110,-70},{-90,-50}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_nHV
    annotation (Placement(transformation(extent={{90,-70},{110,-50}}),
        iconTransformation(extent={{90,-70},{110,-50}})));
  Switching.DiodeMode.ControlledBuckBoost dcdcDiodeMode(
    BiChopperData=BiChopperData,
    UseExtEnable=false,
    EnableCH1=EnableCH1,
    EnableCH2=EnableCH2) if chooseComponent == ChooseComponent.DiodeEmulatedMode
    annotation (Placement(transformation(extent={{-10,0},{10,20}})));
  parameter ParameterRecords.BiChopper BiChopperData
    annotation (choicesAllMatching=true, Placement(transformation(extent={{-10,72},{10,92}})));
equation
  connect(pin_pLV, dcdcPWM.pin_pLV) annotation (Line(points={{-100,60},{-40,60},
          {-40,56},{-10,56}}, color={0,0,255}));
  connect(pin_pLV, dcdcAvg.pin_pLV) annotation (Line(points={{-100,60},{-40,60},
          {-40,-24},{-10,-24}}, color={0,0,255}));
  connect(pin_nLV, dcdcAvg.pin_nLV) annotation (Line(points={{-100,-60},{-80,
          -60},{-80,-36},{-10,-36}}, color={0,0,255}));
  connect(pin_nLV, dcdcPWM.pin_nLV) annotation (Line(points={{-100,-60},{-80,
          -60},{-80,44},{-10,44}}, color={0,0,255}));
  connect(pin_pHV, dcdcPWM.pin_pHV) annotation (Line(points={{100,60},{40,60},{
          40,56},{10,56}}, color={0,0,255}));
  connect(pin_pHV, dcdcAvg.pin_pHV) annotation (Line(points={{100,60},{40,60},{
          40,-24},{10,-24}}, color={0,0,255}));
  connect(pin_nHV, dcdcAvg.pin_nHV) annotation (Line(points={{100,-60},{80,-60},
          {80,-36},{10,-36}}, color={0,0,255}));
  connect(pin_nHV, dcdcPWM.pin_nHV) annotation (Line(points={{100,-60},{80,-60},
          {80,44},{10,44}}, color={0,0,255}));
  connect(DirectionPin, dcdcPWM.DirectionPin) annotation (Line(points={{-60,
          -120},{-60,32},{-6,32},{-6,38}}, color={0,0,127}));
  connect(DirectionPin, dcdcAvg.DirectionPin) annotation (Line(points={{-60,
          -120},{-60,-48},{-6,-48},{-6,-42}}, color={0,0,127}));
  connect(ISETA, dcdcAvg.ISETA) annotation (Line(points={{60,-120},{60,-48},{6,
          -48},{6,-42}}, color={0,0,127}));
  connect(ISETA, dcdcPWM.ISETA) annotation (Line(points={{60,-120},{60,32},{6,
          32},{6,38}}, color={0,0,127}));
  connect(dcdcDiodeMode.pin_pLV, pin_pLV) annotation (Line(points={{-10,16},{-40,
          16},{-40,60},{-100,60}}, color={0,0,255}));
  connect(dcdcDiodeMode.pin_nLV, pin_nLV) annotation (Line(points={{-10,4},{-80,
          4},{-80,-60},{-100,-60}}, color={0,0,255}));
  connect(dcdcDiodeMode.pin_pHV, pin_pHV) annotation (Line(points={{10,16},{40,16},
          {40,60},{100,60}}, color={0,0,255}));
  connect(dcdcDiodeMode.pin_nHV, pin_nHV) annotation (Line(points={{10,4},{80,4},
          {80,-60},{100,-60}}, color={0,0,255}));
  connect(dcdcDiodeMode.DirectionPin, DirectionPin) annotation (Line(points={{-6,
          -2},{-6,-8},{-60,-8},{-60,-120}}, color={0,0,127}));
  connect(dcdcDiodeMode.ISETA, ISETA) annotation (Line(points={{6,-2},{6,-8},{60,
          -8},{60,-120}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                Rectangle(extent={{-100,-100},{100,100}},lineColor={0,0,127},fillColor={255,255,255},
            fillPattern =                                                                                                        FillPattern.Solid),
        Text(        extent={{-150,150},{150,110}},        textString="%name",textColor={0,0,255}),
        Text(          extent={{34,-4},{80,-36}},          textColor={0,0,0},          textString
            =                                                                                     "PI"),
        Polygon(          points={{1,4},{-3,-6},{-3,-6},{5,-6},{1,4}},          lineColor={0,0,0},          fillColor={0,0,0},
            fillPattern =                                                                                                                           FillPattern.Solid,          origin={12,-1},          rotation=90),
        Line(points={{34,-20},{22,-20},{22,0},{16,0},{18,0}}, color={0,0,0}),
        Polygon(          points={{40,30},{36,20},{36,20},{44,20},{40,30}},          lineColor={0,0,0},          fillColor={0,0,0},
            fillPattern =                                                                                                                                FillPattern.Solid),
        Line(points={{54,-4},{54,10},{40,10},{40,22}}, color={0,0,0}),
        Line(points={{-60,-112},{-60,-80},{38,-80},{38,-36}}, color={0,0,0}),
        Line(points={{60,-114},{60,-80}}, color={0,0,0}),
        Line(points={{60,-80},{62,-80},{68,-80},{68,-44}}, color={0,0,0}),
        Polygon(          points={{68,-34},{64,-44},{64,-44},{72,-44},{68,-34}},          lineColor={0,0,0},          fillColor={0,0,0},
            fillPattern =                                                                                                                                     FillPattern.Solid),
        Polygon(          points={{38,-34},{34,-44},{34,-44},{42,-44},{38,-34}},          lineColor={0,0,0},          fillColor={0,0,0},
            fillPattern =                                                                                                                                     FillPattern.Solid),
        Line( points={{0,-25},{0,-15},{20,-15},{-20,-15},{-4,-15},{-20,1},{-8,-5},{-14,
              -11},{-20,1},{-24,5},{-130,5},{-24,5},{-24,15},{8,15},{-8,5},{-8,25},
              {8,15},{8,5},{8,25},{8,15},{24,15},{24,5},{50,5},{24,5},{4,-15}},           origin={40,55},          rotation=360,
         color=DynamicSelect({0,0,0},
if chooseComponent==ChooseComponent.Averaging then {28,108,200}
 else
     if chooseComponent==ChooseComponent.PWMMode then {217,67,180}
 else
     if chooseComponent==ChooseComponent.DiodeEmulatedMode then {238,46,47}
 else
     {0,0,0})),
        Line(points={{10,0},{0,0},{0,20},{0,-20},{0,-4},{-16,-20},{-10,-8},{-4,-14},{-16,-20},{-20,-24},{-20,-60},{-20,-24},{-30,-24}, {-30,8},{-20,-8},{-40,-8},{-30,8},{-20,8},{-40,8},{-30,8},{-30,24},{-20,24},{-20,60},{-20,24},{0,4}},
        color=DynamicSelect({0,0,0},
if chooseComponent==ChooseComponent.Averaging then {28,108,200}
 else
     if chooseComponent==ChooseComponent.PWMMode then {217,67,180}
 else
     if chooseComponent==ChooseComponent.DiodeEmulatedMode then {238,46,47}
 else
     {0,0,0})),
        Line(points={{-90,-60},{90,-60}},
        color=DynamicSelect({0,0,0},
if chooseComponent==ChooseComponent.Averaging then {28,108,200}
 else
     if chooseComponent==ChooseComponent.PWMMode then {217,67,180}
 else
     if chooseComponent==ChooseComponent.DiodeEmulatedMode then {238,46,47}
 else
     {0,0,0})),
        Rectangle(          extent={{34,-4},{76,-34}},          lineColor={0,0,0},          fillColor={0,0,0},
            fillPattern =                                                                                                           FillPattern.None)}),
         Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ControlledBiChopper;
