within BiChopper.Switching.Controller;
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
    Td=1e-4,
    yMax=1,
    yMin=0,
    wp=wp,
    wd=1,
    withFeedForward=false)
    annotation (Placement(transformation(extent={{-10,30},{10,10}})));
  Modelica.Blocks.Interfaces.RealInput measuredCurrent annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120})));
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
        origin={0,-10})));
  Modelica.Blocks.Interfaces.BooleanInput Enable annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={60,-120})));
equation
  connect(gain.y,PID1. u_s)
    annotation (Line(points={{-60,1},{-60,20},{-12,20}}, color={0,0,127}));
  connect(gain.u, ISETA)
    annotation (Line(points={{-60,-22},{-60,-120}}, color={0,0,127}));
  connect(switch1.y, DutyCycle)
    annotation (Line(points={{81,12},{96,12},{96,50},{110,50}}, color={0,0,127}));
  connect(const.y, switch1.u3)
    annotation (Line(points={{11,-10},{20,-10},{20,4},{58,4}},
                                                        color={0,0,127}));
  connect(measuredCurrent, PID1.u_m)
    annotation (Line(points={{0,120},{0,32},{0,32}},
                                                  color={0,0,127}));
  connect(Enable, switch1.u2) annotation (Line(points={{60,-120},{60,-60},{40,
          -60},{40,12},{58,12}},
                    color={255,0,255}));
  connect(PID1.y, switch1.u1)
    annotation (Line(points={{11,20},{58,20}}, color={0,0,127}));
end Controlleralgorithm;
