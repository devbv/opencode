--#METADATA#{"CREATABLE_INSTANCES": ["AngularVelocity", "Animation", "AnimationTrack", "Animator", "Atmosphere", "Attachment", "Backpack", "BackpackItem", "BasePart", "BaseScript", "Beam", "BillboardGui", "BindableEvent", "BlendSpace", "Bone", "BoolValue", "Camera", "CharacterMesh", "CollectionService", "Constraint", "ContextActionService", "CoreGui", "DataModel", "DataStore", "DataStoreGetOptions", "DataStoreIncrementOptions", "DataStoreInfo", "DataStoreKeyInfo", "DataStoreKeyPages", "DataStoreListingPages", "DataStoreService", "DataStoreSetOptions", "Fill", "Folder", "FormFactorPart", "Frame", "GenericSettings", "GlobalDataStore", "GuiBase2d", "GuiButton", "GuiObject", "HttpService", "Humanoid", "HumanoidDescription", "ImageButton", "ImageLabel", "InputObject", "Instance", "IntValue", "LayerCollector", "Light", "Lighting", "LinearVelocity", "LocalScript", "LuaSourceContainer", "MarketplaceService", "MaterialService", "MaterialVariant", "MeshPart", "Model", "ModuleScript", "Mouse", "NumberValue", "OrderedDataStore", "Outline", "OverlayBase", "PVInstance", "Pages", "Part", "ParticleEmitter", "PhysicsService", "Player", "PlayerGui", "PlayerScripts", "Players", "PointLight", "RemoteEvent", "ReplicatedStorage", "RunService", "ScreenGui", "Script", "ScrollingFrame", "ServerScriptService", "ServerStorage", "ServiceProvider", "SimulationBall", "Skeleton", "Sound", "SoundGroup", "SoundService", "SpawnLocation", "SpotLight", "StarterCharacterScripts", "StarterGui", "StarterPack", "StarterPlayer", "StarterPlayerScripts", "StringValue", "SurfaceGui", "SurfaceGuiBase", "Team", "Teams", "TeleportService", "TextButton", "TextLabel", "Tool", "Trail", "Tween", "TweenBase", "TweenService", "UIAspectRatioConstraint", "UIGridLayout", "UIGridStyleLayout", "UIListLayout", "UserGameSettings", "UserInputService", "UserSettings", "VFXPreset", "VectorForce", "Workspace", "WorldRankService", "WorldRoot", "WrapLayer", "WrapTarget"], "SERVICES": ["CollectionService", "ContextActionService", "DataStoreService", "HttpService", "Lighting", "MarketplaceService", "MaterialService", "PhysicsService", "Players", "ReplicatedStorage", "RunService", "ServerScriptService", "ServerStorage", "SoundService", "TeleportService", "TweenService", "UserInputService", "Workspace", "WorldRankService"]}
-- Overdare API Type Definitions
-- Auto-generated on 2026-02-04 16:40:25
-- DO NOT EDIT MANUALLY

-- Event Types
type ScriptConnection = {
	Disconnect: (self: ScriptConnection) -> ()
}

-- Data Types
declare class BallBounce
	CFrame: CFrame
	Direction: Vector3
	Speed: number
	Spin: number
	AngularVelocity: Vector3
	BouncedTime: number
	BouncedDirection: Vector3
	BouncedSpeed: number
	BouncedSpin: number
	BouncedAngularVelocity: Vector3
	bIsSliding: boolean
	StartPos: Vector3
	BouncedPosition: Vector3
	BouncedRotation: CFrame
	ImpactPoint: Vector3
	ImpactNormal: Vector3
end

declare class BallSimParams
	Mass: number
	InitialCFrame: CFrame
	InitialVelocity: Vector3
	InitialSpinAxis: Vector3
	InitialSpinSpeed: number
	Simsteps: number
	DeltaTime: number
	Gravity: Vector3
	DampingLinear: number
	DampingAngular: number
	Restitution: number
	Friction: number
	SpinMagnusWeight: number
	BaseGravity: number
	EnableGravityFalloff: boolean
	MinFalloffGravity: number
	GravityFalloffStartHeight: number
	GravityFalloffEndHeight: number
end

declare class BallSnapshot
	CFrame: CFrame
	Direction: Vector3
	Speed: number
	hitCount: number
	HitStartIndex: number
	HitLastIndex: number
	SpinAxis: Vector3
	SpinSpeed: number
end

declare class BlendSpaceSampleData
	AnimTrack: AnimationTrack
	SampleValue: Vector3
end

declare BlendSpaceSampleData: {
	new: (InAnimTrack: AnimationTrack, InSampleValue: Vector3) -> BlendSpaceSampleData,
}

declare class BrickColor
	number: number
	r: number
	g: number
	b: number
	Name: string
	Color: Color3
end

declare BrickColor: {
	new: (name: string) -> BrickColor,
}

declare class CFrame
	identity: CFrame
	Position: Vector3
	Orientation: Vector3
	Rotation: Vector3
	X: number
	Y: number
	Z: number
	XVector: Vector3
	YVector: Vector3
	ZVector: Vector3
	LookVector: Vector3
	RightVector: Vector3
	UpVector: Vector3
	function Inverse(self): CFrame
	function Lerp(self, goal: CFrame, alpha: number): CFrame
	function PointToWorldSpace(self, v3: Vector3): Vector3
	function PointToObjectSpace(self, v3: Vector3): Vector3
	function VectorToWorldSpace(self, v3: Vector3): Vector3
	function VectorToObjectSpace(self, v3: Vector3): Vector3
	function ToEulerAnglesXYZ(self): any
	function ToEulerAnglesYXZ(self): any
	function ToOrientation(self): any
end

declare CFrame: {
	new: () -> CFrame,
	new: (Position: Vector3) -> CFrame,
	new: (Position: Vector3, Look: Vector3) -> CFrame,
	new: (x: number, y: number, z: number) -> CFrame,
	lookAt: (at: Vector3, lookAt: Vector3, up: Vector3?) -> CFrame,
	fromEulerAnglesXYZ: (rx: number, ry: number, rz: number) -> CFrame,
	Angles: (rx: number, ry: number, rz: number) -> CFrame,
	fromEulerAnglesYXZ: (rx: number, ry: number, rz: number) -> CFrame,
	fromOrientation: (rx: number, ry: number, rz: number) -> CFrame,
	fromMatrix: (pos: Vector3, vx: Vector3, vy: Vector3, vz: Vector3?) -> CFrame,
}

declare class Color3
	R: number
	G: number
	B: number
end

declare Color3: {
	new: (red: number, green: number, blue: number) -> Color3,
	fromRGB: (red: number, green: number, blue: number) -> Color3,
}

declare class ColorSequence
	KeyPoints: {any}
end

declare ColorSequence: {
	new: (color: Color3) -> ColorSequence,
	new: (colorSequenceKeyPoints: {any}) -> ColorSequence,
	new: (c0: Color3, c1: Color3) -> ColorSequence,
}

declare class ColorSequenceKeypoint
	Time: number
	Value: Color3
end

declare ColorSequenceKeypoint: {
	new: (Time: number, color: Color3) -> ColorSequenceKeypoint,
}

declare class Content
end

declare class Enum
	function GetEnumItems(self): {any}
end

declare class EnumItem
	Name: string
	Value: number
	EnumType: Enum
end

declare class NumberRange
	Min: number
	Max: number
end

declare NumberRange: {
	new: (InMin: number, InMax: number) -> NumberRange,
}

declare class NumberSequence
	KeyPoints: number
end

declare NumberSequence: {
	new: (InValue: number) -> NumberSequence,
	new: (n0: number, n1: number) -> NumberSequence,
	new: (InArrayValue: {any}) -> NumberSequence,
}

declare class NumberSequenceKeypoint
	Envelope: number
	Time: number
	Value: number
end

declare NumberSequenceKeypoint: {
	new: (InTime: number, InValue: number, InEnvelope: number) -> NumberSequenceKeypoint,
	new: (InTime: number, InValue: number) -> NumberSequenceKeypoint,
}

declare class OverlapParams
	BruteForceAllSlow: boolean
	CollisionGroup: string
	FilterDescendantsInstances: {any}
	FilterType: RaycastFilterType
	MaxParts: number
	RespectCanCollide: boolean
	function AddToFilter(self, InValue: {any}): OverlapParams
end

declare OverlapParams: {
	new: () -> OverlapParams,
}

declare class PhysicalProperties
	Density: number
	Friction: number
	Elasticity: number
	FrictionWeight: number
	ElasticityWeight: number
end

declare PhysicalProperties: {
	new: (InMaterial: Material) -> PhysicalProperties,
	new: (InDensity: number, InFriction: number, InElasticity: number, InFrictionWeight: number, InElasticityWeight: number) -> PhysicalProperties,
}

declare class Ray
	Origin: Vector3
	Direction: Vector3
	Unit: Ray
	function ClosestPoint(self, InPoint: Vector3): Vector3
	function Distance(self, InPoint: Vector3): number
end

