within BiChopper.Switching.PWMmode;
type SingleReferenceType = enumeration(
    Sawtooth  "Sawtooth",
    Triangle  "Triangle") "Enumeration defining the type of reference signal"
                                                        annotation (
    Documentation(info="<html>
<p>
Used in SignalPWM to clearify the Waveform
</p>
</html>"));
