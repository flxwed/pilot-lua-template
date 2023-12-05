--[[
  MIT License
  
  Copyright (c) 2023 HuCares_
  
  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:
  
  The above copyright notice and this permission notice shall be included in all
  copies or substantial portions of the Software.
  
  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  SOFTWARE.

  https://github.com/flxwed/autopilot.lua/
--]]

-- Utility Types
type PortLike = number | {GUID: string}
type Iterator<K, V> = () -> (K, V)
-- Microcontroller Types
type EventConnection = {
    Unbind: (self: EventConnection) -> ()
}
type ScreenObject = {
    ChangeProperties: (self: ScreenObject, properties: {[string]: any}) -> (),
    AddChild: (self: ScreenObject, child: ScreenObject) -> (),
    Destroy: (self: ScreenObject) -> ()
}
type Cursor = {
    X: number,
    Y: number,
    Player: string,
    Pressed: boolean
}
type RegionInfo = {
    Type: "Planet",
    SubType: nil,
    Name: string,
    TidallyLocked: boolean,
    HasRings: boolean,
    BeaconCount: number
} | {
    Type: "Planet",
    SubType: "Desert" | "Terra" | "EarthLike" | "Ocean" | "Tundra" | "Forest" | "Exotic" | "Barren" | "Gas",
    Name: string,
    Color: Color3,
    Resources: { string },
    Gravity: number,
    HasAtmosphere: boolean,
    TidallyLocked: boolean,
    HasRings: boolean,
    BeaconCount: number
} | {
    Type: "BlackHole",
    Name: string,
    Size: number,
    BeaconCount: number
} | {
    Type: "Star",
    SubType: "Red" | "Orange" | "Yellow" | "Blue" | "Neutron",
    Name: string,
    Size: number,
    BeaconCount: number
}
type RegionLog = {
    {
        Event: "HyperDrive" | "Aliens" | "Spawned" | "Death" | "ExitRegion" | "Poison" | "Irradiated" | "Suffocating" | "Freezing" | "Melting",
        Desc: string,
        TimeAgo: number
    }
}
-- Part Types
type Part = {
    Trigger: (self: Part) -> (),
    Configure: (self: Part, properties: {}) -> (),
    ClassName: string,
    Position: Vector2,
    CFrame: CFrame,
    GUID: string,
    Connect: ((self: Part, event: "Triggered", callback: () -> ()) -> EventConnection)
        & ((self: Part, event: "Configured", callback: () -> ()) -> EventConnection)
}
type Gyro = {
    PointAt: (self: Gyro, position: Vector3) -> (),
    Trigger: (self: Gyro) -> (),
    Configure: (self: Gyro, properties: {Seek: string?, DisableWhenUnpowered: boolean?, MaxTorque: Vector3?, TriggerWhenSeeked: boolean?}) -> (),
    Seek: string,
    DisableWhenUnpowered: boolean,
    MaxTorque: Vector3,
    TriggerWhenSeeked: boolean,
    ClassName: string,
    Position: Vector2,
    CFrame: CFrame,
    GUID: string,
    Connect: ((self: Gyro, event: "Triggered", callback: () -> ()) -> EventConnection)
        & ((self: Gyro, event: "Configured", callback: () -> ()) -> EventConnection)
}
type Keyboard = {
    SimulateKeyPress: (self: Keyboard, key: string?, player: string) -> (),
    SimulateTextInput: (self: Keyboard, input: string?, player: string) -> (),
    Trigger: (self: Keyboard) -> (),
    Configure: (self: Keyboard, properties: {}) -> (),
    ClassName: string,
    Position: Vector2,
    CFrame: CFrame,
    GUID: string,
    Connect: ((self: Keyboard, event: "KeyPressed", callback: (key: Enum.KeyCode, keyString: string, state: Enum.UserInputState, player: string) -> ()) -> EventConnection)
        & ((self: Keyboard, event: "TextInputted", callback: (text: string, player: string) -> ()) -> EventConnection)
        & ((self: Keyboard, event: "Triggered", callback: () -> ()) -> EventConnection)
        & ((self: Keyboard, event: "Configured", callback: () -> ()) -> EventConnection)
}
type Microphone = {
    Trigger: (self: Microphone) -> (),
    Configure: (self: Microphone, properties: {}) -> (),
    ClassName: string,
    Position: Vector2,
    CFrame: CFrame,
    GUID: string,
    Connect: ((self: Microphone, event: "Chatted", callback: (player: string, message: string) -> ()) -> EventConnection)
        & ((self: Microphone, event: "Triggered", callback: () -> ()) -> EventConnection)
        & ((self: Microphone, event: "Configured", callback: () -> ()) -> EventConnection)
}
type LifeSensor = {
    GetReading: (self: LifeSensor) -> {[string]: Vector3},
    Trigger: (self: LifeSensor) -> (),
    Configure: (self: LifeSensor, properties: {}) -> (),
    ClassName: string,
    Position: Vector2,
    CFrame: CFrame,
    GUID: string,
    Connect: ((self: LifeSensor, event: "Triggered", callback: () -> ()) -> EventConnection)
        & ((self: LifeSensor, event: "Configured", callback: () -> ()) -> EventConnection)
}
type Instrument = {
    GetReading: (self: Instrument, typeId: number) -> number | Vector3,
    Trigger: (self: Instrument) -> (),
    Configure: (self: Instrument, properties: {Type: number?}) -> (),
    Type: number,
    ClassName: string,
    Position: Vector2,
    CFrame: CFrame,
    GUID: string,
    Connect: ((self: Instrument, event: "Triggered", callback: () -> ()) -> EventConnection)
        & ((self: Instrument, event: "Configured", callback: () -> ()) -> EventConnection)
}
type EnergyShield = {
    GetShieldHealth: (self: EnergyShield) -> number,
    Trigger: (self: EnergyShield) -> (),
    Configure: (self: EnergyShield, properties: {ShieldStrength: number?, RegenerationSpeed: number?, ShieldRadius: number?}) -> (),
    ShieldStrength: number,
    RegenerationSpeed: number,
    ShieldRadius: number,
    ClassName: string,
    Position: Vector2,
    CFrame: CFrame,
    GUID: string,
    Connect: ((self: EnergyShield, event: "Triggered", callback: () -> ()) -> EventConnection)
        & ((self: EnergyShield, event: "Configured", callback: () -> ()) -> EventConnection)
}
type Disk = {
    ClearDisk: (self: Disk) -> (),
    Write: (self: Disk, key: string, data: string) -> (),
    Read: (self: Disk, key: string) -> string,
    ReadEntireDisk: (self: Disk) -> {[string]: string},
    Trigger: (self: Disk) -> (),
    Configure: (self: Disk, properties: {ShieldStrength: number?, RegenerationSpeed: number?, ShieldRadius: number?}) -> (),
    ShieldStrength: number,
    RegenerationSpeed: number,
    ShieldRadius: number,
    ClassName: string,
    Position: Vector2,
    CFrame: CFrame,
    GUID: string,
    Connect: ((self: Disk, event: "Triggered", callback: () -> ()) -> EventConnection)
        & ((self: Disk, event: "Configured", callback: () -> ()) -> EventConnection)
}
type Bin = {
    GetAmount: (self: Bin) -> number,
    GetResource: (self: Bin) -> string,
    Trigger: (self: Bin) -> (),
    Configure: (self: Bin, properties: {}) -> (),
    ClassName: string,
    Position: Vector2,
    CFrame: CFrame,
    GUID: string,
    Connect: ((self: Bin, event: "Triggered", callback: () -> ()) -> EventConnection)
        & ((self: Bin, event: "Configured", callback: () -> ()) -> EventConnection)
}
type Container = {
    GetAmount: (self: Container) -> number,
    GetResource: (self: Container) -> string,
    Trigger: (self: Container) -> (),
    Configure: (self: Container, properties: {}) -> (),
    ClassName: string,
    Position: Vector2,
    CFrame: CFrame,
    GUID: string,
    Connect: ((self: Container, event: "Triggered", callback: () -> ()) -> EventConnection)
        & ((self: Container, event: "Configured", callback: () -> ()) -> EventConnection)
}
type Modem = {
    PostRequest: (self: Modem, domain: string, data: string) -> (),
    GetRequest: (self: Modem, domain: string) -> string,
    SendMessage: (self: Modem, data: string, id: number) -> (),
    RealPostRequest: (self: Modem, domain: string, data: string, asyncBool: boolean, transformFunction: (...any) -> (), optionalHeaders: {[string]: any}?) -> {response: string, success: boolean},
    Trigger: (self: Modem) -> (),
    Configure: (self: Modem, properties: {NetworkID: number?}) -> (),
    NetworkID: number,
    ClassName: string,
    Position: Vector2,
    CFrame: CFrame,
    GUID: string,
    Connect: ((self: Modem, event: "MessageSent", callback: (data: string) -> ()) -> EventConnection)
        & ((self: Modem, event: "Triggered", callback: () -> ()) -> EventConnection)
        & ((self: Modem, event: "Configured", callback: () -> ()) -> EventConnection)
}
type Screen = {
    GetDimensions: (self: Screen) -> Vector2,
    ClearElements: (self: Screen, className: string?, properties: {[string]: any}?) -> (),
    CreateElement: (self: Screen, className: string, properties: {[string]: any}) -> ScreenObject,
    Trigger: (self: Screen) -> (),
    Configure: (self: Screen, properties: {VideoID: number?}) -> (),
    VideoID: number,
    ClassName: string,
    Position: Vector2,
    CFrame: CFrame,
    GUID: string,
    Connect: ((self: Screen, event: "Triggered", callback: () -> ()) -> EventConnection)
        & ((self: Screen, event: "Configured", callback: () -> ()) -> EventConnection)
}
type TouchScreen = {
    GetCursor: (self: TouchScreen) -> Cursor,
    GetCursors: (self: TouchScreen) -> {Cursor},
    GetDimensions: (self: TouchScreen) -> Vector2,
    ClearElements: (self: TouchScreen, className: string?, properties: {[string]: any}?) -> (),
    CreateElement: (self: TouchScreen, className: string, properties: {[string]: any}) -> ScreenObject,
    Trigger: (self: TouchScreen) -> (),
    Configure: (self: TouchScreen, properties: {VideoID: number?}) -> (),
    VideoID: number,
    ClassName: string,
    Position: Vector2,
    CFrame: CFrame,
    GUID: string,
    Connect: ((self: TouchScreen, event: "CursorMoved", callback: (cursor: Cursor) -> ()) -> EventConnection)
        & ((self: TouchScreen, event: "CursorPressed", callback: (cursor: Cursor) -> ()) -> EventConnection)
        & ((self: TouchScreen, event: "CursorReleased", callback: (cursor: Cursor) -> ()) -> EventConnection)
        & ((self: TouchScreen, event: "Triggered", callback: () -> ()) -> EventConnection)
        & ((self: TouchScreen, event: "Configured", callback: () -> ()) -> EventConnection)
}
type TouchSensor = {
    Trigger: (self: TouchSensor) -> (),
    Configure: (self: TouchSensor, properties: {}) -> (),
    ClassName: string,
    Position: Vector2,
    CFrame: CFrame,
    GUID: string,
    Connect: ((self: TouchSensor, event: "Touched", callback: () -> ()) -> EventConnection)
        & ((self: TouchSensor, event: "Triggered", callback: () -> ()) -> EventConnection)
        & ((self: TouchSensor, event: "Configured", callback: () -> ()) -> EventConnection)
}
type Button = {
    Trigger: (self: Button) -> (),
    Configure: (self: Button, properties: {KeyInput: string?, TriggerMode: number?}) -> (),
    KeyInput: string,
    TriggerMode: number,
    ClassName: string,
    Position: Vector2,
    CFrame: CFrame,
    GUID: string,
    Connect: ((self: Button, event: "OnClick", callback: (player: string) -> ()) -> EventConnection)
        & ((self: Button, event: "Triggered", callback: () -> ()) -> EventConnection)
        & ((self: Button, event: "Configured", callback: () -> ()) -> EventConnection)
}
type Light = {
    SetColor: (self: Light, color: Color3) -> (),
    Trigger: (self: Light) -> (),
    Configure: (self: Light, properties: {Brightness: number?, LightRange: number?}) -> (),
    Brightness: number,
    LightRange: number,
    ClassName: string,
    Position: Vector2,
    CFrame: CFrame,
    GUID: string,
    Connect: ((self: Light, event: "Triggered", callback: () -> ()) -> EventConnection)
        & ((self: Light, event: "Configured", callback: () -> ()) -> EventConnection)
}
type Rail = {
    SetPosition: (self: Rail, depth: number) -> (),
    Trigger: (self: Rail) -> (),
    Configure: (self: Rail, properties: {}) -> (),
    ClassName: string,
    Position: Vector2,
    CFrame: CFrame,
    GUID: string,
    Connect: ((self: Rail, event: "Triggered", callback: () -> ()) -> EventConnection)
        & ((self: Rail, event: "Configured", callback: () -> ()) -> EventConnection)
}
type StarMap = {
    GetBodies: (self: StarMap) -> Iterator<string, nil>,
    GetSystems: (self: StarMap) -> Iterator<string, nil>,
    Trigger: (self: StarMap) -> (),
    Configure: (self: StarMap, properties: {}) -> (),
    ClassName: string,
    Position: Vector2,
    CFrame: CFrame,
    GUID: string,
    Connect: ((self: StarMap, event: "Triggered", callback: () -> ()) -> EventConnection)
        & ((self: StarMap, event: "Configured", callback: () -> ()) -> EventConnection)
}
type Telescope = {
    GetCoordinate: (self: Telescope) -> RegionInfo,
    WhenRegionLoads: (self: Telescope, callback: (regionData: RegionInfo) -> ()) -> (),
    Trigger: (self: Telescope) -> (),
    Configure: (self: Telescope, properties: {ViewCoordinates: string?}) -> (),
    ViewCoordinates: string,
    ClassName: string,
    Position: Vector2,
    CFrame: CFrame,
    GUID: string,
    Connect: ((self: Telescope, event: "Triggered", callback: () -> ()) -> EventConnection)
        & ((self: Telescope, event: "Configured", callback: () -> ()) -> EventConnection)
}
type Speaker = {
    PlaySound: (self: Speaker, soundId: number) -> (),
    ClearSounds: (self: Speaker) -> (),
    Chat: (self: Speaker, message: string) -> (),
    Trigger: (self: Speaker) -> (),
    Configure: (self: Speaker, properties: {Audio: number?, Pitch: number?}) -> (),
    Audio: number,
    Pitch: number,
    ClassName: string,
    Position: Vector2,
    CFrame: CFrame,
    GUID: string,
    Connect: ((self: Speaker, event: "Triggered", callback: () -> ()) -> EventConnection)
        & ((self: Speaker, event: "Configured", callback: () -> ()) -> EventConnection)
}
type Reactor = {
    GetFuel: (self: Reactor) -> {[number]: number},
    GetTemp: (self: Reactor) -> number,
    Trigger: (self: Reactor) -> (),
    Configure: (self: Reactor, properties: {}) -> (),
    ClassName: string,
    Position: Vector2,
    CFrame: CFrame,
    GUID: string,
    Connect: ((self: Reactor, event: "Triggered", callback: () -> ()) -> EventConnection)
        & ((self: Reactor, event: "Configured", callback: () -> ()) -> EventConnection)
}
type Dispenser = {
    Dispense: (self: Dispenser) -> (),
    Trigger: (self: Dispenser) -> (),
    Configure: (self: Dispenser, properties: {}) -> (),
    ClassName: string,
    Position: Vector2,
    CFrame: CFrame,
    GUID: string,
    Connect: ((self: Dispenser, event: "Triggered", callback: () -> ()) -> EventConnection)
        & ((self: Dispenser, event: "Configured", callback: () -> ()) -> EventConnection)
}
type Faucet = {
    Dispense: (self: Faucet) -> (),
    Trigger: (self: Faucet) -> (),
    Configure: (self: Faucet, properties: {}) -> (),
    ClassName: string,
    Position: Vector2,
    CFrame: CFrame,
    GUID: string,
    Connect: ((self: Faucet, event: "Triggered", callback: () -> ()) -> EventConnection)
        & ((self: Faucet, event: "Configured", callback: () -> ()) -> EventConnection)
}
type Servo = {
    SetAngle: (self: Servo, angle: number) -> (),
    Trigger: (self: Servo) -> (),
    Configure: (self: Servo, properties: {ServoSpeed: number?, AngleStep: number?, Responsiveness: number?}) -> (),
    ServoSpeed: number,
    AngleStep: number,
    Responsiveness: number,
    ClassName: string,
    Position: Vector2,
    CFrame: CFrame,
    GUID: string,
    Connect: ((self: Servo, event: "Triggered", callback: () -> ()) -> EventConnection)
        & ((self: Servo, event: "Configured", callback: () -> ()) -> EventConnection)
}
type BlackBox = {
    GetLogs: (self: BlackBox) -> RegionLog,
    Trigger: (self: BlackBox) -> (),
    Configure: (self: BlackBox, properties: {}) -> (),
    ClassName: string,
    Position: Vector2,
    CFrame: CFrame,
    GUID: string,
    Connect: ((self: BlackBox, event: "Triggered", callback: () -> ()) -> EventConnection)
        & ((self: BlackBox, event: "Configured", callback: () -> ()) -> EventConnection)
}
type Assembler = {
    Trigger: (self: Assembler) -> (),
    Configure: (self: Assembler, properties: {Assemble: string?}) -> (),
    Assemble: string,
    ClassName: string,
    Position: Vector2,
    CFrame: CFrame,
    GUID: string,
    Connect: ((self: Assembler, event: "Triggered", callback: () -> ()) -> EventConnection)
        & ((self: Assembler, event: "Configured", callback: () -> ()) -> EventConnection)
}
type Thruster = {
    Trigger: (self: Thruster) -> (),
    Configure: (self: Thruster, properties: {Propulsion: number?}) -> (),
    Propulsion: number,
    ClassName: string,
    Position: Vector2,
    CFrame: CFrame,
    GUID: string,
    Connect: ((self: Thruster, event: "Triggered", callback: () -> ()) -> EventConnection)
        & ((self: Thruster, event: "Configured", callback: () -> ()) -> EventConnection)
}
type Switch = {
    Trigger: (self: Switch) -> (),
    Configure: (self: Switch, properties: {SwitchValue: boolean?}) -> (),
    SwitchValue: boolean,
    ClassName: string,
    Position: Vector2,
    CFrame: CFrame,
    GUID: string,
    Connect: ((self: Switch, event: "Triggered", callback: () -> ()) -> EventConnection)
        & ((self: Switch, event: "Configured", callback: () -> ()) -> EventConnection)
}
type Pump = {
    Trigger: (self: Pump) -> (),
    Configure: (self: Pump, properties: {LiquidToPump: string?}) -> (),
    LiquidToPump: string,
    ClassName: string,
    Position: Vector2,
    CFrame: CFrame,
    GUID: string,
    Connect: ((self: Pump, event: "Triggered", callback: () -> ()) -> EventConnection)
        & ((self: Pump, event: "Configured", callback: () -> ()) -> EventConnection)
}
type IonRocket = {
    Trigger: (self: IonRocket) -> (),
    Configure: (self: IonRocket, properties: {Propulsion: number?}) -> (),
    Propulsion: number,
    ClassName: string,
    Position: Vector2,
    CFrame: CFrame,
    GUID: string,
    Connect: ((self: IonRocket, event: "Triggered", callback: () -> ()) -> EventConnection)
        & ((self: IonRocket, event: "Configured", callback: () -> ()) -> EventConnection)
}
type Motor = {
    Trigger: (self: Motor) -> (),
    Configure: (self: Motor, properties: {Power: number?, Ratio: number?}) -> (),
    Power: number,
    Ratio: number,
    ClassName: string,
    Position: Vector2,
    CFrame: CFrame,
    GUID: string,
    Connect: ((self: Motor, event: "Triggered", callback: () -> ()) -> EventConnection)
        & ((self: Motor, event: "Configured", callback: () -> ()) -> EventConnection)
}
type Hydroponic = {
    Trigger: (self: Hydroponic) -> (),
    Configure: (self: Hydroponic, properties: {Grow: string?}) -> (),
    Grow: string,
    ClassName: string,
    Position: Vector2,
    CFrame: CFrame,
    GUID: string,
    Connect: ((self: Hydroponic, event: "Triggered", callback: () -> ()) -> EventConnection)
        & ((self: Hydroponic, event: "Configured", callback: () -> ()) -> EventConnection)
}
type Boombox = {
    Trigger: (self: Boombox) -> (),
    Configure: (self: Boombox, properties: {Audio: number?}) -> (),
    Audio: number,
    ClassName: string,
    Position: Vector2,
    CFrame: CFrame,
    GUID: string,
    Connect: ((self: Boombox, event: "Triggered", callback: () -> ()) -> EventConnection)
        & ((self: Boombox, event: "Configured", callback: () -> ()) -> EventConnection)
}
type Extractor = {
    Trigger: (self: Extractor) -> (),
    Configure: (self: Extractor, properties: {MaterialToExtract: string?}) -> (),
    MaterialToExtract: string,
    ClassName: string,
    Position: Vector2,
    CFrame: CFrame,
    GUID: string,
    Connect: ((self: Extractor, event: "Triggered", callback: () -> ()) -> EventConnection)
        & ((self: Extractor, event: "Configured", callback: () -> ()) -> EventConnection)
}
type Laser = {
    Trigger: (self: Laser) -> (),
    Configure: (self: Laser, properties: {DamageOnlyPlayers: boolean?}) -> (),
    DamageOnlyPlayers: boolean,
    ClassName: string,
    Position: Vector2,
    CFrame: CFrame,
    GUID: string,
    Connect: ((self: Laser, event: "Triggered", callback: () -> ()) -> EventConnection)
        & ((self: Laser, event: "Configured", callback: () -> ()) -> EventConnection)
}
type MiningLaser = {
    Trigger: (self: MiningLaser) -> (),
    Configure: (self: MiningLaser, properties: {MaterialToExtract: string?}) -> (),
    MaterialToExtract: string,
    ClassName: string,
    Position: Vector2,
    CFrame: CFrame,
    GUID: string,
    Connect: ((self: MiningLaser, event: "Triggered", callback: () -> ()) -> EventConnection)
        & ((self: MiningLaser, event: "Configured", callback: () -> ()) -> EventConnection)
}
type BeaconName = {
    Trigger: (self: BeaconName) -> (),
    Configure: (self: BeaconName, properties: {BeaconName: string?, ShowOnMap: boolean?}) -> (),
    BeaconName: string,
    ShowOnMap: boolean,
    ClassName: string,
    Position: Vector2,
    CFrame: CFrame,
    GUID: string,
    Connect: ((self: BeaconName, event: "Triggered", callback: () -> ()) -> EventConnection)
        & ((self: BeaconName, event: "Configured", callback: () -> ()) -> EventConnection)
}
type Transformer = {
    Trigger: (self: Transformer) -> (),
    Configure: (self: Transformer, properties: {LoopTime: number?}) -> (),
    LoopTime: number,
    ClassName: string,
    Position: Vector2,
    CFrame: CFrame,
    GUID: string,
    Connect: ((self: Transformer, event: "Triggered", callback: () -> ()) -> EventConnection)
        & ((self: Transformer, event: "Configured", callback: () -> ()) -> EventConnection)
}
type GravityGenerator = {
    Trigger: (self: GravityGenerator) -> (),
    Configure: (self: GravityGenerator, properties: {Gravity: number?}) -> (),
    Gravity: number,
    ClassName: string,
    Position: Vector2,
    CFrame: CFrame,
    GUID: string,
    Connect: ((self: GravityGenerator, event: "Triggered", callback: () -> ()) -> EventConnection)
        & ((self: GravityGenerator, event: "Configured", callback: () -> ()) -> EventConnection)
}
type Hologram = {
    Trigger: (self: Hologram) -> (),
    Configure: (self: Hologram, properties: {UserId: number?}) -> (),
    UserId: number,
    ClassName: string,
    Position: Vector2,
    CFrame: CFrame,
    GUID: string,
    Connect: ((self: Hologram, event: "Triggered", callback: () -> ()) -> EventConnection)
        & ((self: Hologram, event: "Configured", callback: () -> ()) -> EventConnection)
}
type ConveyorBelt = {
    Trigger: (self: ConveyorBelt) -> (),
    Configure: (self: ConveyorBelt, properties: {ConveyorBeltSpeed: number?}) -> (),
    ConveyorBeltSpeed: number,
    ClassName: string,
    Position: Vector2,
    CFrame: CFrame,
    GUID: string,
    Connect: ((self: ConveyorBelt, event: "Triggered", callback: () -> ()) -> EventConnection)
        & ((self: ConveyorBelt, event: "Configured", callback: () -> ()) -> EventConnection)
}
type Rocket = {
    Trigger: (self: Rocket) -> (),
    Configure: (self: Rocket, properties: {Propulsion: number?}) -> (),
    Propulsion: number,
    ClassName: string,
    Position: Vector2,
    CFrame: CFrame,
    GUID: string,
    Connect: ((self: Rocket, event: "Triggered", callback: () -> ()) -> EventConnection)
        & ((self: Rocket, event: "Configured", callback: () -> ()) -> EventConnection)
}
type HyperDrive = {
    Trigger: (self: HyperDrive) -> (),
    Configure: (self: HyperDrive, properties: {Coordinates: string?}) -> (),
    Coordinates: string,
    ClassName: string,
    Position: Vector2,
    CFrame: CFrame,
    GUID: string,
    Connect: ((self: HyperDrive, event: "Triggered", callback: () -> ()) -> EventConnection)
        & ((self: HyperDrive, event: "Configured", callback: () -> ()) -> EventConnection)
}
type Antenna = {
    Trigger: (self: Antenna) -> (),
    Configure: (self: Antenna, properties: {AntennaID: string?}) -> (),
    AntennaID: string,
    ClassName: string,
    Position: Vector2,
    CFrame: CFrame,
    GUID: string,
    Connect: ((self: Antenna, event: "Triggered", callback: () -> ()) -> EventConnection)
        & ((self: Antenna, event: "Configured", callback: () -> ()) -> EventConnection)
}
type Polysilicon = {
    Trigger: (self: Polysilicon) -> (),
    Configure: (self: Polysilicon, properties: {PolysiliconMode: number?, Frequency: number?}) -> (),
    PolysiliconMode: number,
    Frequency: number,
    ClassName: string,
    Position: Vector2,
    CFrame: CFrame,
    GUID: string,
    Connect: ((self: Polysilicon, event: "Triggered", callback: () -> ()) -> EventConnection)
        & ((self: Polysilicon, event: "Configured", callback: () -> ()) -> EventConnection)
}
type TimeSensor = {
    Trigger: (self: TimeSensor) -> (),
    Configure: (self: TimeSensor, properties: {Time: string?}) -> (),
    Time: string,
    ClassName: string,
    Position: Vector2,
    CFrame: CFrame,
    GUID: string,
    Connect: ((self: TimeSensor, event: "Triggered", callback: () -> ()) -> EventConnection)
        & ((self: TimeSensor, event: "Configured", callback: () -> ()) -> EventConnection)
}
type Microcontroller = {
    Trigger: (self: Microcontroller) -> (),
    Configure: (self: Microcontroller, properties: {Code: string?}) -> (),
    Code: string,
    ClassName: string,
    Position: Vector2,
    CFrame: CFrame,
    GUID: string,
    Connect: ((self: Microcontroller, event: "Triggered", callback: () -> ()) -> EventConnection)
        & ((self: Microcontroller, event: "Configured", callback: () -> ()) -> EventConnection)
}
type RemoteControl = {
    Trigger: (self: RemoteControl) -> (),
    Configure: (self: RemoteControl, properties: {RemoteControlRange: number?}) -> (),
    RemoteControlRange: number,
    ClassName: string,
    Position: Vector2,
    CFrame: CFrame,
    GUID: string,
    Connect: ((self: RemoteControl, event: "Triggered", callback: () -> ()) -> EventConnection)
        & ((self: RemoteControl, event: "Configured", callback: () -> ()) -> EventConnection)
}
type Port = {
    Trigger: (self: Port) -> (),
    Configure: (self: Port, properties: {PortID: number?}) -> (),
    PortID: number,
    ClassName: string,
    Position: Vector2,
    CFrame: CFrame,
    GUID: string,
    Connect: ((self: Port, event: "Triggered", callback: () -> ()) -> EventConnection)
        & ((self: Port, event: "Configured", callback: () -> ()) -> EventConnection)
}
type TriggerSwitch = {
    Trigger: (self: TriggerSwitch) -> (),
    Configure: (self: TriggerSwitch, properties: {SwitchValue: boolean?}) -> (),
    SwitchValue: boolean,
    ClassName: string,
    Position: Vector2,
    CFrame: CFrame,
    GUID: string,
    Connect: ((self: TriggerSwitch, event: "Triggered", callback: () -> ()) -> EventConnection)
        & ((self: TriggerSwitch, event: "Configured", callback: () -> ()) -> EventConnection)
}
type DelayWire = {
    Trigger: (self: DelayWire) -> (),
    Configure: (self: DelayWire, properties: {DelayTime: number?}) -> (),
    DelayTime: number,
    ClassName: string,
    Position: Vector2,
    CFrame: CFrame,
    GUID: string,
    Connect: ((self: DelayWire, event: "Triggered", callback: () -> ()) -> EventConnection)
        & ((self: DelayWire, event: "Configured", callback: () -> ()) -> EventConnection)
}
type Hatch = {
    Trigger: (self: Hatch) -> (),
    Configure: (self: Hatch, properties: {SwitchValue: boolean?}) -> (),
    SwitchValue: boolean,
    ClassName: string,
    Position: Vector2,
    CFrame: CFrame,
    GUID: string,
    Connect: ((self: Hatch, event: "Triggered", callback: () -> ()) -> EventConnection)
        & ((self: Hatch, event: "Configured", callback: () -> ()) -> EventConnection)
}
type TemperatureSensor = {
    Trigger: (self: TemperatureSensor) -> (),
    Configure: (self: TemperatureSensor, properties: {TemperatureRange: string?}) -> (),
    TemperatureRange: string,
    ClassName: string,
    Position: Vector2,
    CFrame: CFrame,
    GUID: string,
    Connect: ((self: TemperatureSensor, event: "Triggered", callback: () -> ()) -> EventConnection)
        & ((self: TemperatureSensor, event: "Configured", callback: () -> ()) -> EventConnection)
}
type Camera = {
    Trigger: (self: Camera) -> (),
    Configure: (self: Camera, properties: {VideoID: number?}) -> (),
    VideoID: number,
    ClassName: string,
    Position: Vector2,
    CFrame: CFrame,
    GUID: string,
    Connect: ((self: Camera, event: "Triggered", callback: () -> ()) -> EventConnection)
        & ((self: Camera, event: "Configured", callback: () -> ()) -> EventConnection)
}
type Valve = {
    Trigger: (self: Valve) -> (),
    Configure: (self: Valve, properties: {SwitchValue: boolean?}) -> (),
    SwitchValue: boolean,
    ClassName: string,
    Position: Vector2,
    CFrame: CFrame,
    GUID: string,
    Connect: ((self: Valve, event: "Triggered", callback: () -> ()) -> EventConnection)
        & ((self: Valve, event: "Configured", callback: () -> ()) -> EventConnection)
}
type StorageSensor = {
    Trigger: (self: StorageSensor) -> (),
    Configure: (self: StorageSensor, properties: {QuantityRange: string?}) -> (),
    QuantityRange: string,
    ClassName: string,
    Position: Vector2,
    CFrame: CFrame,
    GUID: string,
    Connect: ((self: StorageSensor, event: "Triggered", callback: () -> ()) -> EventConnection)
        & ((self: StorageSensor, event: "Configured", callback: () -> ()) -> EventConnection)
}
type Handle = {
    Trigger: (self: Handle) -> (),
    Configure: (self: Handle, properties: {Swing: number?, TriggerMode: number?, ToolName: string?}) -> (),
    Swing: number,
    TriggerMode: number,
    ToolName: string,
    ClassName: string,
    Position: Vector2,
    CFrame: CFrame,
    GUID: string,
    Connect: ((self: Handle, event: "Triggered", callback: () -> ()) -> EventConnection)
        & ((self: Handle, event: "Configured", callback: () -> ()) -> EventConnection)
}
-- Microcontroller Globals
-- GetPartFromPort and GetPartsFromPort are generated via script
declare GetPort: (port: PortLike) -> Part
declare TriggerPort: (port: PortLike) -> Part
declare SandboxID: string
declare SandboxRunID: number
declare Beep: (pitch: number) -> ()
declare JSONDecode: (json: string) -> {[string]: any}
declare JSONEncode: (dataToEncode: {[string]: any}) -> string
declare Communicate: () -> ()
-- Port-related microcontroller globals
declare GetPartFromPort: ((port: PortLike, partType: "Gyro") -> Gyro)
    & ((port: PortLike, partType: "Keyboard") -> Keyboard)
    & ((port: PortLike, partType: "Microphone") -> Microphone)
    & ((port: PortLike, partType: "LifeSensor") -> LifeSensor)
    & ((port: PortLike, partType: "Instrument") -> Instrument)
    & ((port: PortLike, partType: "EnergyShield") -> EnergyShield)
    & ((port: PortLike, partType: "Disk") -> Disk)
    & ((port: PortLike, partType: "Bin") -> Bin)
    & ((port: PortLike, partType: "Container") -> Container)
    & ((port: PortLike, partType: "Modem") -> Modem)
    & ((port: PortLike, partType: "Screen") -> Screen)
    & ((port: PortLike, partType: "TouchScreen") -> TouchScreen)
    & ((port: PortLike, partType: "TouchSensor") -> TouchSensor)
    & ((port: PortLike, partType: "Button") -> Button)
    & ((port: PortLike, partType: "Light") -> Light)
    & ((port: PortLike, partType: "Rail") -> Rail)
    & ((port: PortLike, partType: "StarMap") -> StarMap)
    & ((port: PortLike, partType: "Telescope") -> Telescope)
    & ((port: PortLike, partType: "Speaker") -> Speaker)
    & ((port: PortLike, partType: "Reactor") -> Reactor)
    & ((port: PortLike, partType: "Dispenser") -> Dispenser)
    & ((port: PortLike, partType: "Faucet") -> Faucet)
    & ((port: PortLike, partType: "Servo") -> Servo)
    & ((port: PortLike, partType: "BlackBox") -> BlackBox)
    & ((port: PortLike, partType: "Assembler") -> Assembler)
    & ((port: PortLike, partType: "Thruster") -> Thruster)
    & ((port: PortLike, partType: "Switch") -> Switch)
    & ((port: PortLike, partType: "Pump") -> Pump)
    & ((port: PortLike, partType: "IonRocket") -> IonRocket)
    & ((port: PortLike, partType: "Motor") -> Motor)
    & ((port: PortLike, partType: "Hydroponic") -> Hydroponic)
    & ((port: PortLike, partType: "Boombox") -> Boombox)
    & ((port: PortLike, partType: "Extractor") -> Extractor)
    & ((port: PortLike, partType: "Laser") -> Laser)
    & ((port: PortLike, partType: "MiningLaser") -> MiningLaser)
    & ((port: PortLike, partType: "BeaconName") -> BeaconName)
    & ((port: PortLike, partType: "Transformer") -> Transformer)
    & ((port: PortLike, partType: "GravityGenerator") -> GravityGenerator)
    & ((port: PortLike, partType: "Hologram") -> Hologram)
    & ((port: PortLike, partType: "ConveyorBelt") -> ConveyorBelt)
    & ((port: PortLike, partType: "Rocket") -> Rocket)
    & ((port: PortLike, partType: "HyperDrive") -> HyperDrive)
    & ((port: PortLike, partType: "Antenna") -> Antenna)
    & ((port: PortLike, partType: "Polysilicon") -> Polysilicon)
    & ((port: PortLike, partType: "TimeSensor") -> TimeSensor)
    & ((port: PortLike, partType: "Microcontroller") -> Microcontroller)
    & ((port: PortLike, partType: "RemoteControl") -> RemoteControl)
    & ((port: PortLike, partType: "Port") -> Port)
    & ((port: PortLike, partType: "TriggerSwitch") -> TriggerSwitch)
    & ((port: PortLike, partType: "DelayWire") -> DelayWire)
    & ((port: PortLike, partType: "Hatch") -> Hatch)
    & ((port: PortLike, partType: "TemperatureSensor") -> TemperatureSensor)
    & ((port: PortLike, partType: "Camera") -> Camera)
    & ((port: PortLike, partType: "Valve") -> Valve)
    & ((port: PortLike, partType: "StorageSensor") -> StorageSensor)
    & ((port: PortLike, partType: "Handle") -> Handle)
    & ((port: PortLike, partType: string) -> Part)