declare Ray: {
	new: (InOrigin: Vector3, InDirection: Vector3) -> Ray,
}

declare class RaycastParams
	FilterDescendantsInstances: {any}
	FilterType: RaycastFilterType
	IgnoreWater: boolean
	CollisionGroup: string
	RespectCanCollide: boolean
	BruteForceAllSlow: boolean
	function AddToFilter(self): RaycastParams
end

declare RaycastParams: {
	new: () -> RaycastParams,
}

declare class RaycastResult
	Distance: number
	Instance: Instance
	Position: Vector3
	Normal: Vector3
end

declare class ScriptConnection
	Connected: boolean
	function Disconnect(self): ()
end

declare class ScriptSignal
	function Connect(self, func: (...any) -> ()): ScriptConnection
	function Once(self, func: (...any) -> ()): ScriptConnection
	function Wait(self): any
end

declare class TweenInfo
	Time: number
	EasingStyle: EasingStyle
	EasingDirection: EasingDirection
	RepeatCount: number
	Reverses: boolean
	DelayTime: number
end

declare TweenInfo: {
	new: (InTime: number, InEasingStyle: EasingStyle, InEasingDirection: EasingDirection, InRepeatCount: number, InReverses: boolean, InDelayTime: number) -> TweenInfo,
}

declare class UDim
	Scale: number
	Offset: number
end

declare UDim: {
	new: (InScale: number, InOffset: number) -> UDim,
}

declare class UDim2
	X: number
	Y: number
	function Lerp(self, goal: UDim2, alpha: number): UDim2
end

declare UDim2: {
	new: (xScale: number, xOffset: number, yScale: number, yOffset: number) -> UDim2,
}

declare class Vector2
	X: number
	Y: number
	zero: Vector2
	one: Vector2
	xAxis: Vector2
	yAxis: Vector2
	function Lerp(self, goal: Vector2, alpha: number): Vector2
	function Slerp(self, goal: Vector2, alpha: number): Vector2
end

declare Vector2: {
	new: (x: number, y: number) -> Vector2,
}

declare class Vector3
	X: number
	Y: number
	Z: number
	zero: Vector3
	one: Vector3
	xAxis: Vector3
	yAxis: Vector3
	zAxis: Vector3
	Unit: Vector3
	Magnitude: number
	function Abs(self): Vector3
	function Angle(self, otherVector: Vector3, axis: Vector3): number
	function Ceil(self): Vector3
	function ClampMagnitude(self, maxLength: number): Vector3
	function Cross(self, Parameter: Vector3): Vector3
	function Distance(self, otherVector: Vector3): number
	function Dot(self, vector: Vector3): number
	function Floor(self): Vector3
	function FuzzyEq(self, otherVector: Vector3, epsilon: number): boolean
	function Lerp(self, goal: Vector3, alpha: number): Vector3
	function Max(self, otherVector: Vector3): Vector3
	function Min(self, otherVector: Vector3): Vector3
	function MoveTowards(self, target: Vector3, maxDelta: number): Vector3
	function Reflect(self, inNormal: Vector3): Vector3
	function Rotate(self, axis: Vector3, radians: number): Vector3
	function Sign(self): Vector3
	function Slerp(self, goal: Vector3, alpha: number): Vector3
end

declare Vector3: {
	new: (x: number, y: number, z: number) -> Vector3,
}

-- Enums
declare class ActuatorRelativeTo
	Name: string
	Value: number
end

declare class ActuatorRelativeTo_INTERNAL
	Attachment0: ActuatorRelativeTo
	Attachment1: ActuatorRelativeTo
	World: ActuatorRelativeTo
end

declare class AnimationPriority
	Name: string
	Value: number
end

declare class AnimationPriority_INTERNAL
	Action4: AnimationPriority
	Action3: AnimationPriority
	Action2: AnimationPriority
	Action: AnimationPriority
	Movement: AnimationPriority
	Idle: AnimationPriority
	Core: AnimationPriority
	None: AnimationPriority
end

declare class AspectType
	Name: string
	Value: number
end

declare class AspectType_INTERNAL
	FitWithinMaxSize: AspectType
	ScaleWithParentSize: AspectType
end

declare class AssetTypeVerification
	Name: string
	Value: number
end

declare class AssetTypeVerification_INTERNAL
	Default: AssetTypeVerification
	ClientOnly: AssetTypeVerification
	Always: AssetTypeVerification
end

declare class BallState
	Name: string
	Value: number
end

declare class BallState_INTERNAL
end

declare class BorderMode
	Name: string
	Value: number
end

declare class BorderMode_INTERNAL
	Insert: BorderMode
	Middle: BorderMode
	Outline: BorderMode
end

declare class CameraMode
	Name: string
	Value: number
end

declare class CameraMode_INTERNAL
	Classic: CameraMode
	LockFirstPerson: CameraMode
end

declare class CameraType
	Name: string
	Value: number
end

declare class CameraType_INTERNAL
	Fixed: CameraType
	Attach: CameraType
	Watch: CameraType
	Track: CameraType
	Follow: CameraType
	Custom: CameraType
	Scriptable: CameraType
	Orbital: CameraType
end

declare class ContextActionResult
	Name: string
	Value: number
end

declare class ContextActionResult_INTERNAL
	Sink: ContextActionResult
	Pass: ContextActionResult
end

declare class CoreGuiType
	Name: string
	Value: number
end

declare class CoreGuiType_INTERNAL
	PlayerList: CoreGuiType
	Health: CoreGuiType
	Backpack: CoreGuiType
	Chat: CoreGuiType
	All: CoreGuiType
	EmotesMenu: CoreGuiType
	SelfView: CoreGuiType
	Joystick: CoreGuiType
	JumpButton: CoreGuiType
end

declare class DominantAxis
	Name: string
	Value: number
end

declare class DominantAxis_INTERNAL
	Width: DominantAxis
	Height: DominantAxis
end

declare class EasingDirection
	Name: string
	Value: number
end

declare class EasingDirection_INTERNAL
	In: EasingDirection
	Out: EasingDirection
	InOut: EasingDirection
end

declare class EasingStyle
	Name: string
	Value: number
end

declare class EasingStyle_INTERNAL
	Linear: EasingStyle
	Sine: EasingStyle
	Back: EasingStyle
	Quad: EasingStyle
	Quart: EasingStyle
	Quint: EasingStyle
	Bounce: EasingStyle
	Elastic: EasingStyle
	Exponential: EasingStyle
	Circular: EasingStyle
	Cubic: EasingStyle
end

declare class ForceLimitMode
	Name: string
	Value: number
end

declare class ForceLimitMode_INTERNAL
	Magnitude: ForceLimitMode
	PerAxis: ForceLimitMode
end

declare class HitboxType
	Name: string
	Value: number
end

declare class HitboxType_INTERNAL
	Single: HitboxType
	SixBody: HitboxType
	FittedSixBody: HitboxType
end

declare class HttpCompression
	Name: string
	Value: number
end

declare class HttpCompression_INTERNAL
	None: HttpCompression
	Gzip: HttpCompression
end

declare class HttpContentType
	Name: string
	Value: number
end

declare class HttpContentType_INTERNAL
	ApplicationJson: HttpContentType
	ApplicationXml: HttpContentType
	ApplicationUrlEncoded: HttpContentType
	TextPlain: HttpContentType
	TextXml: HttpContentType
end

declare class HumanoidDisplayDistanceType
	Name: string
	Value: number
end

declare class HumanoidDisplayDistanceType_INTERNAL
	Viewer: HumanoidDisplayDistanceType
	Subject: HumanoidDisplayDistanceType
	None: HumanoidDisplayDistanceType
end

declare class HumanoidStateType
	Name: string
	Value: number
end

declare class HumanoidStateType_INTERNAL
	FallingDown: HumanoidStateType
	Ragdoll: HumanoidStateType
	GettingUp: HumanoidStateType
	Jumping: HumanoidStateType
	Swimming: HumanoidStateType
	Freefall: HumanoidStateType
	Flying: HumanoidStateType
	Landed: HumanoidStateType
	Running: HumanoidStateType
	RunningNoPhysics: HumanoidStateType
	StrafingNoPhysics: HumanoidStateType
	Climbing: HumanoidStateType
	Seated: HumanoidStateType
	PlatformStanding: HumanoidStateType
	Dead: HumanoidStateType
	Physics: HumanoidStateType
	None: HumanoidStateType
end

declare class InfoType
	Name: string
	Value: number
end

declare class InfoType_INTERNAL
	Asset: InfoType
	Product: InfoType
	GamePass: InfoType
	Subscription: InfoType
end

declare class KeyCode
	Name: string
	Value: number
end

