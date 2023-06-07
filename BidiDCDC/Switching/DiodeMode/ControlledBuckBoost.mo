within BiChopper.Switching.DiodeMode;
model ControlledBuckBoost "ControlledBuckBoost similiar to LM5170"
  extends PartialControlledBuckBoost;
  import Modelica.Units.SI;
  constant String mode="DiodeMode";
  parameter Boolean UseExtEnable=false "Use external Enable for CH1 and CH2"
  annotation (Dialog(group="Enable", enable=false),  Evaluate=true, HideResult=true, choices(checkBox=true));
 // Modelica.Units.SI.Current iLV(start=0)=0 "LV current";
  //Modelica.Units.SI.Voltage vLV(start=0)=VLV "LV voltage";
 // Modelica.Units.SI.Voltage vHV(start=0)=VHV "HV voltage";
 //Modelica.Units.SI.Current iStart(start=0)=CH1.p1.i;

  Modelica.Units.SI.Voltage V1(start=0)=dcdc.V1 "input voltage";
  Modelica.Units.SI.Voltage Ch1V2(start=0)=dcdc.Ch1V2 "output voltage CH1";
  Modelica.Units.SI.Voltage Ch2V2(start=0)=dcdc.Ch2V2 "output voltage CH2";
  Modelica.Units.SI.Current Ch1I1(start=0)=dcdc.Ch1I1 "input current CH1";
  Modelica.Units.SI.Current Ch2I1(start=0)=dcdc.Ch2I1 "input current CH2";
  Controller.TwoCHDiodeModeController
                        twoCHDiodeModeController(
    VLV=BiChopperData.VLV,
    VHV=BiChopperData.VHV,
    k=BiChopperData.kDiodeMode,
    Ti=BiChopperData.TiDiodeMode,
    wp=BiChopperData.wpDiodeMode)
    annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
  TwoCHBuckBoost dcdc(
    UseExtEnable=UseExtEnable,
    EnableCH1=EnableCH1,
    EnableCH2=EnableCH2,
    fS=BiChopperData.fS,
    L=BiChopperData.L,
    R=BiChopperData.R,
    TRef=BiChopperData.TRef,
    CLV=BiChopperData.CLV,
    CHV=BiChopperData.CHV,
    RonTransistor=BiChopperData.RonTransistor,
    GoffTransistor=BiChopperData.GoffTransistor,
    VkneeTransistor=BiChopperData.VkneeTransistor,
    RonDiode=BiChopperData.RonDiode,
    GoffDiode=BiChopperData.GoffDiode,
    VkneeDiode=BiChopperData.VkneeDiode)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.RealExpression vLV1(y=pin_pLV.v)
    annotation (Placement(transformation(extent={{-80,80},{-60,100}})));
  Modelica.Blocks.Sources.RealExpression iLV1(y=pin_pLV.i)
    annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
  Modelica.Blocks.Sources.RealExpression pLV(y=iLV1.y*vLV1.y)
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Modelica.Blocks.Sources.RealExpression vHV1(y=pin_pHV.v)
    annotation (Placement(transformation(extent={{80,80},{60,100}})));
  Modelica.Blocks.Sources.RealExpression iHV(y=pin_pHV.i)
    annotation (Placement(transformation(extent={{80,50},{60,70}})));
  Modelica.Blocks.Sources.RealExpression pHV(y=iHV.y*vHV1.y)
    annotation (Placement(transformation(extent={{80,20},{60,40}})));
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
        origin={42,-84})));
  Modelica.Blocks.Logical.Switch switch1 annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={30,-50})));
  Modelica.Blocks.Math.Gain gain(k=0.5) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={70,-30})));
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
equation
    if not UseExtEnable then
         switch1.u2=EnableCH1 and EnableCH2;
  end if;
  connect(dcdc.dc_n1, pin_nLV) annotation (Line(points={{-10,-6},{-100,-6},{
          -100,-60}},  color={0,0,255}));
  connect(dcdc.dc_p1, pin_pLV) annotation (Line(points={{-10,6},{-100,6},{-100,
          60}},       color={0,0,255}));
  connect(dcdc.dc_p2, pin_pHV)
    annotation (Line(points={{10,6},{100,6},{100,60}},          color={0,0,255}));
  connect(dcdc.dc_n2, pin_nHV) annotation (Line(points={{10,-6},{100,-6},{100,
          -60}},     color={0,0,255}));
  connect(twoCHDiodeModeController.DirectionPin, DirectionPin)
    annotation (Line(points={{-6,-42},{-6,-60},{-60,-60},{-60,-120}}, color={0,0,127}));
  connect(dcdc.ILVCH1, twoCHDiodeModeController.measuredCurrentCH1)
    annotation (Line(points={{-8,-11},{-8,-18}}, color={0,0,127}));
  connect(dcdc.ILVCH2, twoCHDiodeModeController.measuredCurrentCH2)
    annotation (Line(points={{-4,-11},{-4,-18}}, color={0,0,127}));
  connect(dcdc.Direction, twoCHDiodeModeController.boostmode)
    annotation (Line(points={{0,-12},{0,-19}}, color={255,0,255}));
  connect(dcdc.dutyCycleCH2, twoCHDiodeModeController.yCH2)
    annotation (Line(points={{4,-12},{4,-19}}, color={0,0,127}));
  connect(dcdc.dutyCycleCH1, twoCHDiodeModeController.yCH1)
    annotation (Line(points={{8,-12},{8,-19}}, color={0,0,127}));
  connect(and1.y, switch1.u2)
    annotation (Line(points={{53,-84},{60,-84},{60,-50},{42,-50}}, color={255,0,255}));
  connect(switch1.u1, gain.y)
    annotation (Line(points={{42,-42},{50,-42},{50,-30},{59,-30}},
                                                          color={0,0,127}));
  connect(gain.u, ISETA) annotation (Line(points={{82,-30},{84,-30},{84,-90},{60,-90},{60,-120}},
        color={0,0,127}));
  connect(switch1.u3, ISETA) annotation (Line(points={{42,-58},{84,-58},{84,-90},{60,-90},{
          60,-120}}, color={0,0,127}));
  connect(switch1.y, twoCHDiodeModeController.DutyCycle)
    annotation (Line(points={{19,-50},{6,-50},{6,-42}}, color={0,0,127}));
  connect(CH2Enable, and1.u2)
    annotation (Line(points={{20,-120},{20,-92},{30,-92}}, color={255,0,255}));
  connect(CH2Enable, dcdc.CH2Enable) annotation (Line(points={{20,-120},{20,-64},
          {12,-64},{12,-44},{14,-44},{14,18},{4,18},{4,12}}, color={255,0,255}));
  connect(CH1Enable, dcdc.CH1Enable) annotation (Line(points={{-20,-120},{-20,
          18},{-4,18},{-4,12}}, color={255,0,255}));
  connect(CH1Enable, and1.u1) annotation (Line(points={{-20,-120},{-20,-84},{30,
          -84}}, color={255,0,255}));
  connect(vLV1.y, mean_vLV.u)
    annotation (Line(points={{-59,90},{-52,90}}, color={0,0,127}));
  connect(iLV1.y, mean_iLV.u)
    annotation (Line(points={{-59,60},{-52,60}}, color={0,0,127}));
  connect(pLV.y, mean_pLV.u)
    annotation (Line(points={{-59,30},{-52,30}}, color={0,0,127}));
  connect(pHV.y, mean_pHV.u)
    annotation (Line(points={{59,30},{52,30}}, color={0,0,127}));
  connect(iHV.y, mean_iHV.u)
    annotation (Line(points={{59,60},{52,60}}, color={0,0,127}));
  connect(vHV1.y, mean_vHV.u)
    annotation (Line(points={{59,90},{52,90}}, color={0,0,127}));
  annotation (defaultComponentName="dcdc",Icon(graphics={
        Line(points={{-60,-112},{-60,-80},{38,-80},{38,-36}}, color={0,0,0}),
        Line(points={{60,-114},{60,-80}}, color={0,0,0}),
        Line(points={{60,-80},{62,-80},{68,-80},{68,-44}}, color={0,0,0}),
                                                        Line(
          points={{0,-25},{0,-15},{20,-15},{-20,-15},{-4,-15},{-20,1},{-8,-5},{-14,
              -11},{-20,1},{-24,5},{-130,5},{-24,5},{-24,15},{8,15},{-8,5},{-8,25},
              {8,15},{8,5},{8,25},{8,15},{24,15},{24,5},{50,5},{24,5},{4,-15}},
          color={238,46,47},
          origin={40,55},
          rotation=360),
                   Line(points={{10,0},{0,0},{0,20},{0,-20},{0,-4},{-16,-20},{-10,-8},
              {-4,-14},{-16,-20},{-20,-24},{-20,-60},{-20,-24},{-30,-24},{-30,8},{-20,
              -8},{-40,-8},{-30,8},{-20,8},{-40,8},{-30,8},{-30,24},{-20,24},{-20,60},
              {-20,24},{0,4}},     color={238,46,47}),
        Line(points={{-90,-60},{90,-60}}, color={238,46,47})}));
end ControlledBuckBoost;
