
--- @interface Voxrame.map.room.Connector
--- @field floor_center  fun(self: self): PositionVector  Returns center position of the connector on the floor
--- @field get_direction fun(self: self): PositionVector  Returns direction of the connector
--- @field connect       fun(self: self, connectable: Voxrame.map.room.Connectable): self

--- @interface Voxrame.map.room.Connectable
--- @field connect_to fun(self: self, connector: Voxrame.map.room.Connector): self