declare class KeyCode_INTERNAL
	Unknown: KeyCode
	Backspace: KeyCode
	Tab: KeyCode
	Clear: KeyCode
	Return: KeyCode
	Pause: KeyCode
	Escape: KeyCode
	Space: KeyCode
	QuotedDouble: KeyCode
	Hash: KeyCode
	Dollar: KeyCode
	Percent: KeyCode
	Ampersand: KeyCode
	Quote: KeyCode
	LeftParenthesis: KeyCode
	RightParenthesis: KeyCode
	Asterisk: KeyCode
	Plus: KeyCode
	Comma: KeyCode
	Minus: KeyCode
	Period: KeyCode
	Slash: KeyCode
	Zero: KeyCode
	One: KeyCode
	Two: KeyCode
	Three: KeyCode
	Four: KeyCode
	Five: KeyCode
	Six: KeyCode
	Seven: KeyCode
	Eight: KeyCode
	Nine: KeyCode
	Colon: KeyCode
	Semicolon: KeyCode
	LessThan: KeyCode
	Equals: KeyCode
	GreaterThan: KeyCode
	Question: KeyCode
	At: KeyCode
	LeftBracket: KeyCode
	BackSlash: KeyCode
	RightBracket: KeyCode
	Caret: KeyCode
	Underscore: KeyCode
	Backquote: KeyCode
	A: KeyCode
	B: KeyCode
	C: KeyCode
	D: KeyCode
	E: KeyCode
	F: KeyCode
	G: KeyCode
	H: KeyCode
	I: KeyCode
	J: KeyCode
	K: KeyCode
	L: KeyCode
	M: KeyCode
	N: KeyCode
	O: KeyCode
	P: KeyCode
	Q: KeyCode
	R: KeyCode
	S: KeyCode
	T: KeyCode
	U: KeyCode
	V: KeyCode
	W: KeyCode
	X: KeyCode
	Y: KeyCode
	Z: KeyCode
	LeftCurly: KeyCode
	Pipe: KeyCode
	RightCurly: KeyCode
	Tilde: KeyCode
	Delete: KeyCode
	KeypadZero: KeyCode
	KeypadOne: KeyCode
	KeypadTwo: KeyCode
	KeypadThree: KeyCode
	KeypadFour: KeyCode
	KeypadFive: KeyCode
	KeypadSix: KeyCode
	KeypadSeven: KeyCode
	KeypadEight: KeyCode
	KeypadNine: KeyCode
	KeypadPeriod: KeyCode
	KeypadDivide: KeyCode
	KeypadMultiply: KeyCode
	KeypadMinus: KeyCode
	KeypadPlus: KeyCode
	KeypadEnter: KeyCode
	KeypadEquals: KeyCode
	Up: KeyCode
	Down: KeyCode
	Right: KeyCode
	Left: KeyCode
	Insert: KeyCode
	Home: KeyCode
	End: KeyCode
	PageUp: KeyCode
	PageDown: KeyCode
	F1: KeyCode
	F2: KeyCode
	F3: KeyCode
	F4: KeyCode
	F5: KeyCode
	F6: KeyCode
	F7: KeyCode
	F8: KeyCode
	F9: KeyCode
	F10: KeyCode
	F11: KeyCode
	F12: KeyCode
	F13: KeyCode
	F14: KeyCode
	F15: KeyCode
	NumLock: KeyCode
	CapsLock: KeyCode
	ScrollLock: KeyCode
	RightShift: KeyCode
	LeftShift: KeyCode
	RightControl: KeyCode
	LeftControl: KeyCode
	RightAlt: KeyCode
	LeftAlt: KeyCode
	RightMeta: KeyCode
	LeftMeta: KeyCode
	LeftSuper: KeyCode
	RightSuper: KeyCode
	Mode: KeyCode
	Compose: KeyCode
	Help: KeyCode
	Print: KeyCode
	SysReq: KeyCode
	Break: KeyCode
	Menu: KeyCode
	Power: KeyCode
	Euro: KeyCode
	Undo: KeyCode
	ButtonX: KeyCode
	ButtonY: KeyCode
	ButtonA: KeyCode
	ButtonB: KeyCode
	ButtonR1: KeyCode
	ButtonL1: KeyCode
	ButtonR2: KeyCode
	ButtonL2: KeyCode
	ButtonR3: KeyCode
	ButtonL3: KeyCode
	ButtonStart: KeyCode
	ButtonSelect: KeyCode
	DPadLeft: KeyCode
	DPadRight: KeyCode
	DPadUp: KeyCode
	DPadDown: KeyCode
	Thumbstick1: KeyCode
	Thumbstick2: KeyCode
end

declare class Material
	Name: string
	Value: number
end

declare class Material_INTERNAL
	Basic: Material
	Plastic: Material
	Brick: Material
	Rock: Material
	Metal: Material
	Unlit: Material
	Bark: Material
	SmallBrick: Material
	LeafyGround: Material
	MossyGround: Material
	Ground: Material
	Glass: Material
	Pavement: Material
	MossyRock: Material
	WoodPlanks: Material
	Wood: Material
	Neon: Material
end

declare class MaterialPattern
	Name: string
	Value: number
end

declare class MaterialPattern_INTERNAL
	Regular: MaterialPattern
	Organic: MaterialPattern
end

declare class NormalId
	Name: string
	Value: number
end

declare class NormalId_INTERNAL
	Right: NormalId
	Top: NormalId
	Back: NormalId
	Left: NormalId
	Bottom: NormalId
	Front: NormalId
end

declare class ParticleEmitterShape
	Name: string
	Value: number
end

declare class ParticleEmitterShape_INTERNAL
	Box: ParticleEmitterShape
	Sphere: ParticleEmitterShape
	Cylinder: ParticleEmitterShape
	Disc: ParticleEmitterShape
end

declare class ParticleEmitterShapeInOut
	Name: string
	Value: number
end

declare class ParticleEmitterShapeInOut_INTERNAL
	OutWard: ParticleEmitterShapeInOut
	InWard: ParticleEmitterShapeInOut
end

declare class ParticleEmitterShapeStyle
	Name: string
	Value: number
end

declare class ParticleEmitterShapeStyle_INTERNAL
	Volume: ParticleEmitterShapeStyle
	Surface: ParticleEmitterShapeStyle
end

declare class ParticleFlipbookLayout
	Name: string
	Value: number
end

declare class ParticleFlipbookLayout_INTERNAL
	None: ParticleFlipbookLayout
	Grid2x2: ParticleFlipbookLayout
	Grid4x4: ParticleFlipbookLayout
	Grid8x8: ParticleFlipbookLayout
end

declare class ParticleFlipbookMode
	Name: string
	Value: number
end

declare class ParticleFlipbookMode_INTERNAL
	Loop: ParticleFlipbookMode
	OneShot: ParticleFlipbookMode
	PingPong: ParticleFlipbookMode
	Random: ParticleFlipbookMode
end

declare class ParticleOrientation
	Name: string
	Value: number
end

declare class ParticleOrientation_INTERNAL
	FacingCamera: ParticleOrientation
	FacingCameraWorldUp: ParticleOrientation
	VelocityParallel: ParticleOrientation
	VelocityPerpendicular: ParticleOrientation
end

declare class PartType
	Name: string
	Value: number
end

declare class PartType_INTERNAL
	Ball: PartType
	Block: PartType
	Cylinder: PartType
end

declare class PlaybackState
	Name: string
	Value: number
end

declare class PlaybackState_INTERNAL
	Begin: PlaybackState
	Delayed: PlaybackState
	Playing: PlaybackState
	Paused: PlaybackState
	Completed: PlaybackState
	Cancelled: PlaybackState
end

declare class ProductPurchaseDecision
	Name: string
	Value: number
end

declare class ProductPurchaseDecision_INTERNAL
	NotProcessedYet: ProductPurchaseDecision
	PurchaseGranted: ProductPurchaseDecision
end

declare class RaycastFilterType
	Name: string
	Value: number
end

declare class RaycastFilterType_INTERNAL
	Exclude: RaycastFilterType
	Include: RaycastFilterType
end

declare class RollOffMode
	Name: string
	Value: number
end

declare class RollOffMode_INTERNAL
end

declare class RotationType
	Name: string
	Value: number
end

declare class RotationType_INTERNAL
	MovementRelative: RotationType
	CameraRelative: RotationType
	None: RotationType
end

declare class ShadowDetailLevel
	Name: string
	Value: number
end

declare class ShadowDetailLevel_INTERNAL
	Original: ShadowDetailLevel
	Medium: ShadowDetailLevel
	Low: ShadowDetailLevel
end

declare class TextXAlignment
	Name: string
	Value: number
end

declare class TextXAlignment_INTERNAL
	Left: TextXAlignment
	Right: TextXAlignment
	Center: TextXAlignment
end

declare class TextYAlignment
	Name: string
	Value: number
end

declare class TextYAlignment_INTERNAL
	Top: TextYAlignment
	Center: TextYAlignment
	Bottom: TextYAlignment
end

declare class UserInputState
	Name: string
	Value: number
end

declare class UserInputState_INTERNAL
	Begin: UserInputState
	Change: UserInputState
	End: UserInputState
	Cancel: UserInputState
	None: UserInputState
end

declare class UserInputType
	Name: string
	Value: number
end

