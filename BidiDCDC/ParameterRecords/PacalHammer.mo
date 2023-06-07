within BiChopper.ParameterRecords;
record PacalHammer "Parameter according to design of Pascal Hammer"
  extends BiChopper(
  Type="PHammer",
  VLV=12,
  VHV=48,
  fS=40e3,
  L=10e-6,
  R=1.85e-3+3e-3,
  TRef=239.15,
  alpha20=Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
  CLV=738.8e-6,
  CHV=295e-6,
  RonTransistor=1e-05,
  GoffTransistor=1e-05,
  VkneeTransistor=0,
  RonDiode=1e-05,
  GoffDiode=1e-05,
  VkneeDiode=0,
kPWM=0.015,
     TiPWM=10e-5,
     wpPWM=1,
     kDiodeMode=0.015,
     TiDiodeMode=10e-5,
     wpDiodeMode=1,
     kAverage=0.004,
     TiAverage=2.5e-4,
     wpAverage=1)
  annotation (defaultComponentName="BiChopperData", defaultComponentPrefixes="parameter",
  Documentation(info="<html>
<p>
Collects all data from the circuit from Pascal Hammer.
</p>
</html>"));
end PacalHammer;
