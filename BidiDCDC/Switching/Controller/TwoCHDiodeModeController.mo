within BiChopper.Switching.Controller;
block TwoCHDiodeModeController "Controlls an Diodemode BiChopper"
  extends Modelica.Blocks.Icons.Block;
  parameter Modelica.Units.SI.Voltage VLV=12 "LV voltage";
  parameter Modelica.Units.SI.Voltage VHV=24 "HV voltage";
  parameter Real idleDutyCycle=VLV/VHV "Duty cycle for idle operation";
  parameter Real k=0.015 "Gain of Controller";
  parameter Real Ti=10e-5 "Time constant of Integrator block";
  parameter Real wp=1 "Set-point weight for Proportional block";
  Modelica.Blocks.Interfaces.RealInput measuredCurrentCH1 annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-80,120})));
  Modelica.Blocks.Interfaces.RealInput DutyCycle annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={60,-120})));
  Modelica.Blocks.Interfaces.RealInput DirectionPin annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-60,-120})));
  Modelica.Blocks.Interfaces.RealOutput yCH1 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={80,110})));
  Direction direction1_1
    annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
  Modelica.Blocks.Interfaces.BooleanOutput boostmode annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,110})));
  ControllerDiodeMode controllerDiodeModeCH1(
    k=k,
    Ti=Ti,
    wp=wp)
    annotation (Placement(transformation(extent={{-40,2},{-20,22}})));
  Modelica.Blocks.Interfaces.RealInput measuredCurrentCH2 annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-40,120})));
  ControllerDiodeMode controllerDiodeModeCH2(
    k=k,
    Ti=Ti,
    wp=wp)
    annotation (Placement(transformation(extent={{20,-60},{40,-40}})));
  Modelica.Blocks.Interfaces.RealOutput yCH2 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={40,110})));
equation
  connect(DirectionPin, direction1_1.Direction) annotation (Line(points={{-60,-120},{-60,
          -90},{-76,-90},{-76,-42}},      color={0,0,127}));
  connect(DutyCycle, direction1_1.ISETA) annotation (Line(points={{60,-120},{60,
          -86},{-64,-86},{-64,-42}},
                                color={0,0,127}));
  connect(direction1_1.boostmode, boostmode) annotation (Line(points={{-59,-22},{-50,-22},
          {-50,40},{0,40},{0,110}},   color={255,0,255}));
  connect(controllerDiodeModeCH1.boostmode, boostmode) annotation (Line(points={{-36,0},
          {-36,-6},{-50,-6},{-50,40},{0,40},{0,110}},color={255,0,255}));
  connect(controllerDiodeModeCH1.enable, direction1_1.Enable)
    annotation (Line(points={{-24,0},{-24,-34},{-59,-34}},  color={255,0,255}));
  connect(controllerDiodeModeCH2.boostmode, boostmode) annotation (Line(points={{24,-62},{
          24,-64},{-50,-64},{-50,40},{0,40},{0,110}}, color={255,0,255}));
  connect(controllerDiodeModeCH2.DirectedISETA, controllerDiodeModeCH1.DirectedISETA)
    annotation (Line(points={{30,-62},{30,-72},{-30,-72},{-30,0}},  color={0,0,127}));
  connect(controllerDiodeModeCH2.enable, direction1_1.Enable) annotation (Line(points={{36,
          -62},{36,-80},{-24,-80},{-24,-34},{-59,-34}}, color={255,0,255}));
  connect(measuredCurrentCH2, controllerDiodeModeCH2.measuredCurrent) annotation (Line(
        points={{-40,120},{-40,80},{-10,80},{-10,-20},{30,-20},{30,-38}}, color={0,0,127}));
  connect(controllerDiodeModeCH1.measuredCurrent, measuredCurrentCH1)
    annotation (Line(points={{-30,24},{-30,60},{-80,60},{-80,120}}, color={0,0,
          127}));
  connect(direction1_1.DirectedISETA, controllerDiodeModeCH1.DirectedISETA)
    annotation (Line(points={{-59,-30},{-30,-30},{-30,0}}, color={0,0,127}));
  connect(controllerDiodeModeCH1.y, yCH1)
    annotation (Line(points={{-19,12},{80,12},{80,110}}, color={0,0,127}));
  connect(controllerDiodeModeCH2.y, yCH2) annotation (Line(points={{41,-50},{46,
          -50},{46,96},{40,96},{40,110}}, color={0,0,127}));
end TwoCHDiodeModeController;
