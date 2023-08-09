within Flow;

model Pipe

    extends Modelica.Fluid.Interfaces.PartialTwoPort;

	import SI=Modelica.Units.SI;

    replaceable package Medium =
      Modelica.Media.Interfaces.PartialMedium "Medium in the component";

	parameter SI.Length length "Length";

	SI.Diameter diameter "Diameter of circular pipe";
	SI.MassFlowRate m_flow;
	SI.Pressure delp_fr;
	SI.Pressure delp_gr;
	SI.Pressure del_p;
    SI.Area crossArea=Modelica.Constants.pi*diameter*diameter/4;
	SI.Density rho;
	SI.Length heights_ab;
	Real fricfact;
	Real Ih(unit = "/m");
	
equation
	
	fricfact = 0.05;
	rho = 1000;
	heights_ab = 0;

	del_p = port_a.p - port_b.p;
	delp_fr = fricfact * length * m_flow * abs(m_flow) / (2. * diameter * rho * crossArea * crossArea);
    delp_gr = rho*Modelica.Constants.g_n*heights_ab;
	Ih = length / crossArea;

	del_p + delp_fr = -Ih * der(m_flow);

	port_a.m_flow = - m_flow;
    0 = port_a.m_flow + port_b.m_flow;

	port_a.h_outflow = 1;
    0 = port_a.h_outflow + port_b.h_outflow;

initial equation
	
	der(m_flow) = 0;
	
end Pipe;
