* full adder with header and footer 3NAND dynamic

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

*Header Transistor Added
* mosfet mname D G S B modelname params...
mp4 xouth head vdd vdd pmos L={Lp} W={Wp} AD={Wp*lambda*Lp} AS={Wp*lambda*Lp}
+ PD={Wp+2*lambda*Lp} PS={Wp+2*lambda*Lp}

*Footer Transistor Added
* mosfet mname D G S B modelname params...
mn4 xoutf tail 0 0 nmos L={Ln} W={Wn} AD={Wn*lambda*Ln} AS={Wn*lambda*Ln}
+ PD={Wn+2*lambda*Ln} PS={Wn+2*lambda*Ln}

*Cout Part
X1  a a cin out1 xouth xoutf NAND3
X2  a a b   out2 xouth xoutf NAND3
X3  b b cin out3 xouth xoutf NAND3
X4  out1 out2 out3 out4 xouth xoutf NAND3


*Sum Part
X5 a a a out5 xouth xoutf NAND3
X6 b b b out6 xouth xoutf NAND3
X7 cin cin cin out7 xouth xoutf NAND3

X8  out5 out6 cin out8 xouth xoutf NAND3
X9  out5 b out7 out9 xouth xoutf NAND3
X10  a out6 out7 out10 xouth xoutf NAND3
X11  a b cin out11 xouth xoutf NAND3

X12  out9 out10 out11 out12 xouth xoutf NAND3
X13  out12 out12 out12 out13 xouth xoutf NAND3
X14  out8 out8 out13 out14 xouth xoutf NAND3

*dynamic input for full adder

*a
v1 a 0 PWL(0 1.1)
*b
v2 b 0 PWL(0 1.1)
*cin
v3 cin 0 PWL(0 1.1)

*header transistor input
v4 head 0 PWL(0 1.1)

*footer transistor input
v5 tail 0 PWL(0 0)

.tran 0 10n

.measure tran totalpower AVG I(Vmain)*V(vdd) from=0 to=10n
.end

