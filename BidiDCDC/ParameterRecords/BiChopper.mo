within BiChopper.ParameterRecords;
record BiChopper "Evaluation Board LM5170"
  extends Modelica.Icons.Record;
  import Modelica.Units.SI;
  parameter String Type="Eval Board" "Parametresierung";
  parameter SI.Voltage VLV=12 "Low Side Voltage";
  parameter SI.Voltage VHV=24 "High Side Voltage";

  parameter Modelica.Units.SI.Frequency fS=40e3 "Swicthing frequency";
  parameter Modelica.Units.SI.Inductance L=4.7e-6 "Inductance";
  parameter Modelica.Units.SI.Resistance R=1e-3 "Resistance of inductor @TRef";
  parameter Modelica.Units.SI.Temperature TRef=293.15 "Reference temperature"
  annotation(Dialog(tab="Heat Transfer"));
  parameter Modelica.Units.SI.LinearTemperatureCoefficient alpha20=Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero
    "Temperature coefficient of resistance 20degC"
    annotation(Dialog(tab="Heat Transfer"));
  parameter Modelica.Units.SI.Capacitance CLV=470e-6 "Low voltage capacitance";
  parameter Modelica.Units.SI.Capacitance CHV=100e-6 "High voltage capacitance";
  parameter Modelica.Units.SI.Resistance RonTransistor=1e-05
    "Transistor closed resistance"
    annotation(Dialog(tab="Semiconductors"));
  parameter Modelica.Units.SI.Conductance GoffTransistor=1e-05
    "Transistor opened conductance"
    annotation(Dialog(tab="Semiconductors"));
  parameter Modelica.Units.SI.Voltage VkneeTransistor=0
    "Transistor threshold voltage"
    annotation(Dialog(tab="Semiconductors"));
  parameter Modelica.Units.SI.Resistance RonDiode=1e-05
    "Diode closed resistance"
    annotation(Dialog(tab="Semiconductors"));
  parameter Modelica.Units.SI.Conductance GoffDiode=1e-05
    "Diode opened conductance"
    annotation(Dialog(tab="Semiconductors"));
  parameter Modelica.Units.SI.Voltage VkneeDiode=0
    "Diode threshold voltage"
    annotation(Dialog(tab="Semiconductors"));
   parameter Real kPWM=0.015 "Gain of Controller"
    annotation(Dialog(tab="Controller", group="Komplementärer Modus"));
   parameter Real TiPWM=10e-5 "Time constant of Integrator block"
    annotation(Dialog(tab="Controller", group="Komplementärer Modus"));
   parameter Real wpPWM=1 "Set-point weight for Proportional block"
    annotation(Dialog(tab="Controller", group="Komplementärer Modus"));
   parameter Real kDiodeMode=0.015 "Gain of Controller"
    annotation(Dialog(tab="Controller", group="Diode Emulated Mode"));
   parameter Real TiDiodeMode=10e-5 "Time constant of Integrator block"
    annotation(Dialog(tab="Controller", group="Diode Emulated Mode"));
   parameter Real wpDiodeMode=1 "Set-point weight for Proportional block"
    annotation(Dialog(tab="Controller", group="Diode Emulated Mode"));
   parameter Real kAverage=0.0075 "Gain of Controller"
    annotation(Dialog(tab="Controller", group="Averaging Mode"));
   parameter Real TiAverage=25e-5 "Time constant of Integrator block"
    annotation(Dialog(tab="Controller", group="Averaging Mode"));
   parameter Real wpAverage=1 "Set-point weight for Proportional block"
    annotation(Dialog(tab="Controller", group="Averaging Mode"));
  annotation(defaultComponentName="BiChopperData", defaultComponentPrefixes="parameter",
    Icon(graphics={Text(
          extent={{-100,0},{100,-50}},
          textColor={0,0,0},
          textString="%Type")}));
end BiChopper;
