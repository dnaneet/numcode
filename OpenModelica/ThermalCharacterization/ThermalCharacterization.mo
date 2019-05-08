model ThermalCharacterization
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor1(C = 1000)  annotation(
    Placement(visible = true, transformation(origin = {2, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.Convection convection1 annotation(
    Placement(visible = true, transformation(origin = {-24, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor1 annotation(
    Placement(visible = true, transformation(origin = {58, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Celsius.FixedTemperature fixedTemperature1(T = 22)  annotation(
    Placement(visible = true, transformation(origin = {-68, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow1(Q_flow = 100)  annotation(
    Placement(visible = true, transformation(origin = {-62, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const annotation(
    Placement(visible = true, transformation(origin = {-62, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor1(G = 5)  annotation(
    Placement(visible = true, transformation(origin = {38, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Thermal.HeatTransfer.Celsius.FixedTemperature fixedTemperature2(T = 22) annotation(
    Placement(visible = true, transformation(origin = {82, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
equation
  connect(heatCapacitor1.port, convection1.fluid) annotation(
    Line(points = {{2, -6}, {2, -6}, {2, -36}, {-12, -36}, {-12, -36}}, color = {191, 0, 0}));
  connect(heatCapacitor1.port, temperatureSensor1.port) annotation(
    Line(points = {{2, -6}, {46, -6}, {46, -8}, {46, -8}}, color = {191, 0, 0}));
  connect(fixedTemperature1.port, convection1.solid) annotation(
    Line(points = {{-54, -34}, {-34, -34}, {-34, -34}, {-34, -34}, {-34, -34}}, color = {191, 0, 0}));
  connect(fixedHeatFlow1.port, heatCapacitor1.port) annotation(
    Line(points = {{-52, 16}, {-26, 16}, {-26, -6}, {2, -6}, {2, -6}}, color = {191, 0, 0}));
  connect(const.y, convection1.Gc) annotation(
    Line(points = {{-50, -6}, {-24, -6}, {-24, -24}, {-24, -24}}, color = {0, 0, 127}));
  connect(thermalConductor1.port_b, heatCapacitor1.port) annotation(
    Line(points = {{28, -50}, {10, -50}, {10, -6}, {2, -6}, {2, -6}}, color = {191, 0, 0}));
  connect(fixedTemperature2.port, thermalConductor1.port_a) annotation(
    Line(points = {{72, -50}, {48, -50}, {48, -50}, {48, -50}}, color = {191, 0, 0}));
  annotation(
    uses(Modelica(version = "3.2.2")));end ThermalCharacterization;