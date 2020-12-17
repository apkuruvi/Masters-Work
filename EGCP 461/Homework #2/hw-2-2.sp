* full adder NOR dynamic

.lib 45nm_MGK.pm
.param tech = 45e-9
.param lambda = 2
.param PNWL = 3.325
.param Wp = {3*PNWL*tech}
.param Lp = {tech}
.param Wn = {tech}
.param Ln = {tech}
.options temp=25


* vsupply = 1.1 V for 45 nm
.param vsupply = 1.1

* power for the logic circuit under test
Vmain vdd 0 dc {vsupply}

* subcircuit for NOR
.subckt NOR xin xin2 xout xvdd xvss
mp1 xout1 xin xvdd xvdd pmos L={Lp} W={Wp} AD={Wp*lambda*Lp} AS={Wp*lambda*Lp}
+ PD={Wp+2*lambda*Lp} PS={Wp+2*lambda*Lp}
mp2 xout xin2 xout1 xvdd pmos L={Lp} W={Wp} AD={Wp*lambda*Lp} AS={Wp*lambda*Lp}
+ PD={Wp+2*lambda*Lp} PS={Wp+2*lambda*Lp}
mn1 xout xin xvss xvss nmos L={Ln} W={Wn} AD={Wn*lambda*Ln} AS={Wn*lambda*Ln}
+ PD={Wn+2*lambda*Ln} PS={Wn+2*lambda*Ln}
mn2 xout xin2 xvss xvss nmos L={Ln} W={Wn} AD={Wn*lambda*Ln} AS={Wn*lambda*Ln}
+ PD={Wn+2*lambda*Ln} PS={Wn+2*lambda*Ln}
.ends

* subcircuit for 3 input NOR
.subckt NOR3 xin xin2 xin3 xout xvdd xvss
mp1 xout1 xin xvdd xvdd pmos L={Lp} W={Wp} AD={Wp*lambda*Lp} AS={Wp*lambda*Lp}
+ PD={Wp+2*lambda*Lp} PS={Wp+2*lambda*Lp}
mp2 xout2 xin2 xout1 xvdd pmos L={Lp} W={Wp} AD={Wp*lambda*Lp} AS={Wp*lambda*Lp}
+ PD={Wp+2*lambda*Lp} PS={Wp+2*lambda*Lp}
mp3 xout xin3 xout2 xvdd pmos L={Lp} W={Wp} AD={Wp*lambda*Lp} AS={Wp*lambda*Lp}
+ PD={Wp+2*lambda*Lp} PS={Wp+2*lambda*Lp}
mn1 xout xin xvss xvss nmos L={Ln} W={Wn} AD={Wn*lambda*Ln} AS={Wn*lambda*Ln}
+ PD={Wn+2*lambda*Ln} PS={Wn+2*lambda*Ln}
mn2 xout xin2 xvss xvss nmos L={Ln} W={Wn} AD={Wn*lambda*Ln} AS={Wn*lambda*Ln}
+ PD={Wn+2*lambda*Ln} PS={Wn+2*lambda*Ln}
mn3 xout xin3 xvss xvss nmos L={Ln} W={Wn} AD={Wn*lambda*Ln} AS={Wn*lambda*Ln}
+ PD={Wn+2*lambda*Ln} PS={Wn+2*lambda*Ln}
.ends

* test full adder

*Cout Part
X1 a a  out1 vdd 0 NOR
X2 b b out2 vdd 0 NOR
X3 cin cin out3 vdd 0 NOR

X4 out1 out3 out4 vdd 0 NOR
X5 out1 out2 out5 vdd 0 NOR
X6 out2 out3 out6 vdd 0 NOR

X7 out4 out5 out6 out7 vdd 0 NOR3
X8 out7 out7 out8 vdd 0 NOR
c1 out8 0 3f


*Sum Part

X9  out1 out1 out9  vdd 0 NOR
X10 out2 out2 out10 vdd 0 NOR
X11 out3 out3 out11 vdd 0 NOR

X12 out9 out10 out3 out12 vdd 0 NOR3
X13 out9 out2 out11 out13 vdd 0 NOR3
X14 out1 out10 out11 out14 vdd 0 NOR3
X15 out1 out2 out3 out15 vdd 0 NOR3


X16 out12 out13 out16 vdd 0 NOR
X17 out14 out15 out17 vdd 0 NOR

X18 out16 out16 out18 vdd 0 NOR
X19 out17 out17 out19 vdd 0 NOR

X20 out18 out19 out20 vdd 0 NOR
X21 out20 out20 out21 vdd 0 NOR

c2 out21 0 3f


*dynamic input for full adder

*a
v1 a 0 PWL(0 0 0.995n 0 1.005n {vsupply} 1.995n {vsupply} 2.005n 0 3.995n 0 4.005n
+ {vsupply} 5.995n {vsupply} 6.005n 0
+ 6.995n 0 7.005n {vsupply} 7.995n {vsupply} 8.005n 0)
*b
v2 b 0 PWL(0 0 2.995n 0 3.005n {vsupply} 4.995n {vsupply} 5.005n 0 5.995n 0 6.005n
+ {vsupply} 8.995n {vsupply} 9.005n 0)
*cin
v3 cin 0 PWL(0 0 1.995n 0 2.005n {vsupply} 3.995n {vsupply} 4.005n 0)


.tran 0 10n

.measure tran totalpower AVG I(Vmain)*V(vdd) from=0 to=10n
.end
