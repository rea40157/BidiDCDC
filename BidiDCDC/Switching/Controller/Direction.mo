within BiChopper.Switching.Controller;
block Direction "Sets the Directions of the BiChopper"
  extends Modelica.Blocks.Icons.Block;
  parameter Modelica.Units.SI.Voltage VLV=12 "LV voltage";
  parameter Modelica.Units.SI.Voltage VHV=24 "HV voltage";
  parameter Real idleDutyCycle=VLV/VHV "Duty cycle for idle operation";
  Modelica.Blocks.Logical.GreaterEqual greaterEqual annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-4,-58})));
  Modelica.Blocks.Logical.LessEqual lessEqual annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-64,-58})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=1) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-38,-58})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=2) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={22,-58})));
  Modelica.Blocks.Logical.Or or1 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-28,-16})));
  Modelica.Blocks.Interfaces.RealInput Direction ">2V=Buck;<1V=boost" annotation (
     Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-60,-120})));
  Modelica.Blocks.Interfaces.BooleanOutput Enable annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={110,-40})));
  Modelica.Blocks.Interfaces.RealInput ISETA annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={60,-120})));
  Modelica.Blocks.Interfaces.RealOutput DirectedISETA
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{30,40},{50,60}})));
  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{10,-20},{30,0}})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{70,-10},{90,10}})));
  Modelica.Blocks.Math.Gain gain(k=-1)
    annotation (Placement(transformation(extent={{42,-16},{62,4}})));
  Modelica.Blocks.Interfaces.BooleanOutput boostmode
    annotation (Placement(transformation(extent={{100,70},{120,90}})));
equation
  connect(greaterEqual.u1,lessEqual. u1) annotation (Line(points={{-4,-70},{-4,
          -80},{-64,-80},{-64,-70}},    color={0,0,127}));
  connect(realExpression.y,lessEqual. u2) annotation (Line(points={{-38,-69},{-38,
          -74},{-56,-74},{-56,-70}},  color={0,0,127}));
  connect(realExpression1.y,greaterEqual. u2) annotation (Line(points={{22,-69},{
          22,-74},{4,-74},{4,-70}},         color={0,0,127}));
  connect(Direction, lessEqual.u1) annotation (Line(points={{-60,-120},{-60,-80},
          {-64,-80},{-64,-70}}, color={0,0,127}));
  connect(or1.u1, lessEqual.y) annotation (Line(points={{-28,-28},{-28,-40},{-64,
          -40},{-64,-47}}, color={255,0,255}));
  connect(or1.u2, greaterEqual.y) annotation (Line(points={{-20,-28},{-20,-40},{
          -4,-40},{-4,-47}}, color={255,0,255}));
  connect(or1.y, Enable) annotation (Line(points={{-28,-5},{-28,0},{2,0},{2,-34},{94,-34},
          {94,-40},{110,-40}}, color={255,0,255}));
  connect(switch1.u2, lessEqual.y) annotation (Line(points={{28,50},{-60,50},{-60,
          -40},{-64,-40},{-64,-47}}, color={255,0,255}));
  connect(ISETA, switch1.u1) annotation (Line(points={{60,-120},{60,-36},{0,-36},
          {0,58},{28,58}}, color={0,0,127}));
  connect(switch2.u2, greaterEqual.y)
    annotation (Line(points={{8,-10},{-4,-10},{-4,-47}}, color={255,0,255}));
  connect(switch2.u1, switch1.u1)
    annotation (Line(points={{8,-2},{0,-2},{0,58},{28,58}}, color={0,0,127}));
  connect(const.y, switch1.u3) annotation (Line(points={{-19,30},{8,30},{8,42},{28,42}},
                    color={0,0,127}));
  connect(switch2.u3, switch1.u3)
    annotation (Line(points={{8,-18},{8,42},{28,42}}, color={0,0,127}));
  connect(switch1.y, add.u1)
    annotation (Line(points={{51,50},{60,50},{60,6},{68,6}}, color={0,0,127}));
  connect(add.y, DirectedISETA)
    annotation (Line(points={{91,0},{110,0}}, color={0,0,127}));
  connect(switch2.y, gain.u) annotation (Line(points={{31,-10},{36,-10},{36,-6},{
          40,-6}}, color={0,0,127}));
  connect(gain.y, add.u2)
    annotation (Line(points={{63,-6},{68,-6}}, color={0,0,127}));
  connect(boostmode, lessEqual.y) annotation (Line(points={{110,80},{-20,80},{-20,50},{-60,
          50},{-60,-40},{-64,-40},{-64,-47}}, color={255,0,255}));
end Direction;
