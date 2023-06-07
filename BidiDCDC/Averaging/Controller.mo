within BiChopper.Averaging;
package Controller "Controller for the Averaging models"
  extends Modelica.Icons.Package;
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
    Modelica.Blocks.Interfaces.BooleanOutput y annotation (Placement(transformation(
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
  equation
    connect(greaterEqual.u1,lessEqual. u1) annotation (Line(points={{-4,-70},{-4,
            -76},{-64,-76},{-64,-70}},    color={0,0,127}));
    connect(realExpression.y,lessEqual. u2) annotation (Line(points={{-38,-69},{-38,
            -74},{-56,-74},{-56,-70}},  color={0,0,127}));
    connect(realExpression1.y,greaterEqual. u2) annotation (Line(points={{22,-69},{
            22,-74},{4,-74},{4,-70}},         color={0,0,127}));
    connect(Direction, lessEqual.u1) annotation (Line(points={{-60,-120},{-60,-76},
            {-64,-76},{-64,-70}}, color={0,0,127}));
    connect(or1.u1, lessEqual.y) annotation (Line(points={{-28,-28},{-28,-40},{-64,
            -40},{-64,-47}}, color={255,0,255}));
    connect(or1.u2, greaterEqual.y) annotation (Line(points={{-20,-28},{-20,-40},{
            -4,-40},{-4,-47}}, color={255,0,255}));
    connect(or1.y, y) annotation (Line(points={{-28,-5},{-28,0},{2,0},{2,-34},{94,
            -34},{94,-40},{110,-40}}, color={255,0,255}));
    connect(switch1.u2, lessEqual.y) annotation (Line(points={{28,50},{-60,50},{-60,
            -40},{-64,-40},{-64,-47}}, color={255,0,255}));
    connect(ISETA, switch1.u1) annotation (Line(points={{60,-120},{60,-36},{0,-36},
            {0,58},{28,58}}, color={0,0,127}));
    connect(switch2.u2, greaterEqual.y)
      annotation (Line(points={{8,-10},{-4,-10},{-4,-47}}, color={255,0,255}));
    connect(switch2.u1, switch1.u1)
      annotation (Line(points={{8,-2},{0,-2},{0,58},{28,58}}, color={0,0,127}));
    connect(const.y, switch1.u3) annotation (Line(points={{-19,30},{20,30},{20,42},
            {28,42}}, color={0,0,127}));
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
  end Direction;

  block Controlleralgorithm
    "Controller for lossfree averaging models of the BiChopper"
    extends Modelica.Blocks.Icons.Block;
    parameter Modelica.Units.SI.Voltage VLV=12 "LV voltage";
    parameter Modelica.Units.SI.Voltage VHV=24 "HV voltage";
    parameter Real idleDutyCycle=VLV/VHV "Duty cycle for idle operation";
    parameter Real k=0.015 "Gain of Controller";
    parameter Real Ti=10e-5 "Time constant of Integrator block";
    parameter Real wp=1 "Set-point weight for Proportional block";

    Modelica.Blocks.Math.Gain gain(k=40) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-60,-10})));
    Modelica.Blocks.Continuous.LimPID PID1(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=k,
      Ti=Ti,
      Td=1e-5,
      yMax=1,
      yMin=0,
      wp=wp,
      wd=1,
      withFeedForward=false,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      y_start=0.5)
      annotation (Placement(transformation(extent={{-20,30},{0,10}})));
    Modelica.Blocks.Interfaces.RealInput measuredCurrent annotation (Placement(
          transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={-10,120})));
    Modelica.Blocks.Interfaces.RealOutput DutyCycle
      annotation (Placement(transformation(extent={{100,40},{120,60}})));
    Modelica.Blocks.Interfaces.RealInput ISETA annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=90,
          origin={-60,-120})));
    Modelica.Blocks.Logical.Switch switch1
      annotation (Placement(transformation(extent={{60,2},{80,22}})));
    Modelica.Blocks.Sources.Constant const(k=idleDutyCycle) annotation (Placement(
          transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={-10,-10})));
    Modelica.Blocks.Interfaces.BooleanInput Enable annotation (Placement(
          transformation(
          extent={{-20,-20},{20,20}},
          rotation=90,
          origin={60,-120})));
  equation
    connect(gain.y,PID1. u_s)
      annotation (Line(points={{-60,1},{-60,20},{-22,20}}, color={0,0,127}));
    connect(gain.u, ISETA)
      annotation (Line(points={{-60,-22},{-60,-120}}, color={0,0,127}));
    connect(switch1.y, DutyCycle)
      annotation (Line(points={{81,12},{96,12},{96,50},{110,50}}, color={0,0,127}));
    connect(const.y, switch1.u3)
      annotation (Line(points={{1,-10},{20,-10},{20,4},{58,4}},
                                                          color={0,0,127}));
    connect(measuredCurrent, PID1.u_m)
      annotation (Line(points={{-10,120},{-10,32}}, color={0,0,127}));
    connect(Enable, switch1.u2) annotation (Line(points={{60,-120},{60,0},{52,0},{52,12},
            {58,12}}, color={255,0,255}));
    connect(PID1.y, switch1.u1)
      annotation (Line(points={{1,20},{58,20}},  color={0,0,127}));
  end Controlleralgorithm;

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
    Modelica.Blocks.Interfaces.RealOutput y
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    Modelica.Blocks.Nonlinear.Limiter limiter(uMax=1, uMin=0)
      annotation (Placement(transformation(extent={{40,-10},{60,10}})));
    Direction direction1_1
      annotation (Placement(transformation(extent={{-58,-40},{-38,-20}})));
    Controlleralgorithm controlleralgorithm1_1(
      VLV=VLV,
      VHV=VHV,
      k=k,
      Ti=Ti,
      wp=wp)
      annotation (Placement(transformation(extent={{-10,-28},{10,-8}})));
  equation
    connect(limiter.y, y) annotation (Line(points={{61,0},{110,0}}, color={0,0,127}));
    connect(DirectionPin, direction1_1.Direction) annotation (Line(points={{-60,-120},
            {-60,-48},{-54,-48},{-54,-42}}, color={0,0,127}));
    connect(DutyCycle, direction1_1.ISETA) annotation (Line(points={{60,-120},{60,-48},
            {-42,-48},{-42,-42}}, color={0,0,127}));
    connect(direction1_1.DirectedISETA, controlleralgorithm1_1.ISETA) annotation (
        Line(points={{-37,-30},{-14,-30},{-14,-36},{-6,-36},{-6,-30}}, color={0,0,127}));
    connect(controlleralgorithm1_1.DutyCycle, limiter.u)
      annotation (Line(points={{11,-13},{30,-13},{30,0},{38,0}}, color={0,0,127}));
    connect(controlleralgorithm1_1.measuredCurrent, measuredCurrent)
      annotation (Line(points={{-1,-6},{-1,48},{0,48},{0,120}}, color={0,0,127}));
    connect(direction1_1.y, controlleralgorithm1_1.Enable) annotation (Line(points={{-37,
            -34},{-20,-34},{-20,-40},{6,-40},{6,-30}}, color={255,0,255}));
  end Controller;
end Controller;
