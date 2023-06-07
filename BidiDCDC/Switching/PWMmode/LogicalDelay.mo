within BiChopper.Switching.PWMmode;
block LogicalDelay "Delays the input"
  extends Modelica.Blocks.Icons.BooleanBlock;
  import Modelica.Units.SI;

  parameter SI.Time delayTime(final min=0)=0 "Time delay";
  Modelica.Blocks.Interfaces.BooleanInput u
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.BooleanOutput y
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
protected
  discrete SI.Time tSwitch;
initial equation
  tSwitch = time - 2*delayTime;
equation
  when {u, not u} then
    tSwitch = time;
  end when;
  y = if u then (time >= tSwitch + delayTime) else not (time >= tSwitch + delayTime);
  annotation (Documentation(info="<html>
<p>
When input <code>u</code> gets true, output <code>y</code> gets true after <code>delayTime</code>.
</p>
<p>
When input <code>u</code> gets false, output <code>y</code> gets false after <code>delayTime</code>.
</p>
</html>"),
         Icon(graphics={
      Polygon(lineColor={192,192,192},
        fillColor={192,192,192},
        fillPattern=FillPattern.Solid,
        points={{-80,90},{-88,68},{-72,68},{-80,90}}),
      Line(points={{-80,68},{-80,-80}},
        color={192,192,192}),
      Line(points={{-90,-70},{82,-70}},
        color={192,192,192}),
      Polygon(lineColor={192,192,192},
        fillColor={192,192,192},
        fillPattern=FillPattern.Solid,
        points={{90,-70},{68,-62},{68,-78},{90,-70}}),
        Line(points={{-80,12},{-60,12},{-60,52},{40,52},{40,12},{66,12}},
            color={255,0,255}),
        Line(points={{-80,-70},{-50,-70},{-50,-30},{50,-30},{50,-70},{66,-70}},
            color={255,0,255}),
        Line(
          points={{-60,70},{-60,-70}},
          color={192,192,192},
          pattern=LinePattern.Dot),
        Line(
          points={{40,70},{40,-70}},
          color={192,192,192},
          pattern=LinePattern.Dot)}));
end LogicalDelay;
