within Flow;

model Pipe

    extends Modelica.Fluid.Interfaces.PartialTwoPort;

	import SI=Modelica.Units.SI;

    replaceable package Medium =
      Modelica.Media.Interfaces.PartialMedium "Medium in the component";

	parameter SI.Length length "Length";
	parameter SI.Diameter diameter "Diameter of circular pipe";

	SI.MassFlowRate m_flow;
	SI.Pressure delp_fr;
	SI.Pressure delp_gr;
	SI.Pressure del_p;
    SI.Area crossArea=Modelica.Constants.pi*diameter*diameter/4;
	SI.Length heights_ab;
	Real fricfact "Friction Factor";
	Real Ih(unit = "/m") "Hydraulic Inertia";
	parameter Integer n=2 "Number of discrete flow volumes";
	input Medium.ThermodynamicState[n] states = 
		{Medium.setState_phX(port_a.p, inStream(port_a.h_outflow), inStream(port_a.Xi_outflow)),
		 Medium.setState_phX(port_b.p, inStream(port_b.h_outflow), inStream(port_b.Xi_outflow))};
	Medium.Density[n] rhos = Medium.density(states);
	Medium.Density[n-1] rhos_act "Actual density per segment";
	
equation
	
	fricfact = 0.05;
    rhos_act = 0.5*(rhos[1:n-1] + rhos[2:n]);
	heights_ab = 0;

	del_p = port_a.p - port_b.p;
	delp_fr = fricfact * length * m_flow * abs(m_flow) / (2. * diameter * rhos_act[1] * crossArea * crossArea);
    delp_gr = rhos_act[1]*Modelica.Constants.g_n*heights_ab;
	Ih = length / crossArea;

	Ih * der(m_flow) + del_p + delp_fr = 0;

	port_a.m_flow = - m_flow;
    0 = port_a.m_flow + port_b.m_flow;

	port_a.h_outflow = port_b.h_outflow;
    0 = actualStream(port_a.h_outflow) + actualStream(port_b.h_outflow);

initial equation
	
	der(m_flow) = 0;
	
end Pipe;
