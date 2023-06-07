within BiChopper.Switching.Controller;
block Controller "Controlls an lossfree averaging BiChopper"
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
  Modelica.Blocks.Interfaces.RealInput ISETA annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={60,-120})));
  Modelica.Blocks.Interfaces.RealInput DirectionPin annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-60,-120})));
  Modelica.Blocks.Interfaces.RealOutput y
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=1, uMin=0)
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Direction direction1_1
    annotation (Placement(transformation(extent={{-60,-46},{-40,-26}})));
  Controlleralgorithm controlleralgorithm1_1
    annotation (Placement(transformation(extent={{-10,-28},{10,-8}})));
  Modelica.Blocks.Interfaces.BooleanOutput boostmode annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={60,110})));
equation
  connect(DirectionPin, direction1_1.Direction) annotation (Line(points={{-60,
          -120},{-60,-80},{-56,-80},{-56,-48}},
                                          color={0,0,127}));
  connect(ISETA, direction1_1.ISETA)
    annotation (Line(points={{60,-120},{60,-80},{-44,-80},{-44,-48}}, color={0,0,127}));
  connect(direction1_1.DirectedISETA, controlleralgorithm1_1.ISETA) annotation (
      Line(points={{-39,-36},{-6,-36},{-6,-30}},                     color={0,0,127}));
  connect(controlleralgorithm1_1.DutyCycle, limiter.u)
    annotation (Line(points={{11,-13},{30,-13},{30,0},{38,0}}, color={0,0,127}));
  connect(controlleralgorithm1_1.measuredCurrent, measuredCurrent)
    annotation (Line(points={{0,-6},{0,48},{0,48},{0,120}},   color={0,0,127}));
  connect(direction1_1.Enable, controlleralgorithm1_1.Enable) annotation (Line(points={{-39,-40},
          {6,-40},{6,-30}},                          color={255,0,255}));
  connect(limiter.y, y) annotation (Line(points={{61,0},{110,0}}, color={0,0,127}));
  connect(direction1_1.boostmode, boostmode) annotation (Line(points={{-39,-28},
          {-20,-28},{-20,80},{60,80},{60,110}},
                                      color={255,0,255}));
end Controller;
