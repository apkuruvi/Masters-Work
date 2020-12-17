* inverter dynamic

.lib 45nm_MGK.pm
.param tech = 45e-9
.param lambda = 2
.param Wp = {4.5*tech}
.param Lp = {tech}
.param Wn = {2*tech}
.param Ln = {tech}
.param Freq = 1e9
.param frequency = 1e9
.param Trise = 2ps
.param Tfall = 2ps
.param Ton = {1/Freq/2}
.param Tperiod = {1/Freq}
.param Ncycles = 2

.options temp=25


* vsupply = 1.1 V for 45 nm
.param vsupply = 1.1

* power for the logic circuit under test
Vmain vdd 0 dc {vsupply}

* subcircuit for inverter
.subckt inverter xin xout xvdd xvss
* mosfet mname D G S B modelname params...
mp1 xout xin xvdd xvdd pmos L={Lp} W={Wp} AD={Wp*lambda*Lp} AS={Wp*lambda*Lp}
+ PD={Wp+2*lambda*Lp} PS={Wp+2*lambda*Lp}
mn1 xout xin xvss xvss nmos L={Ln} W={Wn} AD={Wn*lambda*Ln} AS={Wn*lambda*Ln}
+ PD={Wn+2*lambda*Ln} PS={Wn+2*lambda*Ln}
.ends

* test inverter
X1 in out vdd 0 inverter

* dynamic input
*Vin1 in 0 DC PULSE(0.0 {vsupply} {Tperiod/2} {Trise} {Tfall} {Ton} {Tperiod}{Ncycles})

Vtest in 0 DC PULSE(0.0 {1.1} {1/(2*frequency)} {2p} {2p} {1/(2*frequency)} {1/frequency} {2})
*Vtest in 0 DC PULSE(0.0 {1.1} {0.5ns} {0} {0} {0.5ns} {1.0ns})

.tran 0 {Ncycles*Tperiod}
*.tran 0 {2*Ncycles*Tperiod}


.measure tran totalpower AVG I(Vmain)*V(vdd) from=0 to={Ncycles*Tperiod}

.measure tran tpHL trig v(in) val='1.1/2' RISE=1 targ v(out) val='1.1/2' FALL=1

.measure tran tpLH trig v(in) val='1.1/2' FALL=1 targ v(out) val='1.1/2' RISE=1

.end
