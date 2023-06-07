within BiChopper.Switching.PWMmode;
model ControlledBuckBoost "ControlledBuckBoost similiar to LM5170"
  extends PartialControlledBuckBoost;
  import Modelica.Units.SI;
  constant String mode="PWMMode";
  parameter Boolean UseExtEnable=false "Use external Enable for CH1 and CH2"
  annotation (Dialog(group="Enable", enable=false), Evaluate=true, HideResult=true, choices(checkBox=true));
 // Modelica.Units.SI.Current iLV(start=0)=0 "LV current";
 // Modelica.Units.SI.Voltage vLV(start=0)=VLV "LV voltage";
 // Modelica.Units.SI.Voltage vHV(start=0)=VHV "HV voltage";
  Modelica.Units.SI.Voltage V1(start=0)=dcdc.V1 "voltage LV";
  Modelica.Units.SI.Voltage Ch1V2(start=0)=dcdc.Ch1V2 "output voltage CH1";
  Modelica.Units.SI.Voltage Ch2V2(start=0)=dcdc.Ch2V2 "output voltage CH2";
  Modelica.Units.SI.Current Ch1I1(start=0)=dcdc.Ch1I1 "input current CH1";
  Modelica.Units.SI.Current Ch2I1(start=0)=dcdc.Ch2I1 "input current CH2";
  TwoCHBuckBoost dcdc(
    UseExtEnable=UseExtEnable,
    EnableCH1=EnableCH1,
    EnableCH2=EnableCH2,
    fS=BiChopperData.fS,
    L=BiChopperData.L,
    R=BiChopperData.R,
    TRef=BiChopperData.TRef,
    alpha20=BiChopperData.alpha20,
    CLV=BiChopperData.CLV,
    CHV=BiChopperData.CHV,
    RonTransistor=BiChopperData.RonTransistor,
    GoffTransistor=BiChopperData.GoffTransistor,
    VkneeTransistor=BiChopperData.VkneeTransistor,
    RonDiode=BiChopperData.RonDiode,
    GoffDiode=BiChopperData.GoffDiode,
    VkneeDiode=BiChopperData.VkneeDiode)
    annotation (Placement(transformation(extent={{-10,-12},{10,8}})));
  Modelica.Blocks.Sources.RealExpression vLV1(y=pin_pLV.v)
    annotation (Placement(transformation(extent={{-80,80},{-60,100}})));
  Modelica.Blocks.Sources.RealExpression iLV1(y=pin_pLV.i)
    annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
  Modelica.Blocks.Sources.RealExpression pLV(y=dcdc.powerDC1)
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Modelica.Blocks.Sources.RealExpression vHV1(y=pin_pHV.v)
    annotation (Placement(transformation(extent={{80,80},{60,100}})));
  Modelica.Blocks.Sources.RealExpression iHV(y=pin_pHV.i)
    annotation (Placement(transformation(extent={{80,50},{60,70}})));
  Modelica.Blocks.Sources.RealExpression pHV(y=dcdc.powerDC2)
    annotation (Placement(transformation(extent={{80,20},{60,40}})));
  Modelica.Blocks.Math.Mean mean_vLV(f=BiChopperData.fS)
    annotation (Placement(transformation(extent={{-50,80},{-30,100}})));
  Modelica.Blocks.Math.Mean mean_iLV(f=BiChopperData.fS)
    annotation (Placement(transformation(extent={{-50,50},{-30,70}})));
  Modelica.Blocks.Math.Mean mean_pLV(f=BiChopperData.fS)
    annotation (Placement(transformation(extent={{-50,20},{-30,40}})));
  Modelica.Blocks.Math.Mean mean_vHV(f=BiChopperData.fS)
    annotation (Placement(transformation(extent={{50,80},{30,100}})));
  Modelica.Blocks.Math.Mean mean_iHV(f=BiChopperData.fS)
    annotation (Placement(transformation(extent={{50,50},{30,70}})));
  Modelica.Blocks.Math.Mean mean_pHV(f=BiChopperData.fS)
    annotation (Placement(transformation(extent={{50,20},{30,40}})));
  Controller.TwoCHController twoCHController(
    k=BiChopperData.kPWM,
    Ti=BiChopperData.TiPWM,
    wp=BiChopperData.wpPWM)
    annotation (Placement(transformation(extent={{-30,-50},{-10,-30}})));
  Modelica.Blocks.Interfaces.BooleanInput CH1Enable if UseExtEnable annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-20,-120})));
  Modelica.Blocks.Interfaces.BooleanInput CH2Enable if UseExtEnable annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={20,-120})));
  Modelica.Blocks.Logical.And and1 if UseExtEnable annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={32,-86})));
  Modelica.Blocks.Logical.Switch switch1 annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={10,-60})));
  Modelica.Blocks.Math.Gain gain(k=0.5) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={70,-44})));