declare class UserInputType_INTERNAL
	MouseButton1: UserInputType
	MouseButton2: UserInputType
	MouseButton3: UserInputType
	MouseWheel: UserInputType
	MouseMovement: UserInputType
	Touch: UserInputType
	Keyboard: UserInputType
	Focus: UserInputType
	Accelerometer: UserInputType
	Gyro: UserInputType
	Gamepad1: UserInputType
	Gamepad2: UserInputType
	Gamepad3: UserInputType
	Gamepad4: UserInputType
	Gamepad5: UserInputType
	Gamepad6: UserInputType
	Gamepad7: UserInputType
	Gamepad8: UserInputType
	TextInput: UserInputType
	InputMethod: UserInputType
	None: UserInputType
end

declare class VelocityConstraintMode
	Name: string
	Value: number
end

declare class VelocityConstraintMode_INTERNAL
	Line: VelocityConstraintMode
	Plane: VelocityConstraintMode
	Vector: VelocityConstraintMode
end

declare class FillDepthModeType
	Name: string
	Value: number
end

declare class FillDepthModeType_INTERNAL
	AlwaysOnTop: FillDepthModeType
	VisibleWhenNotOccluded: FillDepthModeType
	VisibleWhenOccluded: FillDepthModeType
end

declare class EnumContainer
	ActuatorRelativeTo: ActuatorRelativeTo_INTERNAL
	AnimationPriority: AnimationPriority_INTERNAL
	AspectType: AspectType_INTERNAL
	AssetTypeVerification: AssetTypeVerification_INTERNAL
	BallState: BallState_INTERNAL
	BorderMode: BorderMode_INTERNAL
	CameraMode: CameraMode_INTERNAL
	CameraType: CameraType_INTERNAL
	ContextActionResult: ContextActionResult_INTERNAL
	CoreGuiType: CoreGuiType_INTERNAL
	DominantAxis: DominantAxis_INTERNAL
	EasingDirection: EasingDirection_INTERNAL
	EasingStyle: EasingStyle_INTERNAL
	ForceLimitMode: ForceLimitMode_INTERNAL
	HitboxType: HitboxType_INTERNAL
	HttpCompression: HttpCompression_INTERNAL
	HttpContentType: HttpContentType_INTERNAL
	HumanoidDisplayDistanceType: HumanoidDisplayDistanceType_INTERNAL
	HumanoidStateType: HumanoidStateType_INTERNAL
	InfoType: InfoType_INTERNAL
	KeyCode: KeyCode_INTERNAL
	Material: Material_INTERNAL
	MaterialPattern: MaterialPattern_INTERNAL
	NormalId: NormalId_INTERNAL
	ParticleEmitterShape: ParticleEmitterShape_INTERNAL
	ParticleEmitterShapeInOut: ParticleEmitterShapeInOut_INTERNAL
	ParticleEmitterShapeStyle: ParticleEmitterShapeStyle_INTERNAL
	ParticleFlipbookLayout: ParticleFlipbookLayout_INTERNAL
	ParticleFlipbookMode: ParticleFlipbookMode_INTERNAL
	ParticleOrientation: ParticleOrientation_INTERNAL
	PartType: PartType_INTERNAL
	PlaybackState: PlaybackState_INTERNAL
	ProductPurchaseDecision: ProductPurchaseDecision_INTERNAL
	RaycastFilterType: RaycastFilterType_INTERNAL
	RollOffMode: RollOffMode_INTERNAL
	RotationType: RotationType_INTERNAL
	ShadowDetailLevel: ShadowDetailLevel_INTERNAL
	TextXAlignment: TextXAlignment_INTERNAL
	TextYAlignment: TextYAlignment_INTERNAL
	UserInputState: UserInputState_INTERNAL
	UserInputType: UserInputType_INTERNAL
	VelocityConstraintMode: VelocityConstraintMode_INTERNAL
	FillDepthModeType: FillDepthModeType_INTERNAL
end

declare Enum: EnumContainer

-- Classes
declare class InstanceBase
end

declare class ValueBase
end

declare class Instance extends InstanceBase
	Archivable: boolean
	ClassName: string
	Mobility: any
	Name: string
	Parent: Instance
	function AddTag(self, tag: string): ()
	function Clone(self): Instance
	function Destroy(self): ()
	function FindFirstAncestor(self, InName: string): Instance
	function FindFirstAncestorOfClass(self, InClassName: string): Instance
	function FindFirstAncestorWhichIsA(self, InClassName: string): Instance
	function FindFirstChild(self, InName: string, recursive: boolean): Instance
	function FindFirstChildOfClass(self, InClassName: string, recursive: boolean): Instance
	function GetAttribute(self, attribute: string): any
	function GetAttributeChangedSignal(self, InAttributeName: string): ScriptSignal
	function GetAttributes(self): {[string]: any}
	function GetChildren(self): {any}
	function GetChildrenNum(self): number
	function GetDescendants(self): {any}
	function GetTags(self): {any}
	function HasTag(self, tag: string): boolean
	function IsA(self, InClassName: string): boolean
	function IsDescendantOf(self, InAncestor: Instance): boolean
	function RemoveTag(self, tag: string): ()
	function SetAttribute(self, attribute: string, value: any): ()
	function WaitForChild(self, InChildName: string, InTimeOut: number?): Instance
	AncestryChanged: ScriptSignal
	AttributeChanged: ScriptSignal
	Changed: ScriptSignal
	ChildAdded: ScriptSignal
	ChildRemoved: ScriptSignal
	DescendantAdded: ScriptSignal
	DescendantRemoving: ScriptSignal
	Destroying: ScriptSignal
end

declare class Constraint extends Instance
	Attachment0: Attachment
	Attachment1: Attachment
	Color: Color3
	Enabled: boolean
	Visible: boolean
end

declare class AngularVelocity extends Constraint
	AngularVelocity: Vector3
	MaxTorque: number
	ReactionTorqueEnabled: boolean
	RelativeTo: ActuatorRelativeTo
end

declare class Animation extends Instance
	AnimationId: string
end

declare class AnimationTrack extends Instance
	Animation: Animation
	IsPlaying: boolean
	Length: number
	Looped: boolean
	Priority: AnimationPriority
	Speed: number
	TimePosition: number
	UpperBodyAnimation: boolean
	WeightCurrent: number
	WeightTarget: number
	function AdjustSpeed(self, InSpeed: number): ()
	function AdjustWeight(self, InWeight: number, InFadeTime: number): ()
	function GetMarkerReachedSignal(self, InName: string): ScriptSignal
	function GetTimeOfKeyframe(self, InName: string): number
	function Play(self, InFadeTime: number, InWeight: number, InSpeed: number): ()
	function Stop(self, InFadeTime: number): ()
	DidLoop: ScriptSignal
	Ended: ScriptSignal
	KeyframeReached: ScriptSignal
	Stopped: ScriptSignal
end

declare class Animator extends Instance
	EvaluationThrottled: boolean
	PreferLodEnabled: boolean
	RootMotion: CFrame
	RootMotionWeight: number
	function ApplyJointVelocities(self, motors: any): ()
	function GetPlayingAnimationTracks(self): {any}
	function LoadAnimation(self, InAnimation: Animation): AnimationTrack
	function RegisterEvaluationParallelCallback(self, InFunction: any): ()
	function StepAnimations(self, InDeltaTime: number): ()
end

declare class Atmosphere extends Instance
	AirColor: Color3
	CloudAmount: number
	CloudSpeed: number
	CloudTexture: string
	FogColor: Color3
	FogDensity: number
	FogFalloff: number
	FogHorizon: boolean
	FogStart: number
	GlareColor: Color3
	GlareFalloff: number
	HazeColor: Color3
	HazeSpread: number
end

declare class Attachment extends Instance
	Axis: Vector3
	CFrame: CFrame
	SecondaryAxis: Vector3
	WorldAxis: Vector3
	WorldCFrame: CFrame
	WorldSecondaryAxis: Vector3
	function GetConstraints(self): {any}
end

declare class Backpack extends Instance
end

declare class BackpackItem extends Instance
	TextureId: string
end

declare class PVInstance extends Instance
	Origin: CFrame
	PivotOffsetCFrame: CFrame
	function GetPivot(self): CFrame
	function PivotTo(self, InTargetCFrame: CFrame): ()
end

declare class BasePart extends PVInstance
	Anchored: boolean
	AssemblyAngularVelocity: Vector3
	AssemblyCenterOfMass: Vector3
	AssemblyLinearVelocity: Vector3
	AssemblyMass: number
	BrickColor: BrickColor
	CFrame: CFrame
	CanClimb: boolean
	CanCollide: boolean
	CanQuery: boolean
	CanTouch: boolean
	CastShadow: boolean
	CenterOfMass: Vector3
	CollisionGroup: string
	Color: Color3
	CurrentPhysicalProperties: PhysicalProperties
	CustomPhysicalProperties: PhysicalProperties
	ExtentsCFrame: CFrame
	ExtentsSize: Vector3
	LocalTransparencyModifier: number
	Locked: boolean
	Mass: number
	Massless: boolean
	Material: Material
	MaterialVariant: string
	Orientation: Vector3
	Position: Vector3
	ReceiveAge: number
	Reflectance: number
	ResizeIncrement: number
	RootPriority: number
	Rotation: Vector3
	Size: Vector3
	TraceGroupName: string
	Transparency: number
	function ApplyImpulse(self, impulse: Vector3): ()
	function GetMass(self): number
	function PivotTo(self, InTargetCFrame: CFrame): ()
	TouchEnded: ScriptSignal
	Touched: ScriptSignal
