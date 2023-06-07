within BidiDCDC.Examples;
model TransferFunction "Transfer Function of LM5170"
  extends Modelica.Icons.Example;
  Modelica.Blocks.Continuous.TransferFunction transferFunction(b={5.584e5,1.141e11,
        1.0715e15}, a={1,7.061e4,4.005e9,2.679e13},
    initType=Modelica.Blocks.Types.Init.InitialState)
    annotation (Placement(transformation(extent={{-12,-10},{8,10}})));
  Modelica.Blocks.Sources.Step step(height=2, startTime=0.01)
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Modelica.Blocks.Sources.Step step1(height=-2, startTime=0.02)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Blocks.Sources.Step step2(height=-2, startTime=0.03)
    annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
  Modelica.Blocks.Math.MultiSum multiSum(nu=3)
    annotation (Placement(transformation(extent={{-40,-6},{-28,6}})));
equation
  connect(multiSum.y, transferFunction.u)
    annotation (Line(points={{-26.98,0},{-14,0}}, color={0,0,127}));
  connect(step.y, multiSum.u[1])
    annotation (Line(points={{-59,30},{-50,30},{-50,2.8},{-40,2.8}}, color={0,0,127}));
  connect(step1.y, multiSum.u[2]) annotation (Line(points={{-59,0},{-50,0},{-50,
          4.44089e-16},{-40,4.44089e-16}}, color={0,0,127}));
  connect(step2.y, multiSum.u[3]) annotation (Line(points={{-59,-30},{-50,-30},{-50,-2.8},
          {-40,-2.8}}, color={0,0,127}));
  annotation (experiment(
      StopTime=0.04,
      Interval=2e-06,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"));
end TransferFunction;