equation
  if not UseExtEnable then
         switch1.u2=EnableCH1 and EnableCH2;
  end if;
  connect(dcdc.dc_n1, pin_nLV) annotation (Line(points={{-10,-8},{-100,-8},{-100,-60}},
                       color={0,0,255}));
  connect(dcdc.dc_p1, pin_pLV) annotation (Line(points={{-10,4},{-100,4},{-100,60}},
                      color={0,0,255}));
  connect(dcdc.dc_p2, pin_pHV)
    annotation (Line(points={{10,4},{100,4},{100,60}},          color={0,0,255}));
  connect(dcdc.dc_n2, pin_nHV) annotation (Line(points={{10,-8},{100,-8},{100,-60}},
                     color={0,0,255}));
  connect(vLV1.y, mean_vLV.u)
    annotation (Line(points={{-59,90},{-52,90}}, color={0,0,127}));
  connect(iLV1.y, mean_iLV.u)
    annotation (Line(points={{-59,60},{-52,60}}, color={0,0,127}));
  connect(mean_iHV.u,iHV. y)
    annotation (Line(points={{52,60},{59,60}}, color={0,0,127}));
  connect(vHV1.y, mean_vHV.u)
    annotation (Line(points={{59,90},{52,90}}, color={0,0,127}));
  connect(pLV.y,mean_pLV. u)
    annotation (Line(points={{-59,30},{-52,30}}, color={0,0,127}));
  connect(mean_pHV.u,pHV. y)
    annotation (Line(points={{52,30},{59,30}}, color={0,0,127}));
  connect(DirectionPin, twoCHController.DirectionPin)
    annotation (Line(points={{-60,-120},{-60,-60},{-26,-60},{-26,-52}}, color={0,0,127}));
  connect(dcdc.ILVCH1, twoCHController.measuredCurrentCH1) annotation (Line(points={{-8,-13},
          {-8,-14},{-24,-14},{-24,-28}},                 color={0,0,127}));
  connect(dcdc.ILVCH2, twoCHController.measuredCurrentCH2)
    annotation (Line(points={{-4,-13},{-4,-20},{-16,-20},{-16,-28}}, color={0,0,127}));
  connect(twoCHController.DutyCycleCH1, dcdc.dutyCycleCH1)
    annotation (Line(points={{-9,-34},{8,-34},{8,-14}}, color={0,0,127}));
  connect(twoCHController.DutyCycleCH2, dcdc.dutyCycleCH2)
    annotation (Line(points={{-9,-46},{4,-46},{4,-14}}, color={0,0,127}));
  connect(CH1Enable, and1.u1)
    annotation (Line(points={{-20,-120},{-20,-86},{20,-86}}, color={255,0,255}));
  connect(CH2Enable, and1.u2)
    annotation (Line(points={{20,-120},{20,-94}}, color={255,0,255}));
  connect(and1.y, switch1.u2)
    annotation (Line(points={{43,-86},{80,-86},{80,-60},{22,-60}}, color={255,0,255}));
  connect(gain.u, ISETA) annotation (Line(points={{82,-44},{88,-44},{88,-94},{60,-94},{60,
          -120}}, color={0,0,127}));
  connect(switch1.y, twoCHController.ISETA)
    annotation (Line(points={{-1,-60},{-14,-60},{-14,-52}}, color={0,0,127}));
  connect(dcdc.CH1Enable, and1.u1) annotation (Line(points={{-4,10},{-4,14},{-40,14},{-40,
          -86},{20,-86}}, color={255,0,255}));
  connect(dcdc.CH2Enable, and1.u2) annotation (Line(points={{4,10},{4,14},{12,14},{12,-100},
          {20,-100},{20,-94}},color={255,0,255}));
  connect(switch1.u1, gain.y)
    annotation (Line(points={{22,-52},{40,-52},{40,-44},{59,-44}}, color={0,0,127}));
  connect(switch1.u3, ISETA)
    annotation (Line(points={{22,-68},{60,-68},{60,-120}}, color={0,0,127}));
  annotation (defaultComponentName="dcdc",Icon(graphics={
        Line(points={{-60,-112},{-60,-80},{38,-80},{38,-36}}, color={0,0,0}),
        Line(points={{60,-114},{60,-80}}, color={0,0,0}),
        Line(points={{60,-80},{62,-80},{68,-80},{68,-44}}, color={0,0,0}),
                                                        Line(
          points={{0,-25},{0,-15},{20,-15},{-20,-15},{-4,-15},{-20,1},{-8,-5},{-14,
              -11},{-20,1},{-24,5},{-130,5},{-24,5},{-24,15},{8,15},{-8,5},{-8,25},
              {8,15},{8,5},{8,25},{8,15},{24,15},{24,5},{50,5},{24,5},{4,-15}},
          color={217,67,180},
          origin={40,55},
          rotation=360),
                   Line(points={{10,0},{0,0},{0,20},{0,-20},{0,-4},{-16,-20},{-10,-8},
              {-4,-14},{-16,-20},{-20,-24},{-20,-60},{-20,-24},{-30,-24},{-30,8},{-20,
              -8},{-40,-8},{-30,8},{-20,8},{-40,8},{-30,8},{-30,24},{-20,24},{-20,60},
              {-20,24},{0,4}},     color={217,67,180}),
        Line(points={{-90,-60},{90,-60}}, color={217,67,180})}));
end ControlledBuckBoost;