end

declare class LuaSourceContainer extends Instance
end

declare class BaseScript extends LuaSourceContainer
	Enabled: boolean
end

declare class Beam extends Instance
	Attachment0: Attachment
	Attachment1: Attachment
	Color: ColorSequence
	CurveSize0: number
	CurveSize1: number
	Enabled: boolean
	FaceCamera: boolean
	Texture: string
	TextureLength: number
	TextureSpeed: number
	Transparency: NumberSequence
	Width0: number
	Width1: number
end

declare class GuiBase2d extends Instance
	AbsolutePosition: Vector2
	AbsoluteSize: Vector2
end

declare class LayerCollector extends GuiBase2d
	Enabled: boolean
end

declare class SurfaceGuiBase extends LayerCollector
	Active: boolean
	Adornee: Instance
	AlwaysOnTop: boolean
	Brightness: number
	ClipsDescendants: boolean
	LightInfluence: number
	MaxDistance: number
	Size: UDim2
	ZIndexBehavior: any
end

declare class BillboardGui extends SurfaceGuiBase
	DistanceLowerLimit: number
	DistanceUpperLimit: number
	ExtentsOffsetWorldSpace: Vector3
	PlayerToHideFrom: Player
	PositionOffset: Vector3
	PositionOffsetWorldSpace: Vector3
	SizeOffset: Vector2
end

declare class BindableEvent extends Instance
	function Fire(self, Arguments: any): ()
	Event: ScriptSignal
end

declare class BlendSpace extends Instance
	AnimationIDs: {any}
	BlendByInertialization: boolean
	BlendTime: number
end

declare class Bone extends Attachment
	Transform: CFrame
	TransformedCFrame: CFrame
	TransformedWorldCFrame: CFrame
end

declare class BoolValue extends ValueBase
	Value: boolean
	Changed: ScriptSignal
end

declare class Camera extends Instance
	CFrame: CFrame
	CameraOffset: Vector3
	CameraSubject: Instance
	CameraType: CameraType
	EnableSmoothFollow: boolean
	EnableSmoothRotation: boolean
	FieldOfView: number
	Focus: CFrame
	FollowMaxDistance: number
	SmoothFollowSpeed: number
	SmoothRotationSpeed: number
	ViewportSize: Vector2
	function GetLargestCutoffDistance(self, InIgnoreList: {any}): number
	function ScreenPointToRay(self, x: number, y: number, depth: number): Ray
	function ViewportPointToRay(self, x: number, y: number, depth: number): Ray
	function WorldToViewportPoint(self, WorldPoint: Vector3): any
end

declare class CharacterMesh extends Instance
	BaseTextureId: number
	MeshId: number
	OverlayTextureId: number
end

declare class CollectionService extends Instance
	function AddTag(self, instance: Instance, tag: string): ()
	function GetTagged(self, tag: string): ()
	function GetTags(self): ()
	function HasTag(self): ()
	function RemoveTag(self, instance: Instance, tag: string): ()
end

declare class ContextActionService extends Instance
	function BindAction(self, ActionName: string, FunctionToBind: any, bCreateTouchButton: boolean, InputType: any): ()
	function GetAllBoundActionInfo(self): any
	function GetBoundActionInfo(self, ActionName: string): any
	function GetButton(self, ActionName: string): any
	function SetDescription(self, ActionName: string, InDescription: string): ()
	function SetImage(self, ActionName: string, ImageId: string): ()
	function SetPosition(self, ActionName: string, InPosition: UDim2): ()
	function SetTitle(self, ActionName: string, InTitle: string): ()
	function UnbindAction(self, ActionName: string): ()
	LocalToolEquipped: ScriptSignal
	LocalToolUnequipped: ScriptSignal
end

declare class CoreGui extends Instance
end

declare class ServiceProvider extends Instance
	function FindService(self, InClassName: string): Instance
	function GetService(self, InClassName: string): Instance
end

declare class DataModel extends ServiceProvider
	function DisableJoin(self): ()
	function EnableJoin(self): ()
	function IsJoinEnabled(self): boolean
end

declare class GlobalDataStore extends Instance
	function GetAsync(self, InKey: string, InOptions: DataStoreGetOptions): any
	function IncrementAsync(self, InKey: string, InDelta: number, InUserIds: {any}?, InOptions: DataStoreIncrementOptions?): any
	function RemoveAsync(self, InKey: string): ()
	function SetAsync(self, InKey: string, InValue: any, InUserIds: any?, InOptions: DataStoreSetOptions?): any
	function UpdateAsync(self, InKey: string, InTransformFunction: any): any
end

declare class DataStore extends GlobalDataStore
	function ListKeysAsync(self, InPrefix: string): DataStoreKeyPages
end

declare class DataStoreGetOptions extends Instance
end

declare class DataStoreIncrementOptions extends Instance
	function GetMetadata(self): {[string]: any}
	function SetMetadata(self, InMetaDataTable: {[string]: any}): ()
end

declare class DataStoreInfo extends Instance
end

declare class DataStoreKeyInfo extends Instance
	CreatedTime: number
	UpdatedTime: number
	Version: string
	function GetMetadata(self): {[string]: any}
	function GetUserIds(self): {any}
end

declare class Pages extends Instance
	IsFinished: boolean
	function AdvanceToNextPageAsync(self): ()
	function GetCurrentPage(self): {any}
end

declare class DataStoreKeyPages extends Pages
	Cursor: string
end

declare class DataStoreListingPages extends Pages
	Cursor: string
end

declare class DataStoreService extends Instance
	function GetDataStore(self, InName: string, InScope: string): GlobalDataStore
	function GetGlobalDataStore(self): GlobalDataStore
	function GetOrderedDataStore(self, InName: string, InScope: string): OrderedDataStore
	function ListDataStoresAsync(self, InPrefix: string, InPageSize: number, InCursor: string): DataStoreListingPages
end

declare class DataStoreSetOptions extends Instance
	function GetMetadata(self): {[string]: any}
	function SetMetadata(self, InMetaDataTable: {[string]: any}): ()
end

declare class OverlayBase extends Instance
	Adornee: Instance
	Enabled: boolean
end

declare class Fill extends OverlayBase
	Color: Color3
	DepthMode: FillDepthModeType
	Transparency: number
end

declare class Folder extends Instance
end

declare class Part extends BasePart
	Shape: PartType
end

declare class FormFactorPart extends Part
end

declare class GuiObject extends GuiBase2d
	Active: boolean
	AnchorPoint: Vector2
	BackgroundColor3: Color3
	BackgroundTransparency: number
	ClipsDescendants: boolean
	LayoutOrder: number
	Position: UDim2
	Rotation: number
	Size: UDim2
	Visible: boolean
	ZIndex: number
	InputBegan: ScriptSignal
	InputChanged: ScriptSignal
	InputEnded: ScriptSignal
end

declare class Frame extends GuiObject
	BorderColor3: Color3
	BorderMode: BorderMode
	BorderPixelSize: number
end

declare class GenericSettings extends ServiceProvider
end

declare class GuiButton extends GuiObject
	Activated: ScriptSignal
end

declare class HttpService extends Instance
	HttpEnabled: boolean
	function GenerateGUID(self, bInWrapInCurlyBraces: boolean): string
	function GetAsync(self, InUrl: string, InNoCache: boolean, InHeaders: any): string
	function JSONDecode(self, InInput: string): any
	function JSONEncode(self, InInput: any): string
	function PostAsync(self, InUrl: string, InData: string, InContentType: HttpContentType, InCompress: boolean, InHeaders: any): string
	function RequestAsync(self, InRequestOptions: {[string]: any}): any
	function UrlEncode(self, InInput: string): string
end

