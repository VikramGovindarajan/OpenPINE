
model Tutorial1		

   replaceable package Medium =
      Modelica.Media.Water.StandardWater                           constrainedby
    Modelica.Media.Interfaces.PartialMedium "Medium in the component";

// node inputs
  Flow.Reservoir reservoir1(
    redeclare package Medium = Medium,
    nPorts=1,
	crossArea=1,
	height=10);
  Flow.Reservoir reservoir2(
    redeclare package Medium = Medium,
    nPorts=1,
	crossArea=1,
	height=10);

// pipe inputs
  Flow.Pipe pipe1(
    redeclare package Medium = Medium,
    length=2,
    diameter=0.1);

  inner Modelica.Fluid.System system(energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial);

initial equation
	reservoir1.level = 2;
	reservoir2.level = 8;

equation
  connect(reservoir1.ports[1],pipe1.port_a);
  connect(pipe1.port_b, reservoir2.ports[1]);

end Tutorial1;
