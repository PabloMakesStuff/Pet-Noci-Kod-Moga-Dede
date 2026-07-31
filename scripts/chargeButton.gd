extends TextureButton
var isActive : bool = false

const MAX_CHARGE := 100.0
const MIN_CHARGE := 0.0

func _ready() -> void:
	$DischargeTimer.timeout.connect(discharge)

func discharge() -> void:
	Global.aleksaChargePercent = max(MIN_CHARGE, Global.aleksaChargePercent - 0.5)

func _process(delta: float) -> void:
	if Global.currentCamera == 'bathroom' and Global.AI['aleksa'] != 0:
		$".".visible = true
		$Percentage.visible = true
	else:
		$".".visible = false
		$Percentage.visible = false

func _on_button_down() -> void:
	if isActive:
		return  # guard against a duplicate press starting a second loop
	isActive = true
	$DischargeTimer.stop()
	while isActive:
		Global.aleksaChargePercent = min(MAX_CHARGE, Global.aleksaChargePercent + 1.0)
		await $ChargeTimer.timeout

func _on_button_up() -> void:
	isActive = false
	$DischargeTimer.start()