declare class Humanoid extends Instance
	AirControl: number
	AutoJumpEnabled: boolean
	AutoRotate: boolean
	AutomaticScalingEnabled: boolean
	BlendSpace: BlendSpace
	CameraOffset: Vector3
	CapsuleHeight: number
	CapsuleRadius: number
	CharacterMeshPos: Vector3
	DefaultBlendSpace: BlendSpace
	DisplayDistanceType: HumanoidDisplayDistanceType
	DisplayName: string
	FallingDeceleration: number
	FallingLateralFriction: number
	GravityScale: number
	GroundFriction: number
	Health: number
	HealthDisplayDistance: number
	HipHeight: number
	HitboxType: HitboxType
	IgnoreBaseRotation: boolean
	Jump: boolean
	JumpHeight: number
	JumpPower: number
	LookCameraDirection: boolean
	MaxAcceleration: number
	MaxHealth: number
	MaxJumpCount: number
	MaxSlopeAngle: number
	MoveDirection: Vector3
	PlatformStand: boolean
	RootPart: BasePart
	RotationSpeed: number
	Sit: boolean
	StompJumpMultiplier: number
	UseJumpPower: boolean
	WalkSpeed: number
	WalkToPart: Instance
	WalkToPoint: Vector3
	WalkingDeceleration: number
	function AddAccessory(self, InAccessory: Instance): ()
	function ApplyDescription(self, InDescription: HumanoidDescription, InAssetTypeVerification: AssetTypeVerification): ()
	function ApplyDescriptionReset(self, InDescription: HumanoidDescription, InAssetTypeVerification: AssetTypeVerification): ()
	function ChangeState(self, StateType: HumanoidStateType): ()
	function EquipTool(self, InTool: Instance): ()
	function GetAccessories(self): any
	function GetAppliedDescription(self): HumanoidDescription
	function GetState(self): HumanoidStateType
	function LoadAnimation(self, InAnimation: Animation): AnimationTrack
	function MoveTo(self, InPosition: Vector3, InWalkToPart: Instance): ()
	function RemoveAccessories(self): ()
	function SetStateEnabled(self, InHumanoidStateType: HumanoidStateType, bInEnabled: boolean): ()
	function TakeDamage(self, InDamage: number): ()
	function UnequipTools(self): ()
	ApplyDescriptionFinished: ScriptSignal
	Climbing: ScriptSignal
	ClusterCompositionFinished: ScriptSignal
	Died: ScriptSignal
	EmoteTriggered: ScriptSignal
	FallingDown: ScriptSignal
	FreeFalling: ScriptSignal
	GettingUp: ScriptSignal
	HealthChanged: ScriptSignal
	Jumping: ScriptSignal
	Landed: ScriptSignal
	MoveToFinished: ScriptSignal
	PlatformStanding: ScriptSignal
	PlatformStandingMoving: ScriptSignal
	Running: ScriptSignal
	StateChanged: ScriptSignal
	StateEnabledChanged: ScriptSignal
	Swimming: ScriptSignal
	Touched: ScriptSignal
end

declare class HumanoidDescription extends Instance
	AccessoryBlob: string
	BackAccessory: string
	BodyTypeScale: number
	ClimbAnimation: string
	DepthScale: number
	DieAnimation: string
	Face: string
	FaceAccessory: string
	FallAnimation: string
	FrontAccessory: string
	GraphicTShirt: string
	HairAccessory: string
	HatAccessory: string
	Head: string
	HeadColor: Color3
	HeadScale: number
	HeadTextureId: string
	HeightScale: number
	IdleAnimation: string
	JumpAnimation: string
	LandedAnimation: string
	LeftArm: string
	LeftArmColor: Color3
	LeftArmTextureId: string
	LeftLeg: string
	LeftLegColor: Color3
	LeftLegTextureId: string
	MoodAnimation: string
	NeckAccessory: string
	Pants: string
	ProportionScale: number
	RightArm: string
	RightArmColor: Color3
	RightArmTextureId: string
	RightLeg: string
	RightLegColor: Color3
	RightLegTextureId: string
	RunAnimation: string
	Shirt: string
	ShoulderAccessory: string
	SprintAnimation: string
	SwimmingBreaststrokeAnimation: string
	SwimmingIdleAnimation: string
	Torso: string
	TorsoColor: Color3
	TorsoTextureId: string
	WaistAccessory: string
	WalkAnimation: string
	WidthScale: number
	function AddEmote(self, InName: string, InAssetId: string): ()
	function GetAccessories(self, InIncludeRigidAccessories: boolean): any
	function GetEmotes(self): any
	function GetEquippedEmotes(self): any
	function RemoveEmote(self, InName: string): ()
	function SetAccessories(self, InAccessories: {any}, InIncludeRigidAccessories: boolean): ()
	function SetEmotes(self, InEmotes: any): ()
	function SetEquippedEmotes(self, InEquippedEmotes: {any}): ()
	EmotesChanged: ScriptSignal
	EquippedEmotesChanged: ScriptSignal
end

declare class ImageButton extends GuiButton
	HoverImage: string
	HoverImageContent: Content
	Image: string
	ImageColor3: Color3
	ImageContent: Content
	ImageTransparency: number
	PressImage: string
	PressImageContent: Content
end

declare class ImageLabel extends GuiObject
	Image: string
	ImageColor3: Color3
	ImageContent: Content
	ImageTransparency: number
end

declare class InputObject extends Instance
	Delta: Vector3
	KeyCode: KeyCode
	Position: Vector3
	UserInputState: UserInputState
	UserInputType: UserInputType
end

declare class IntValue extends ValueBase
	Value: number
	Changed: ScriptSignal
end

declare class Light extends Instance
	Brightness: number
	Color: Color3
	Enabled: boolean
	Shadows: boolean
end

declare class Lighting extends Instance
	AmbientSkyBrightness: number
	AmbientSkyColor: Color3
	AutoTimeCycle: number
	ClockTime: number
	Contrast: number
	GroundReflectionColor: Color3
	MoonBrightness: number
	MoonCastShadow: boolean
	MoonLightColor: Color3
	MoonMaterialColor: Color3
	MoonMaxHeight: number
	MoonPathAngle: number
	MoonPhase: number
	NightBrightness: number
	RealTimeDayDuration: number
	Saturation: number
	SkyColorInfluence: number
	StarsBrightness: number
	StarsColor: Color3
	SunBrightness: number
	SunCastShadow: number
	SunLightColor: Color3
	SunMaxHeight: number
	SunPathAngle: number
	TimeFlowSpeed: number
end

declare class LinearVelocity extends Constraint
	ForceLimitMode: ForceLimitMode
	ForceLimitsEnabled: boolean
	LineDirection: Vector3
	LineVelocity: number
	MaxAxesForce: Vector3
	MaxForce: number
	PlaneVelocity: Vector2
	PrimaryTangentAxis: Vector3
	RelativeTo: ActuatorRelativeTo
	SecondaryTangentAxis: Vector3
	VectorVelocity: Vector3
	VelocityConstraintMode: any
end

declare class LocalScript extends BaseScript
end

declare class MarketplaceService extends Instance
	function GetProductInfo(self, ProductId: number, InfoType: InfoType): any
	function GetWorldProductsAsync(self): Pages
	function PromptProductPurchase(self, Player: Player, ProductId: number): ()
	PromptProductPurchaseFinished: ScriptSignal
end

declare class MaterialService extends Instance
	AsphaltName: string
	BarkName: string
	BasicName: string
	BeigeTerrazzoFloor: string
	BrickCeramicTile: string
	BrickName: string
	BrokenConcreteName: string
	BrokenRoof: string
	BrushMetal: string
	CementWallName: string
	CheckerTileFloorName: string
	ConcreteName: string
	ConcretePlateName: string
	CopperName: string
	CorrugatedSteelName: string
	CrackedMiddleCeramicTileName: string
	CrackedSmallCeramicTileName: string
	DamagedRoofName: string
	DistroyedBronzeName: string
	EmeraldGridTile: string
	GalvanizedMetal: string
	GlassName: string
	GrassName: string
	GreyWovenFabric: string
	GridBorder: string
	GridBoxName: string
	GridMarbleName: string
	GridPentagonName: string
	GridQuadName: string
	GridTileName: string
	GroundName: string
	HalfLeafyGroundName: string
	HouseBricksName: string
	IndustrialRibbedSteel: string
	LeafyGroundName: string
	MarbleName: string
	MetalName: string
	MetalPlateName: string
	MixRoadName: string
	MosaicCarpetName: string
	MossyGroundName: string
	MossyRockName: string
	OceanPanelTile: string
	OfficeCeilingWhiteName: string
	PaintedMetal: string
	PaintedWood: string
	PavingBlockName: string
	PavingBrickName: string
	PavingFloorName: string
	PavingName: string
	PavingStonesName: string
	PavingWallName: string
	PeelingPaintSteel: string
	PlankName: string
	PlasticName: string
	RoadName: string
	RockName: string
	RoofName: string
	RustBrassName: string
	RustName: string
	RustySteel: string
	SandName: string
	SandstoneBrick: string
	SilverMetalName: string
	SmallBrickName: string
	SnowName: string
	SoilRockGroundName: string
	SquareCeramicTile: string
	StoneBrickName: string
	StoneFloorName: string
	TakenOffCeramicTileName: string
	TerrazzoFloorName: string
	ThickCarpet: string
	UnlitName: string
	UrbanSlateFloor: string
	WeatheredPlasterBrick: string
	WhiteCementBrick: string
	WhiteGrayBrickName: string
	WoodName: string
	function GetBaseMaterialOverride(self, InMaterial: Material): string
	function GetMaterialVariant(self, InMaterial: Material, InName: string): MaterialVariant
	function SetBaseMaterialOverride(self, InMaterial: Material, InName: string): ()
end

declare class MaterialVariant extends Instance
	BaseMaterial: Material
	Color: Color3
	ColorMap: Content
	CustomPhysicalProperties: PhysicalProperties
	Emissive: Color3
	EmissiveIntensity: number
	EmissiveMap: Content
	Metalness: number
	MetalnessMap: Content
	MetersPerTile: number
	NormalMap: Content
	Roughness: number
	RoughnessMap: Content
