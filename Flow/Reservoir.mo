within Flow;

model Reservoir

  // outer Modelica.Fluid.System system "System properties";
  replaceable package Medium =
    Modelica.Media.Interfaces.PartialMedium "Medium in the component";

  // Port definitions
  parameter Integer nPorts=0 "Number of ports";
  parameter Real height;
  parameter Real crossArea;
  Real V;
  Real p_ambient;
  Real level;

  Modelica.Fluid.Interfaces.FluidPort ports[nPorts](redeclare each package Medium = Medium)
  "Fluid inlets and outlets";

equation
  
  V = crossArea*level;
  p_ambient = 1E5;

  //Determine port properties
  for i in 1:nPorts loop
    ports[i].p = max(0, level)*9.81*1000. + p_ambient;
  end for;

  der(V * 1000) = ports[1].m_flow;
  
  ports[1].h_outflow = 1;

end Reservoir;