declare GetPartsFromPort: ((port: PortLike, partType: "Gyro") -> {Gyro})
    & ((port: PortLike, partType: "Keyboard") -> {Keyboard})
    & ((port: PortLike, partType: "Microphone") -> {Microphone})
    & ((port: PortLike, partType: "LifeSensor") -> {LifeSensor})
    & ((port: PortLike, partType: "Instrument") -> {Instrument})
    & ((port: PortLike, partType: "EnergyShield") -> {EnergyShield})
    & ((port: PortLike, partType: "Disk") -> {Disk})
    & ((port: PortLike, partType: "Bin") -> {Bin})
    & ((port: PortLike, partType: "Container") -> {Container})
    & ((port: PortLike, partType: "Modem") -> {Modem})
    & ((port: PortLike, partType: "Screen") -> {Screen})
    & ((port: PortLike, partType: "TouchScreen") -> {TouchScreen})
    & ((port: PortLike, partType: "TouchSensor") -> {TouchSensor})
    & ((port: PortLike, partType: "Button") -> {Button})
    & ((port: PortLike, partType: "Light") -> {Light})
    & ((port: PortLike, partType: "Rail") -> {Rail})
    & ((port: PortLike, partType: "StarMap") -> {StarMap})
    & ((port: PortLike, partType: "Telescope") -> {Telescope})
    & ((port: PortLike, partType: "Speaker") -> {Speaker})
    & ((port: PortLike, partType: "Reactor") -> {Reactor})
    & ((port: PortLike, partType: "Dispenser") -> {Dispenser})
    & ((port: PortLike, partType: "Faucet") -> {Faucet})
    & ((port: PortLike, partType: "Servo") -> {Servo})
    & ((port: PortLike, partType: "BlackBox") -> {BlackBox})
    & ((port: PortLike, partType: "Assembler") -> {Assembler})
    & ((port: PortLike, partType: "Thruster") -> {Thruster})
    & ((port: PortLike, partType: "Switch") -> {Switch})
    & ((port: PortLike, partType: "Pump") -> {Pump})
    & ((port: PortLike, partType: "IonRocket") -> {IonRocket})
    & ((port: PortLike, partType: "Motor") -> {Motor})
    & ((port: PortLike, partType: "Hydroponic") -> {Hydroponic})
    & ((port: PortLike, partType: "Boombox") -> {Boombox})
    & ((port: PortLike, partType: "Extractor") -> {Extractor})
    & ((port: PortLike, partType: "Laser") -> {Laser})
    & ((port: PortLike, partType: "MiningLaser") -> {MiningLaser})
    & ((port: PortLike, partType: "BeaconName") -> {BeaconName})
    & ((port: PortLike, partType: "Transformer") -> {Transformer})
    & ((port: PortLike, partType: "GravityGenerator") -> {GravityGenerator})
    & ((port: PortLike, partType: "Hologram") -> {Hologram})
    & ((port: PortLike, partType: "ConveyorBelt") -> {ConveyorBelt})
    & ((port: PortLike, partType: "Rocket") -> {Rocket})
    & ((port: PortLike, partType: "HyperDrive") -> {HyperDrive})
    & ((port: PortLike, partType: "Antenna") -> {Antenna})
    & ((port: PortLike, partType: "Polysilicon") -> {Polysilicon})
    & ((port: PortLike, partType: "TimeSensor") -> {TimeSensor})
    & ((port: PortLike, partType: "Microcontroller") -> {Microcontroller})
    & ((port: PortLike, partType: "RemoteControl") -> {RemoteControl})
    & ((port: PortLike, partType: "Port") -> {Port})
    & ((port: PortLike, partType: "TriggerSwitch") -> {TriggerSwitch})
    & ((port: PortLike, partType: "DelayWire") -> {DelayWire})
    & ((port: PortLike, partType: "Hatch") -> {Hatch})
    & ((port: PortLike, partType: "TemperatureSensor") -> {TemperatureSensor})
    & ((port: PortLike, partType: "Camera") -> {Camera})
    & ((port: PortLike, partType: "Valve") -> {Valve})
    & ((port: PortLike, partType: "StorageSensor") -> {StorageSensor})
    & ((port: PortLike, partType: "Handle") -> {Handle})
    & ((port: PortLike, partType: string) -> {Part})