end

declare class MeshPart extends BasePart
	DoubleSided: boolean
	EnableMeshShadowDetails: boolean
	MeshId: string
	MeshShadowDetailLevel: ShadowDetailLevel
	MeshSize: Vector3
	TextureId: string
	function ApplyMesh(self, InMeshPart: Instance): ()
end

declare class Model extends PVInstance
	PrimaryPart: BasePart
	WorldPivot: CFrame
	function BreakJoints(self): ()
	function GetPivot(self): CFrame
	function MoveTo(self, InPosition: Vector3): ()
	function PivotTo(self, InTargetCFrame: CFrame): ()
	function SetPrimaryPartCFrame(self, InNewCFrame: CFrame): ()
end

declare class ModuleScript extends LuaSourceContainer
end

declare class Mouse extends Instance
	Hit: CFrame
	Origin: CFrame
	Target: BasePart
	ViewSizeX: number
	ViewSizeY: number
	X: number
	Y: number
	Button1Down: ScriptSignal
	Button1Up: ScriptSignal
	Button2Down: ScriptSignal
	Button2Up: ScriptSignal
	TouchEnded: ScriptSignal
	TouchStarted: ScriptSignal
end

declare class NumberValue extends ValueBase
	Value: number
	Changed: ScriptSignal
end

declare class OrderedDataStore extends GlobalDataStore
end

declare class Outline extends OverlayBase
	Color: Color3
	Thickness: number
end

declare class ParticleEmitter extends Instance
	Acceleration: Vector3
	Brightness: number
	Color: ColorSequence
	Drag: number
	EmissionDirection: NormalId
	Enabled: boolean
	FlipbookFramerate: NumberRange
	FlipbookLayout: ParticleFlipbookLayout
	FlipbookMode: ParticleFlipbookMode
	FlipbookStartRandom: boolean
	LifeTime: NumberRange
	LightEmission: number
	LockedToPart: boolean
	Orientation: ParticleOrientation
	Rate: number
	RotSpeed: number
	Rotation: NumberRange
	Shape: ParticleEmitterShape
	ShapeInOut: ParticleEmitterShapeInOut
	ShapeStyle: ParticleEmitterShapeStyle
	Size: NumberSequence
	Speed: NumberRange
	SpreadAngle: number
	Squash: NumberSequence
	Texture: string
	Transparency: NumberSequence
	function Clear(self): ()
	function Emit(self, ParticleCount: number): ()
end

declare class PhysicsService extends Instance
	function CollisionGroupSetCollidable(self, Group1: string, Group2: string, bCollidable: boolean): ()
	function CollisionGroupsAreCollidable(self, Group1: string, Group2: string): boolean
	function GetMaxCollisionGroups(self): any
	function GetRegisteredCollisionGroups(self): {any}
	function IsCollisionGroupRegistered(self, Group: string): boolean
	function RegisterCollisionGroup(self, Group: string): ()
	function RenameCollisionGroup(self, FromGroup: string, ToGroup: string): ()
	function UnregisterCollisionGroup(self, Group: string): ()
end

declare class Player extends Instance
	CameraMaxZoomDistance: number
	CameraMinZoomDistance: number
	Character: Model
	RespawnLocation: SpawnLocation
	Team: Team
	TeamColor: BrickColor
	UserId: string
	function GetMouse(self): Mouse
	function GetNetworkPing(self): number
	function LoadCharacter(self): ()
	function RemoveCharacter(self): ()
	CharacterAdded: ScriptSignal
	CharacterRemoving: ScriptSignal
end

declare class PlayerGui extends Instance
end

declare class Players extends Instance
	CharacterAutoLoads: boolean
	LocalPlayer: Player
	RespawnTime: number
	UseStrafingAnimations: boolean
	function GetPlayerByUserId(self, UserId: string): Player
	function GetPlayerFromCharacter(self, InCharacter: Model): Player
	function GetPlayers(self): {any}
	PlayerAdded: ScriptSignal
	PlayerRemoving: ScriptSignal
end

declare class PlayerScripts extends Instance
end

declare class PointLight extends Light
	Range: number
end

declare class RemoteEvent extends Instance
	function FireAllClients(self, Arguments: any): ()
	function FireClient(self, Player: Player, Arguments: any): ()
	function FireServer(self, Arguments: any): ()
	OnClientEvent: ScriptSignal
	OnServerEvent: ScriptSignal
end

declare class ReplicatedStorage extends Instance
end

declare class RunService extends Instance
	ClientGitHash: string
	function IsClient(self): boolean
	function IsServer(self): boolean
	function IsStudio(self): boolean
	Heartbeat: ScriptSignal
	RenderStepped: ScriptSignal
	Stepped: ScriptSignal
end

declare class ScreenGui extends LayerCollector
	DisplayOrder: number
end

declare class Script extends BaseScript
end

declare class ScrollingFrame extends GuiObject
	AbsoluteCanvasSize: Vector2
	AbsoluteWindowSize: Vector2
	AutomaticCanvasSize: any
	CanvasPosition: Vector2
	CanvasSize: UDim2
	ScrollBarImageColor3: Color3
	ScrollBarImageTransparency: number
	ScrollBarThickness: number
	ScrollingDirection: any
	ScrollingEnabled: boolean
	function MoveToSlot(self, SlotIndex: number): ()
end

declare class ServerScriptService extends Instance
end

declare class ServerStorage extends Instance
end

declare class SimulationBall extends PVInstance
	BallRadius: number
	BallState: BallState
	CFrame: CFrame
	Color: Color3
	EnablePathMarker: boolean
	IsPathMarkerWorldSpace: boolean
	Material: Material
	MaterialVariant: string
	PathMarkerScale: number
	SlomoFactor: number
	TextureId: string
	function FindNextBallBounce(self): BallBounce
	function GetAngularVelocityAtTime(self, Time: number): Vector3
	function GetBallBounceByIndex(self, bounceIndex: number): BallBounce
	function GetBallSnapshots(self): {any}
	function GetBestDirectionToTargetAtTime(self, InPlaybackTime: number, InTargetPosition: Vector3, InSpeed: number, SpinAxis: Vector3, InSpinSpeed: number, InStepCount: number, InTargetRadius: number, InMaxSampleCount: number): Vector3
	function GetCFrameAtTime(self, Time: number): CFrame
	function GetCurrentPlaybackPosition(self): Vector3
	function GetCurrentSnapshotIndex(self): number
	function GetLinearVelocityAtTime(self, Time: number): Vector3
	function GetRemainedTimeForNextBounce(self): number
	function GetSpeedAtTime(self, Time: number): number
	function IsValidBounceIndex(self, bounceIndex: number): boolean
	function Pause(self): ()
	function Play(self): ()
	function ReSimulateSpinToTargetWithDelay(self, InDelayTime: number, InTargetPosition: Vector3, InSpeed: number, InSpinAxis: Vector3, InSpinSpeed: number, InStepCount: number): boolean
	function ReSimulateToTargetWithDelay(self, InDelayTime: number, InTargetPosition: Vector3, InSpeed: number, InStepCount: number): boolean
	function ReSimulateWithDelay(self, InDelayTime: number, InDirection: Vector3, InSpeed: number, InSpinAxis: Vector3, InSpinSpeed: number, InStepCount: number): ()
	function SetPlaybackTime(self, Time: number): ()
	function Simulate(self, InBallSimParams: BallSimParams): {any}
	function Stop(self): ()
	Bounded: ScriptSignal
	Paused: ScriptSignal
	Played: ScriptSignal
	Stopped: ScriptSignal
	TouchEnded: ScriptSignal
	Touched: ScriptSignal
end

declare class Skeleton extends PVInstance
end

declare class Sound extends Instance
	IsLoaded: boolean
	IsPaused: boolean
	IsPlaying: boolean
	LoopRegion: NumberRange
	Looped: boolean
	PlayOnRemove: boolean
	PlaybackLoudness: number
	PlaybackRegion: NumberRange
	PlaybackRegionsEnabled: boolean
	PlaybackSpeed: number
	Playing: boolean
	RollOffMaxDistance: number
	RollOffMinDistance: number
	RollOffMode: RollOffMode
	SoundGroup: SoundGroup
	SoundId: string
	StartTimePosition: number
	TimeLength: number
	TimePosition: number
	Volume: number
	function Pause(self): ()
	function Play(self): ()
	function Resume(self): ()
	function Stop(self): ()
	Ended: ScriptSignal
	Loaded: ScriptSignal
	Paused: ScriptSignal
	Played: ScriptSignal
	Resumed: ScriptSignal
	Stopped: ScriptSignal
end

declare class SoundGroup extends Instance
	Volume: number
end

declare class SoundService extends Instance
	DistanceFactor: number
	DopplerScale: number
	RespectFilteringEnabled: boolean
	RolloffScale: number
end

declare class SpawnLocation extends FormFactorPart
	Enabled: boolean
	Neutral: boolean
	TeamColor: BrickColor
end

