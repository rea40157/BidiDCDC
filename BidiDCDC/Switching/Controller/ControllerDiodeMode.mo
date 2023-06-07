within BiChopper.Switching.Controller;
block ControllerDiodeMode "Controlls an Diodemode BiChopper"
  extends Modelica.Blocks.Icons.Block;
  parameter Modelica.Units.SI.Voltage VLV=12 "LV voltage";
  parameter Modelica.Units.SI.Voltage VHV=24 "HV voltage";
  parameter Real idleDutyCycle=VLV/VHV "Duty cycle for idle operation";
  parameter Real k=0.015 "Gain of Controller";
  parameter Real Ti=10e-5 "Time constant of Integrator block";
  parameter Real wp=1 "Set-point weight for Proportional block";
  Modelica.Blocks.Interfaces.RealInput measuredCurrent annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120})));
  Modelica.Blocks.Interfaces.RealInput DirectedISETA annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120})));
  Modelica.Blocks.Interfaces.RealOutput y
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=1, uMin=0)
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Controlleralgorithm controlleralgorithm1_1(
    k=k,
    Ti=Ti,
    wp=wp)
    annotation (Placement(transformation(extent={{-10,-28},{10,-8}})));
  CurrentDirectionCorrection currentDirectionCorrection
    annotation (Placement(transformation(extent={{-40,-26},{-20,-46}})));
  CurrentDirectionCorrection currentDirectionCorrection1 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,26})));
  Modelica.Blocks.Interfaces.BooleanInput boostmode annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-60,-120})));
  Modelica.Blocks.Interfaces.BooleanInput enable annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={60,-120})));
equation
  connect(controlleralgorithm1_1.DutyCycle, limiter.u)
    annotation (Line(points={{11,-13},{30,-13},{30,0},{38,0}}, color={0,0,127}));
  connect(limiter.y, y) annotation (Line(points={{61,0},{110,0}}, color={0,0,127}));
  connect(currentDirectionCorrection.y, controlleralgorithm1_1.ISETA) annotation (Line(
        points={{-19,-36},{-6,-36},{-6,-30}},                     color={0,0,127}));
  connect(measuredCurrent, currentDirectionCorrection1.u) annotation (Line(points={{0,120},
          {0,76},{2.22045e-15,76},{2.22045e-15,38}}, color={0,0,127}));
  connect(currentDirectionCorrection1.y, controlleralgorithm1_1.measuredCurrent)
    annotation (Line(points={{-1.9984e-15,15},{0,-6}},                          color={0,0,
          127}));
  connect(DirectedISETA, currentDirectionCorrection.u) annotation (Line(points={{0,-120},
          {0,-60},{-48,-60},{-48,-36},{-42,-36}},color={0,0,127}));
  connect(boostmode, currentDirectionCorrection1.u1) annotation (Line(points={{-60,
          -120},{-60,26},{-12,26}},              color={255,0,255}));
  connect(currentDirectionCorrection.u1, currentDirectionCorrection1.u1)
    annotation (Line(points={{-30,-24},{-30,26},{-12,26}}, color={255,0,255}));
  connect(controlleralgorithm1_1.Enable, enable)
    annotation (Line(points={{6,-30},{6,-40},{60,-40},{60,-120}}, color={255,0,255}));
end ControllerDiodeMode;
