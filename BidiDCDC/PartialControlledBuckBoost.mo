within BiChopper;
partial model PartialControlledBuckBoost "Partial Controlled BiChopper"
  extends Modelica.Blocks.Icons.Block;
  import Modelica.Units.SI;
  parameter BiChopper.ParameterRecords.BiChopper BiChopperData annotation (
      choicesAllMatching=true, Placement(transformation(extent={{-10,60},{10,80}})));
  parameter Boolean EnableCH1=true
  annotation (Dialog(group="Enable"), choices(checkBox=true));
  parameter Boolean EnableCH2=true
  annotation (Dialog(group="Enable"), choices(checkBox=true));
  Modelica.Blocks.Interfaces.RealInput DirectionPin "<1=boost;>2=buck" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-60,-120})));
  Modelica.Blocks.Interfaces.RealInput ISETA "1Vin=40A" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={60,-120})));
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_pLV
    annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_nLV
    annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_pHV
    annotation (Placement(transformation(extent={{90,50},{110,70}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_nHV
    annotation (Placement(transformation(extent={{90,-70},{110,-50}})));

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
        Line(points={{28,-16},{22,-16},{22,0},{10,0},{12,0}}, color={0,0,0}),
        Line(points={{54,4},{54,18},{40,18},{40,30}}, color={0,0,0}),
        Polygon(
          points={{40,30},{36,20},{36,20},{44,20},{40,30}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{1,4},{-3,-6},{-3,-6},{5,-6},{1,4}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          origin={12,-1},
          rotation=90)}));
end PartialControlledBuckBoost;