declare class SpotLight extends Light
	Angle: number
	Face: NormalId
	Range: number
end

declare class StarterCharacterScripts extends Instance
end

declare class StarterGui extends Instance
	function GetCoreGuiEnabled(self, CoreGuiType: CoreGuiType): boolean
	function SetCoreGuiEnabled(self, CoreGuiType: CoreGuiType, Enabled: boolean): ()
end

declare class StarterPack extends Instance
end

declare class StarterPlayer extends Instance
	AirControl: number
	AllowCustomAnimations: number
	CameraMaxZoomDistance: number
	CameraMinZoomDistance: number
	CapsuleHeight: number
	CapsuleRadius: number
	CharacterMeshPos: Vector3
	FallingDeceleration: number
	FallingLateralFriction: number
	GravityScale: number
	GroundFriction: number
	IgnoreBaseRotation: boolean
	JumpHeight: number
	JumpPower: number
	LoadCharacterAppearance: boolean
	MaxAcceleration: number
	MaxJumpCount: number
	MaxSlopeAngle: number
	RotationSpeed: number
	StompJumpMultiplier: number
	UseJumpPower: boolean
	WalkSpeed: number
	WalkingDeceleration: number
end

declare class StarterPlayerScripts extends Instance
end

declare class StringValue extends ValueBase
	Value: string
	Changed: ScriptSignal
end

declare class SurfaceGui extends SurfaceGuiBase
	Face: NormalId
	ZOffset: number
end

declare class Team extends Instance
	TeamColor: BrickColor
	PlayerAdded: ScriptSignal
	PlayerRemoved: ScriptSignal
end

declare class Teams extends Instance
end

declare class TeleportService extends Instance
end

declare class TextButton extends GuiButton
	Bold: boolean
	Text: string
	TextBounds: Vector2
	TextColor3: Color3
	TextFits: boolean
	TextScaled: boolean
	TextSize: number
	TextTransparency: number
	TextWrapped: boolean
	TextXAlignment: TextXAlignment
	TextYAlignment: TextYAlignment
end

declare class TextLabel extends GuiObject
	Bold: boolean
	Text: string
	TextBounds: Vector2
	TextColor3: Color3
	TextFits: boolean
	TextScaled: boolean
	TextSize: number
	TextTransparency: number
	TextWrapped: boolean
	TextXAlignment: TextXAlignment
	TextYAlignment: TextYAlignment
end

declare class Tool extends BackpackItem
	CanBeDropped: boolean
	Enabled: boolean
	Grip: CFrame
	GripForward: Vector3
	GripPos: Vector3
	GripRight: Vector3
	GripUp: Vector3
	ManualActivationOnly: boolean
	RequiresHandle: boolean
	ToolTip: string
	function Activate(self): ()
	function Deactivate(self): ()
	Activated: ScriptSignal
	Deactivated: ScriptSignal
	Equipped: ScriptSignal
	Unequipped: ScriptSignal
end

declare class Trail extends Instance
	Color: ColorSequence
	Enabled: boolean
	Lifetime: number
	Offset: Vector3
	Texture: string
	TextureLength: number
	TextureSpeed: number
	Transparency: NumberSequence
	Width: number
	WidthScale: NumberSequence
end

declare class TweenBase extends Instance
	PlaybackState: PlaybackState
	function Cancel(self): ()
	function Pause(self): ()
	function Play(self): ()
	Completed: ScriptSignal
end

declare class Tween extends TweenBase
	Instance: Instance
	TweenInfo: TweenInfo
	function Cancel(self): ()
	function Pause(self): ()
	function Play(self): ()
end

declare class TweenService extends Instance
	function Create(self, Instance: Instance, TweenInfo: TweenInfo, PropertyTable: any): Instance
end

declare class UIAspectRatioConstraint extends Instance
	AspectRatio: number
	AspectType: AspectType
	DominantAxis: DominantAxis
end

declare class UIGridStyleLayout extends Instance
	AbsoluteContentSize: Vector2
	FillDirection: any
	HorizontalAlignment: any
	SortOrder: any
	VerticalAlignment: any
end

declare class UIGridLayout extends UIGridStyleLayout
	AbsoluteCellCount: Vector2
	AbsoluteCellSize: Vector2
	CellPadding: UDim2
	CellSize: UDim2
	FillDirectionMaxCells: number
end

declare class UIListLayout extends UIGridStyleLayout
	Padding: UDim
	Wraps: boolean
end

declare class UserGameSettings extends Instance
	CharacterTurnRate: number
	RotationType: RotationType
end

declare class UserInputService extends Instance
	InputBegan: ScriptSignal
	InputChanged: ScriptSignal
	InputEnded: ScriptSignal
	TouchEnded: ScriptSignal
	TouchMoved: ScriptSignal
	TouchStarted: ScriptSignal
end

declare class UserSettings extends GenericSettings
	GameSettings: UserGameSettings
end

declare class VectorForce extends Constraint
	ApplyAtCenterOfMass: boolean
	Force: Vector3
	RelativeTo: ActuatorRelativeTo
end

declare class VFXPreset extends Instance
	Color: ColorSequence
	Enabled: boolean
	InfiniteLoop: boolean
	LoopCount: number
	Size: number
	Transparency: number
	function Clear(self): ()
end

declare class WorldRoot extends Instance
	function Blockcast(self, InCFrame: CFrame, InExtents: Vector3, InDirection: Vector3, InRaycastParams: RaycastParams?): RaycastResult
	function Capsulecast(self, InCFrame: CFrame, InRadius: number, InHeight: number, InDirection: Vector3, InRaycastParams: RaycastParams?): RaycastResult
	function DrawRay(self, InOrigin: Vector3, InDirection: Vector3, InColor: Color3, InThickness: number, InLifeTime: number): ()
	function GetPartBoundsInBox(self, InCenter: CFrame, InSize: Vector3, InOverlapParams: OverlapParams?): {any}
	function GetPartBoundsInSphere(self, InCenter: CFrame, InRadius: number, InOverlapParams: OverlapParams?): {any}
	function GetPartsInPart(self, InBasePart: BasePart, InOverlapParams: OverlapParams?): {any}
	function PredictProjectilePathByObject(self, PredictParams: any, InObjectParams: any): any
	function Raycast(self, InOrigin: Vector3, InDirection: Vector3, InRaycastParams: RaycastParams?): RaycastResult
	function RaycastDeprecated(self, InOrigin: Vector3, InDirection: Vector3, InRaycastParams: RaycastParams?): RaycastResult
	function RaycastMulti(self, InOrigin: Vector3, InDirection: Vector3, InRaycastParams: RaycastParams?): {any}
	function RaycastMultiByObject(self, InOrigin: Vector3, InDirection: Vector3, InQueryParams: any): {any}
	function RaycastSingleByObject(self, InOrigin: Vector3, InDirection: Vector3, InQueryParams: any): RaycastResult
	function Spherecast(self, InOrigin: Vector3, InRadius: number, InDirection: Vector3, InRaycastParams: RaycastParams?): RaycastResult
end

declare class Workspace extends WorldRoot
	CurrentCamera: Camera
	Gravity: number
	HitboxType: HitboxType
	function GetServerTimeNow(self): number
end

declare class WorldRankService extends Instance
	function GetDisplayEnabled(self): boolean
	function GetScore(self, Player: Player): number
	function IncrementScore(self, Player: Player, Score: number): ()
	function SetDisplayEnabled(self, Enabled: boolean): ()
end

declare class WrapLayer extends Instance
	Order: number
end

declare class WrapTarget extends Instance
end

-- Globals
declare game: DataModel
declare workspace: Workspace
declare script: BaseScript

declare Instance: {
	new: (className: "Part") -> Part,
	new: (className: "MeshPart") -> MeshPart,
	new: (className: "Model") -> Model,
	new: (className: "Folder") -> Folder,
	new: (className: "BillboardGui") -> BillboardGui,
	new: (className: "ScreenGui") -> ScreenGui,
	new: (className: "SurfaceGui") -> SurfaceGui,
	new: (className: "Frame") -> Frame,
	new: (className: "TextLabel") -> TextLabel,
	new: (className: "TextButton") -> TextButton,
	new: (className: "ImageLabel") -> ImageLabel,
	new: (className: "ImageButton") -> ImageButton,
	new: (className: "Script") -> Script,
	new: (className: "LocalScript") -> LocalScript,
	new: (className: "ModuleScript") -> ModuleScript,
	new: (className: "Sound") -> Sound,
	new: (className: "ParticleEmitter") -> ParticleEmitter,
	new: (className: "Light") -> Light,
	new: (className: "Attachment") -> Attachment,
	new: (className: "Animation") -> Animation,
	new: (className: "Animator") -> Animator,
	new: (className: "Humanoid") -> Humanoid,
	new: (className: "IntValue") -> IntValue,
	new: (className: "StringValue") -> StringValue,
	new: (className: "BoolValue") -> BoolValue,
	new: (className: "NumberValue") -> NumberValue,
	new: (className: string) -> Instance,
}

declare task: {
	wait: (duration: number?) -> number
}
