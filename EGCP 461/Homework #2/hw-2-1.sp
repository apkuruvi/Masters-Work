* full adder NAND dynamic

.lib 45nm_MGK.pm
.param tech = 45e-9
.param lambda = 2
.param PNWL = 3.325
.param Wp = {PNWL*tech}
.param Lp = {tech}
.param Wn = {3*tech}
.param Ln = {tech}
.options temp=25


* vsupply = 1.1 V for 45 nm
.param vsupply = 1.1

* power for the logic circuit under test
Vmain vdd 0 dc {vsupply}

* subcircuit for 2 input NAND
.subckt NAND xin xin2 xout xvdd xvss
mp1 xout xin xvdd xvdd pmos L={Lp} W={Wp} AD={Wp*lambda*Lp} AS={Wp*lambda*Lp}
+ PD={Wp+2*lambda*Lp} PS={Wp+2*lambda*Lp}
mp2 xout xin2 xvdd xvdd pmos L={Lp} W={Wp} AD={Wp*lambda*Lp} AS={Wp*lambda*Lp}
+ PD={Wp+2*lambda*Lp} PS={Wp+2*lambda*Lp}
mn1 xout xin xvss1 xvss nmos L={Ln} W={Wn} AD={Wn*lambda*Ln} AS={Wn*lambda*Ln}
+ PD={Wn+2*lambda*Ln} PS={Wn+2*lambda*Ln}
mn2 xvss1 xin2 xvss xvss nmos L={Ln} W={Wn} AD={Wn*lambda*Ln} AS={Wn*lambda*Ln}
+ PD={Wn+2*lambda*Ln} PS={Wn+2*lambda*Ln}
.ends

* subcircuit for 3 input NAND
.subckt NAND3 xin xin2 xin3 xout xvdd xvss
mp1 xout xin xvdd xvdd pmos L={Lp} W={Wp} AD={Wp*lambda*Lp} AS={Wp*lambda*Lp}
+ PD={Wp+2*lambda*Lp} PS={Wp+2*lambda*Lp}
mp2 xout xin2 xvdd xvdd pmos L={Lp} W={Wp} AD={Wp*lambda*Lp} AS={Wp*lambda*Lp}
+ PD={Wp+2*lambda*Lp} PS={Wp+2*lambda*Lp}
mp3 xout xin3 xvdd xvdd pmos L={Lp} W={Wp} AD={Wp*lambda*Lp} AS={Wp*lambda*Lp}
+ PD={Wp+2*lambda*Lp} PS={Wp+2*lambda*Lp}
mn1 xout xin xvss1 xvss nmos L={Ln} W={Wn} AD={Wn*lambda*Ln} AS={Wn*lambda*Ln}
+ PD={Wn+2*lambda*Ln} PS={Wn+2*lambda*Ln}
mn2 xvss1 xin2 xvss2 xvss nmos L={Ln} W={Wn} AD={Wn*lambda*Ln} AS={Wn*lambda*Ln}
+ PD={Wn+2*lambda*Ln} PS={Wn+2*lambda*Ln}
mn3 xvss2 xin3 xvss xvss nmos L={Ln} W={Wn} AD={Wn*lambda*Ln} AS={Wn*lambda*Ln}
+ PD={Wn+2*lambda*Ln} PS={Wn+2*lambda*Ln}
.ends

*Cout Part
X1  a cin out1 vdd 0 NAND
X2  a b   out2 vdd 0 NAND
X3  b cin out3 vdd 0 NAND
X4  out1 out2 out3 out4 vdd 0 NAND3
c1 out4 0 3f

*Sum Part
X5 a a out5 vdd 0 NAND
X6 b b out6 vdd 0 NAND
X7 cin cin out7 vdd 0 NAND

X8  out5 out6 cin out8 vdd 0 NAND3
X9  out5 b out7 out9 vdd 0 NAND3
X10  a out6 out7 out10 vdd 0 NAND3
X11  a b cin out11 vdd 0 NAND3

X12  out8 out9 out12 vdd 0 NAND
X13  out10 out11 out13 vdd 0 NAND

X14 out12 out12 out14 vdd 0 NAND
X15 out13 out13 out15 vdd 0 NAND

X16  out14 out15 out16 vdd 0 NAND
c2 out16 0 3f


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
