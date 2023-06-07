within BiChopper.Switching.Controller;
model TwoCHController
  extends Modelica.Blocks.Icons.Block;
    parameter Real k=0.015 "Gain of Controller";
  parameter Real Ti=10e-5 "Time constant of Integrator block";
  parameter Real wp=1 "Set-point weight for Proportional block";
  Modelica.Blocks.Interfaces.RealInput DirectionPin annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-60,-120})));
  Modelica.Blocks.Interfaces.RealInput ISETA annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={60,-120})));
  Modelica.Blocks.Interfaces.RealOutput DutyCycleCH1
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealInput measuredCurrentCH1 annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-40,120})));
  Modelica.Blocks.Interfaces.BooleanOutput boostmode annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={80,110})));
  Modelica.Blocks.Interfaces.RealInput measuredCurrentCH2 annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={40,120})));
  Modelica.Blocks.Interfaces.RealOutput DutyCycleCH2
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
  Direction direction1 annotation (Placement(transformation(extent={{-64,-62},{
            -44,-42}})));
  Controlleralgorithm controlleralgorithmCH1(
    k=k,
    Ti=Ti,
    wp=wp)
    annotation (Placement(transformation(extent={{-32,-10},{-12,10}})));
  Controlleralgorithm controlleralgorithmCH2(
    k=k,
    Ti=Ti,
    wp=wp)
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=1, uMin=0)
    annotation (Placement(transformation(extent={{52,50},{72,70}})));
  Modelica.Blocks.Nonlinear.Limiter limiter1(uMax=1, uMin=0)
    annotation (Placement(transformation(extent={{70,-70},{90,-50}})));
equation
  connect(DirectionPin, direction1.Direction)
    annotation (Line(points={{-60,-120},{-60,-64}},                     color={0,0,127}));
  connect(ISETA, direction1.ISETA)
    annotation (Line(points={{60,-120},{60,-80},{-48,-80},{-48,-64}}, color={0,0,127}));
  connect(direction1.boostmode, boostmode) annotation (Line(points={{-43,-44},{
          80,-44},{80,110}},           color={255,0,255}));
  connect(direction1.Enable, controlleralgorithmCH1.Enable)
    annotation (Line(points={{-43,-56},{-16,-56},{-16,-12}}, color={255,0,255}));
  connect(direction1.DirectedISETA, controlleralgorithmCH1.ISETA)
    annotation (Line(points={{-43,-52},{-28,-52},{-28,-12}}, color={0,0,127}));
  connect(measuredCurrentCH1, controlleralgorithmCH1.measuredCurrent)
    annotation (Line(points={{-40,120},{-40,66},{-40,12},{-22,12}}, color={0,0,127}));
  connect(controlleralgorithmCH2.ISETA, controlleralgorithmCH1.ISETA)
    annotation (Line(points={{34,-12},{34,-18},{-28,-18},{-28,-12}}, color={0,0,127}));
  connect(controlleralgorithmCH2.Enable, controlleralgorithmCH1.Enable)
    annotation (Line(points={{46,-12},{46,-22},{-16,-22},{-16,-12}}, color={255,0,255}));
  connect(controlleralgorithmCH2.measuredCurrent, measuredCurrentCH2)
    annotation (Line(points={{40,12},{40,120}},                 color={0,0,127}));
  connect(controlleralgorithmCH1.DutyCycle, limiter.u)
    annotation (Line(points={{-11,5},{20,5},{20,60},{50,60}},
                                                            color={0,0,127}));
  connect(limiter.y, DutyCycleCH1)
    annotation (Line(points={{73,60},{110,60}}, color={0,0,127}));
  connect(controlleralgorithmCH2.DutyCycle, limiter1.u)
    annotation (Line(points={{51,5},{60,5},{60,-60},{68,-60}}, color={0,0,127}));
  connect(limiter1.y, DutyCycleCH2)
    annotation (Line(points={{91,-60},{110,-60}}, color={0,0,127}));
end TwoCHController;
