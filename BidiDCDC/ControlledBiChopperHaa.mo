within BiChopper;
model ControlledBiChopperHaa
  "Contains three choosable variants of the BiChopper"
  replaceable BiChopper.Averaging.CurrentBalance.ControlledBuckBoost dcdc
   constrainedby BiChopper.PartialControlledBuckBoost "Click on component for parameterization and initialization"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})),
    choices(
    choice(redeclare BiChopper.Averaging.CurrentBalance.ControlledBuckBoost dcdc "Averaging - fastest model"),
    choice(redeclare BiChopper.Switching.PWMmode.ControlledBuckBoost dcdc(UseExtEnable=false) "Switching"),
    choice(redeclare BiChopper.Switching.DiodeMode.ControlledBuckBoost dcdc(UseExtEnable=false) "DiodeMode - most accurate")));
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
equation
  connect(dcdc.pin_pLV, pin_pLV) annotation (Line(points={{-10,6},{-80,6},{-80,60},
          {-100,60},{-100,60}}, color={0,0,255}));
  connect(dcdc.pin_pHV, pin_pHV) annotation (Line(points={{10,6},{80,6},{80,60},
          {100,60}}, color={0,0,255}));
  connect(dcdc.pin_nHV, pin_nHV) annotation (Line(points={{10,-6},{80,-6},{80,-60},
          {100,-60}}, color={0,0,255}));
  connect(dcdc.pin_nLV, pin_nLV) annotation (Line(points={{-10,-6},{-80,-6},{-80,
          -60},{-100,-60}}, color={0,0,255}));
  connect(DirectionPin, dcdc.DirectionPin) annotation (Line(points={{-60,-120},{
          -60,-80},{-6,-80},{-6,-12}}, color={0,0,127}));
  connect(ISETA, dcdc.ISETA) annotation (Line(points={{60,-120},{60,-80},{6,-80},
          {6,-12},{6,-12}}, color={0,0,127}));
  annotation (defaultComponentName="controlledBiChopper",
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={
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
              {8,15},{8,5},{8,25},{8,15},{24,15},{24,5},{50,5},{24,5},{4,-15}},
        color=DynamicSelect({0,0,0}, if dcdc.mode=="Averaging" then {28,108,200}
                                else if dcdc.mode=="PWMMode" then {217,67,180}
                                else if dcdc.mode=="DiodeMode" then {238,46,47} else {0,0,0}),
        origin={40,55},          rotation=360),
        Line(points={{10,0},{0,0},{0,20},{0,-20},{0,-4},{-16,-20},{-10,-8},{-4,-14},{-16,-20},{-20,-24},{-20,-60},{-20,-24},{-30,-24}, {-30,8},{-20,-8},{-40,-8},{-30,8},{-20,8},{-40,8},{-30,8},{-30,24},{-20,24},{-20,60},{-20,24},{0,4}},
        color=DynamicSelect({0,0,0}, if dcdc.mode=="Averaging" then {28,108,200}
                                else if dcdc.mode=="PWMMode" then {217,67,180}
                                else if dcdc.mode=="DiodeMode" then {238,46,47} else {0,0,0})),
        Line(points={{-90,-60},{90,-60}},
        color=DynamicSelect({0,0,0}, if dcdc.mode=="Averaging" then {28,108,200}
                                else if dcdc.mode=="PWMMode" then {217,67,180}
                                else if dcdc.mode=="DiodeMode" then {238,46,47} else {0,0,0})),
        Rectangle(          extent={{34,-4},{76,-34}},          lineColor={0,0,0},          fillColor={0,0,0},
            fillPattern =                                                                                                           FillPattern.None)}),
         Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ControlledBiChopperHaa;
