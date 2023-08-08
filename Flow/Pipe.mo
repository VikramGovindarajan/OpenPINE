within Flow;

model Pipe

  extends Modelica.Fluid.Interfaces.PartialTwoPort;

	import SI=Modelica.Units.SI;

    replaceable package Medium =
      Modelica.Media.Interfaces.PartialMedium "Medium in the component";

	parameter SI.Length length "Length";
	parameter SI.Diameter diameter "Diameter of circular pipe";
	
	Real m_flow;
	SI.Pressure delp_fr;
	SI.Pressure dp;
    SI.Area crossArea=Modelica.Constants.pi*diameter*diameter/4;
	
equation
	delp_fr = 0.05 * length * m_flow * abs(m_flow) / (2.*diameter * 1000 * crossArea * crossArea);
	dp = port_a.p - port_b.p;

	0 = dp + delp_fr ;

	port_a.m_flow = - m_flow;
    0 = port_a.m_flow + port_b.m_flow;
	

	port_a.h_outflow = 1;
    0 = port_a.h_outflow + port_b.h_outflow;
	
end Pipe;
